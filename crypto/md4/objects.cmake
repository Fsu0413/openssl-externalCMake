# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/md4/md4_dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/md4/md4_one.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/md4/md4_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
