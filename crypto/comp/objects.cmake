# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/c_rle.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/c_zlib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
