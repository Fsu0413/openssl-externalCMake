# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_add.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_asn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_attr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_crpt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_crt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_decr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_init.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_kiss.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_mutl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_sbag.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_utl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_npas.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/pk12err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_p8d.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_p8e.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_lcl.h
)
