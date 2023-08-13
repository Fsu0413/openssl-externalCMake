# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes_cbc_hmac_sha1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes_cbc_hmac_sha256.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_camellia.c
)

set_source_files_properties(${LIBCRYPTO_CURRENTDIR_SOURCES} PROPERTIES INCLUDE_DIRECTORIES
    "${CMAKE_SOURCE_DIR}/openssl/crypto/modes"
)

set(LIBCRYPTO_CURRENTDIR_SOURCES ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/encode.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/digest.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_cnf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_des.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_bf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_idea.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_des3.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_rc4.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/names.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_seed.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_xcbc_d.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_rc2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_cast.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_rc5.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_md2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_md4.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_md5.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_sha1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_wp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_md5_sha1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_mdc2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_ripemd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_open.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_seal.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_verify.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_dec.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/bio_md.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/bio_b64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/bio_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/c_allc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/c_alld.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/bio_ok.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_pbe.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p5_crpt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p5_crpt2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/scrypt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_old.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/pmeth_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/pmeth_fn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/pmeth_gn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_sigver.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_rc4_hmac_md5.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_chacha20_poly1305.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/cmeth_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
