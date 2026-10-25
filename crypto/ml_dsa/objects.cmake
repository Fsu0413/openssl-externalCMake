# SPDX-License-Identifier: Unlicense

perlasm_generate_src(ml_dsa_ntt-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/asm/ml_dsa_ntt-x86_64.pl)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/ml_dsa_encoders.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/ml_dsa_key_compress.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/ml_dsa_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/ml_dsa_matrix.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/ml_dsa_ntt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/ml_dsa_params.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/ml_dsa_sample.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ml_dsa/ml_dsa_sign.c
)


if (OPENSSL_ASM AND ( OPENSSL_TARGET_ARCH STREQUAL "x64" ))
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ml_dsa_ntt-x86_64${OPENSSL_ASM_PREPROCESSED}
    )
endif()
