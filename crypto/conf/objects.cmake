# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_api.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_def.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_mod.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_mall.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_sap.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_ssl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_def.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
