# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_vrf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_ossl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_check.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_backend.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_gen.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_local.h
)

if ( OPENSSL_DEPRECATED_0_9_8 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_depr.c
    )
endif()

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
