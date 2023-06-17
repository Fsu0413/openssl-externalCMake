# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ess/ess_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ess/ess_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ess/ess_lib.c
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
