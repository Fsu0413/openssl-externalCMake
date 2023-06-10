# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_dl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_dlfcn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_openssl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_win32.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_vms.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
