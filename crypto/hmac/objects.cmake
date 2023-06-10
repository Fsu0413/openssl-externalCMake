# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hmac.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hm_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hm_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hmac_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
