#!/bin/sh

REALP="$(cd "$(dirname "$0")" ; pwd)"
. "${REALP}/../../openssl/VERSION.dat"
echo "OPENSSL_VERSION=${MAJOR}.${MINOR}.${PATCH}"
