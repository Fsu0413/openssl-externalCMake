#!/bin/sh
# SPDX-License-Identifier: Unlicense
# Verify the vendored openssl/ tree against openssl.upstream and the official
# OpenSSL project SHA-256 for openssl-<version>.tar.gz.
#
# Usage:
#   scripts/verify-openssl-upstream.sh [--download]
#
# --download  Fetch the official tarball and hash it locally (in addition to
#             checking the published .sha256 files).

set -eu

DOWNLOAD=0
for arg in "$@"; do
    case "$arg" in
        --download) DOWNLOAD=1 ;;
        -h|--help)
            echo "Usage: $0 [--download]"
            exit 0
            ;;
        *)
            echo "Unknown argument: $arg" >&2
            exit 2
            ;;
    esac
done

ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
PIN="${ROOT}/openssl.upstream"
VERSION_DAT="${ROOT}/openssl/VERSION.dat"

die() {
    echo "ERROR: $*" >&2
    exit 1
}

info() {
    echo "$*"
}

[ -f "$PIN" ] || die "missing pin file: $PIN"
[ -f "$VERSION_DAT" ] || die "missing OpenSSL VERSION.dat: $VERSION_DAT"

VERSION=""
GIT_TAG=""
GIT_COMMIT=""
TARBALL_SHA256=""
TARBALL_URL=""
SHA256_URL=""
SHA256_URL_MIRROR=""

while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
        ''|\#*) continue ;;
    esac
    key="${line%%=*}"
    val="${line#*=}"
    case "$key" in
        VERSION) VERSION="$val" ;;
        GIT_TAG) GIT_TAG="$val" ;;
        GIT_COMMIT) GIT_COMMIT="$val" ;;
        TARBALL_SHA256) TARBALL_SHA256="$val" ;;
        TARBALL_URL) TARBALL_URL="$val" ;;
        SHA256_URL) SHA256_URL="$val" ;;
        SHA256_URL_MIRROR) SHA256_URL_MIRROR="$val" ;;
    esac
done < "$PIN"

[ -n "$VERSION" ] || die "openssl.upstream is missing VERSION"
[ -n "$GIT_COMMIT" ] || die "openssl.upstream is missing GIT_COMMIT"
[ -n "$TARBALL_SHA256" ] || die "openssl.upstream is missing TARBALL_SHA256"
[ ${#TARBALL_SHA256} -eq 64 ] || die "TARBALL_SHA256 is not 64 hex chars"

# shellcheck disable=SC1090
. "$VERSION_DAT"
TREE_VERSION="${MAJOR}.${MINOR}.${PATCH}"
[ "$TREE_VERSION" = "$VERSION" ] || die "openssl/VERSION.dat is ${TREE_VERSION}, pin is ${VERSION}"
info "VERSION.dat matches pin (${VERSION})"

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

git_link_commit() {
    if [ -d "${ROOT}/.git" ] || [ -f "${ROOT}/.git" ]; then
        # Prefer the index (what would be committed), then HEAD.
        git -C "$ROOT" rev-parse --verify ":openssl" 2>/dev/null \
            || git -C "$ROOT" rev-parse --verify "HEAD:openssl" 2>/dev/null \
            || true
    fi
}

worktree_commit() {
    if [ -d "${ROOT}/openssl/.git" ] || [ -f "${ROOT}/openssl/.git" ]; then
        git -C "${ROOT}/openssl" rev-parse HEAD 2>/dev/null || true
    fi
}

LINK_COMMIT="$(git_link_commit)"
WT_COMMIT="$(worktree_commit)"

if [ -n "$LINK_COMMIT" ]; then
    [ "$LINK_COMMIT" = "$GIT_COMMIT" ] || die "openssl gitlink is ${LINK_COMMIT}, pin is ${GIT_COMMIT}"
    info "openssl gitlink matches pin (${GIT_COMMIT})"
else
    info "warning: parent gitlink not available; skipped gitlink check"
fi

if [ -n "$WT_COMMIT" ]; then
    [ "$WT_COMMIT" = "$GIT_COMMIT" ] || die "openssl worktree HEAD is ${WT_COMMIT}, pin is ${GIT_COMMIT}"
    info "openssl worktree HEAD matches pin (${GIT_COMMIT})"
fi

if [ -n "$GIT_TAG" ] && [ -n "$WT_COMMIT" ]; then
    TAG_COMMIT="$(git -C "${ROOT}/openssl" rev-parse "${GIT_TAG}^{commit}" 2>/dev/null || true)"
    if [ -n "$TAG_COMMIT" ]; then
        [ "$TAG_COMMIT" = "$GIT_COMMIT" ] || die "tag ${GIT_TAG} is ${TAG_COMMIT}, pin is ${GIT_COMMIT}"
        info "git tag ${GIT_TAG} matches pin"
    fi
fi

fetch_and_check_published() {
    url="$1"
    label="$2"
    got="$(published_hash_from_url "$url")" || die "failed to fetch ${label} SHA-256 from ${url}"
    [ ${#got} -eq 64 ] || die "${label} SHA-256 from ${url} is not 64 hex chars: ${got}"
    [ "$got" = "$TARBALL_SHA256" ] || die "${label} published SHA-256 ${got} does not match pin ${TARBALL_SHA256}"
    info "${label} published SHA-256 matches pin"
}

command -v curl >/dev/null 2>&1 || die "curl is required to check published SHA-256 files"

if [ -n "$SHA256_URL" ]; then
    fetch_and_check_published "$SHA256_URL" "GitHub release"
fi
if [ -n "$SHA256_URL_MIRROR" ]; then
    fetch_and_check_published "$SHA256_URL_MIRROR" "openssl.org"
fi

if [ "$DOWNLOAD" -eq 1 ]; then
    [ -n "$TARBALL_URL" ] || die "openssl.upstream is missing TARBALL_URL"
    TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/openssl-upstream.XXXXXX")"
    trap 'rm -rf "$TMPDIR"' EXIT INT HUP TERM
    TARBALL="${TMPDIR}/openssl-${VERSION}.tar.gz"
    info "Downloading ${TARBALL_URL}"
    curl -fL --retry 3 -o "$TARBALL" "$TARBALL_URL" || die "failed to download tarball"
    GOT="$(sha256_of_file "$TARBALL")"
    [ "$GOT" = "$TARBALL_SHA256" ] || die "tarball SHA-256 ${GOT} does not match pin ${TARBALL_SHA256}"
    info "downloaded tarball SHA-256 matches pin"
fi

info "OpenSSL upstream ${VERSION} verified"
