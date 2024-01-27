# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_list.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_init.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_ctrl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_table.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_fat.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_all.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_rsa.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_dsa.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_dh.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_cipher.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_digest.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_pkmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_asnmth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/tb_eckey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_openssl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_cnf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_dyn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_cryptodev.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_rdrand.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/eng_int.h
)
