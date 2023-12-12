#!/bin/sh

REALP="$(cd "$(dirname "$0")" ; pwd)"
echo "OPENSSL_VERSION=$(echo $(head -n 2 "${REALP}/../../openssl/README") | cut -d ' ' -f 2)"
