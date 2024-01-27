# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/pk7_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/pk7_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/pkcs7err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/pk7_doit.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/pk7_smime.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/pk7_attr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/pk7_mime.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/bio_pk7.c
)
