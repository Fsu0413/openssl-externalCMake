# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ffc/ffc_params.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ffc/ffc_params_generate.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ffc/ffc_key_generate.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ffc/ffc_params_validate.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ffc/ffc_key_validate.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ffc/ffc_backend.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ffc/ffc_dh.c
)
