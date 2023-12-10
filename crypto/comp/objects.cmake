# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/c_zlib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp_local.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/c_brotli.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/c_zstd.c
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
