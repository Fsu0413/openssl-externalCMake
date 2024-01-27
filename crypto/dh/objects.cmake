# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_group_params.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_check.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_backend.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_gen.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_kdf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_rfc5114.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_local.h
)

if ( OPENSSL_DEPRECATED_0_9_8 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_depr.c
    )
endif()
