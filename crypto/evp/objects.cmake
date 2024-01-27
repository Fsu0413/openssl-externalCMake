# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes_cbc_hmac_sha1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes_cbc_hmac_sha256.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aria.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_sm4.c
)

set_source_files_properties(${LIBCRYPTO_CURRENTDIR_SOURCES} PROPERTIES INCLUDE_DIRECTORIES
    "${CMAKE_SOURCE_DIR}/openssl/crypto/modes"
)

set(LIBCRYPTO_CURRENTDIR_SOURCES ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/digest.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_fetch.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_utils.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/mac_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/mac_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/keymgmt_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/keymgmt_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/kdf_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/kdf_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_sigver.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/pmeth_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/signature.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/pmeth_gn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/exchange.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/asymcipher.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/kem.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/dh_support.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/ec_support.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/pmeth_check.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/encode.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_cnf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_des.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_bf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_idea.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_des3.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_rc4.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/names.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aria.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_sm4.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_xcbc_d.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_rc2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_cast.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_rc5.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/m_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_seal.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_verify.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_legacy.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/bio_md.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/bio_b64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/bio_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/c_allc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/c_alld.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/bio_ok.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_pbe.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p5_crpt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p5_crpt2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/pbe_scrypt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes_cbc_hmac_sha1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_aes_cbc_hmac_sha256.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_rc4_hmac_md5.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_chacha20_poly1305.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_sha.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/ctrl_params_translate.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/cmeth_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/dh_ctrl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/dsa_ctrl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/ec_ctrl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_local.h
)

if ( OPENSSL_DEPRECATED_3_0 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_enc.c
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_dec.c
    )
endif()

if ( OPENSSL_DEPRECATED_0_9_8 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_old.c
    )
endif()

if ( OPENSSL_RSA )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/p_open.c
    )
endif()

if ( OPENSSL_MD2 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_md2.c
    )
endif()

if ( OPENSSL_MD4 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_md4.c
    )
endif()

if ( OPENSSL_MD5 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_md5.c
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_md5_sha1.c
    )
endif()

if ( OPENSSL_MDC2 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_mdc2.c
    )
endif()

if ( OPENSSL_BLAKE2 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_blake2.c
    )
endif()

if ( OPENSSL_WHIRLPOOL )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_wp.c
    )
endif()

if ( OPENSSL_RMD160 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/legacy_ripemd.c
    )
endif()

if ( OPENSSL_SEED )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_seed.c
    )
endif()

if ( OPENSSL_CAMELLIA )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/e_camellia.c
    )
endif()
