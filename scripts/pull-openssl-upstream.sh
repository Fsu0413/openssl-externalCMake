#!/bin/sh
# SPDX-License-Identifier: Unlicense
# Fetch an official OpenSSL release tarball, verify its published SHA-256,
# check out the matching git tag into openssl/, and rewrite openssl.upstream.
#
# Usage:
#   scripts/pull-openssl-upstream.sh <version>
# Example:
#   scripts/pull-openssl-upstream.sh 4.0.2

set -eu

if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 <version>" >&2
    echo "Example: $0 4.0.2" >&2
    exit 2
fi

VERSION="$1"
ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
TAG="openssl-${VERSION}"
TARBALL_URL="https://github.com/openssl/openssl/releases/download/${TAG}/${TAG}.tar.gz"
SHA256_URL="${TARBALL_URL}.sha256"
SHA256_URL_MIRROR="https://www.openssl.org/source/${TAG}.tar.gz.sha256"

die() {
    echo "ERROR: $*" >&2
    exit 1
}

info() {
    echo "$*"
}

sha256_of_file() {
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$1" | awk '{print $1}'
    elif command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$1" | awk '{print $1}'
    else
        openssl dgst -sha256 "$1" | awk '{print $NF}'
    fi
}

published_hash_from_url() {
    url="$1"
    body="$(curl -fsSL "$url")" || return 1
    echo "$body" | awk '{print $1}' | tr -d '\r'
}

command -v curl >/dev/null 2>&1 || die "curl is required"
command -v git >/dev/null 2>&1 || die "git is required"

info "Fetching published SHA-256 for ${TAG}"
PUBLISHED="$(published_hash_from_url "$SHA256_URL")" || die "failed to fetch ${SHA256_URL}"
[ ${#PUBLISHED} -eq 64 ] || die "published SHA-256 is not 64 hex chars: ${PUBLISHED}"

if MIRROR="$(published_hash_from_url "$SHA256_URL_MIRROR" 2>/dev/null)"; then
    [ "$MIRROR" = "$PUBLISHED" ] || die "openssl.org SHA-256 ${MIRROR} does not match GitHub ${PUBLISHED}"
    info "GitHub and openssl.org SHA-256 files match"
fi

TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/openssl-pull.XXXXXX")"
trap 'rm -rf "$TMPDIR"' EXIT INT HUP TERM
TARBALL="${TMPDIR}/${TAG}.tar.gz"

info "Downloading ${TARBALL_URL}"
curl -fL --retry 3 -o "$TARBALL" "$TARBALL_URL" || die "failed to download tarball"
GOT="$(sha256_of_file "$TARBALL")"
[ "$GOT" = "$PUBLISHED" ] || die "tarball SHA-256 ${GOT} does not match published ${PUBLISHED}"
info "tarball SHA-256 verified (${GOT})"

info "Updating openssl gitlink to ${TAG}"
if [ ! -d "${ROOT}/.git/modules/openssl" ] && [ ! -d "${ROOT}/openssl/.git" ] && [ ! -f "${ROOT}/openssl/.git" ]; then
    die "openssl submodule git directory not found; run git submodule update --init first"
fi

if [ -d "${ROOT}/openssl/.git" ] || [ -f "${ROOT}/openssl/.git" ]; then
    OPENSSL_GIT_C="${ROOT}/openssl"
else
    # Submodule git dir lives in the superproject; attach a worktree pointer if needed.
    printf 'gitdir: ../.git/modules/openssl\n' > "${ROOT}/openssl/.git"
    OPENSSL_GIT_C="${ROOT}/openssl"
    git --git-dir="${ROOT}/.git/modules/openssl" --work-tree="${ROOT}/openssl" config --local core.worktree "$(CDPATH= cd -- "${ROOT}/openssl" && pwd)"
fi

git -C "$OPENSSL_GIT_C" fetch --tags origin "${TAG}" || git -C "$OPENSSL_GIT_C" fetch --tags origin
git -C "$OPENSSL_GIT_C" checkout -f "${TAG}"
COMMIT="$(git -C "$OPENSSL_GIT_C" rev-parse "${TAG}^{commit}")"
info "checked out ${TAG} (${COMMIT})"

cat > "${ROOT}/openssl.upstream" <<EOF
# SPDX-License-Identifier: Unlicense
# Pinned official OpenSSL release. Update this file together with the openssl gitlink.
VERSION=${VERSION}
GIT_TAG=${TAG}
GIT_COMMIT=${COMMIT}
TARBALL_SHA256=${PUBLISHED}
TARBALL_URL=${TARBALL_URL}
SHA256_URL=${SHA256_URL}
SHA256_URL_MIRROR=${SHA256_URL_MIRROR}
EOF

info "wrote ${ROOT}/openssl.upstream"
info "OpenSSL ${VERSION} pulled and SHA-256 verified. Stage openssl/ and openssl.upstream, then update CMake source lists if needed."
