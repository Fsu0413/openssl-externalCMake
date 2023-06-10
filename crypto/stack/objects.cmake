# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/stack/stack.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/stack/stack.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/stack/safestack.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
