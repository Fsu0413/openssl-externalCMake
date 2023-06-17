# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/property/property_string.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/property/property_parse.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/property/property_query.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/property/property.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/property/defn_cache.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/property/property_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/property/property_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
