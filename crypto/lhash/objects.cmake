# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/lhash/lhash.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/lhash/lh_stats.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/lhash/lhash.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
