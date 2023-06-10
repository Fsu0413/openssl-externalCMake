# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_cbc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_cfb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_ofb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/idea_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
