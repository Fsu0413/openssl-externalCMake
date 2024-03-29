# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_cbc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_cfb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_ofb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_local.h
)
