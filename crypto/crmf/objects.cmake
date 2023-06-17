# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/crmf/crmf_asn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/crmf/crmf_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/crmf/crmf_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/crmf/crmf_pbm.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/crmf/crmf_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
