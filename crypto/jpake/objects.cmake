# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/jpake/jpake.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/jpake/jpake_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/jpake/jpake.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
