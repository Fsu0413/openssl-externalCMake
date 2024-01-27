# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store_result.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store_strings.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store_local.h
)

if ( OPENSSL_DEPRECATED_3_0 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store_init.c
        ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store_register.c
    )
endif()
