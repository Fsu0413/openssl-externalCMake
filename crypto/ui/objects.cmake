# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_openssl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_util.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
