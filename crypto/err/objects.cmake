# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/err/err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/err/err_all.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/err/err_prn.c
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
