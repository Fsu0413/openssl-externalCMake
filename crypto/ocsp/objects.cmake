# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_asn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_ext.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_http.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_cl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_srv.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_vfy.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/v3_ocsp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_local.h
)
