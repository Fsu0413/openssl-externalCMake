# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_adrs.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_dsa.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_dsa_hash_ctx.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_dsa_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_fors.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_hash.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_hypertree.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_params.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_wots.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/slh_dsa/slh_xmss.c
)

