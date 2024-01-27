set(LIBDEFAULT_SOURCES
    ${CMAKE_BINARY_DIR}/include/openssl/opensslv.h
    ${CMAKE_BINARY_DIR}/include/openssl/configuration.h
    ${CMAKE_BINARY_DIR}/include/openssl/asn1.h
    ${CMAKE_BINARY_DIR}/include/openssl/asn1t.h
    ${CMAKE_BINARY_DIR}/include/openssl/bio.h
    ${CMAKE_BINARY_DIR}/include/openssl/cmp.h
    ${CMAKE_BINARY_DIR}/include/openssl/cms.h
    ${CMAKE_BINARY_DIR}/include/openssl/conf.h
    ${CMAKE_BINARY_DIR}/include/openssl/crmf.h
    ${CMAKE_BINARY_DIR}/include/openssl/crypto.h
    ${CMAKE_BINARY_DIR}/include/openssl/ct.h
    ${CMAKE_BINARY_DIR}/include/openssl/err.h
    ${CMAKE_BINARY_DIR}/include/openssl/ess.h
    ${CMAKE_BINARY_DIR}/include/openssl/lhash.h
    ${CMAKE_BINARY_DIR}/include/openssl/ocsp.h
    ${CMAKE_BINARY_DIR}/include/openssl/pkcs7.h
    ${CMAKE_BINARY_DIR}/include/openssl/pkcs12.h
    ${CMAKE_BINARY_DIR}/include/openssl/safestack.h
    ${CMAKE_BINARY_DIR}/include/openssl/srp.h
    ${CMAKE_BINARY_DIR}/include/openssl/ssl.h
    ${CMAKE_BINARY_DIR}/include/openssl/ui.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509_vfy.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509v3.h
    ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_rsa.h
    ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_dsa.h
    ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_ec.h
    ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_ecx.h
    ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_sm2.h

    ${CMAKE_SOURCE_DIR}/openssl/providers/common/bio_prov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/capabilities.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/digest_to_nid.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/provider_seeding.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/provider_util.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/securitycheck.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/securitycheck_default.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/asymciphers/rsa_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_null.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_xts.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_xts_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_gcm.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_gcm_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_ccm.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_ccm_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_wrp.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_cbc_hmac_sha.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_cbc_hmac_sha256_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_cbc_hmac_sha1_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_cts.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_xts_fips.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/sha2_prov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/sha3_prov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/null_prov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/endecoder_common.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/decode_der2key.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/decode_epki2pki.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/decode_pem2der.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/decode_msblob2key.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/decode_pvk2key.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/decode_spki2typespki.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/encode_key2any.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/encode_key2text.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/encode_key2ms.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/exchange/kdf_exch.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/tls1_prf.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/hkdf.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/kbkdf.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/krb5kdf.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/pbkdf2.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/pbkdf2_fips.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/pkcs12kdf.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/sskdf.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/scrypt.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/sshkdf.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/x942kdf.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kem/rsa_kem.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/keymgmt/rsa_kmgmt.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/keymgmt/kdf_legacy_kmgmt.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/keymgmt/mac_legacy_kmgmt.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/macs/gmac_prov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/macs/hmac_prov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/macs/kmac_prov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/seeding/rand_unix.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/seeding/rand_win.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/seeding/rand_tsc.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/seeding/rand_cpu_x86.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/drbg.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/test_rng.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/drbg_ctr.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/drbg_hash.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/drbg_hmac.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/crngt.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/seed_src.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/signature/rsa_sig.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/signature/mac_legacy_sig.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/storemgmt/file_store.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/storemgmt/file_store_any2obj.c

    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_cbc.c

    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/provider_ctx.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/provider_util.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/providercommon.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/securitycheck.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_cbc_hmac_sha.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_ccm.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_cts.inc
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_gcm.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_ocb.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_siv.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_xts.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria_ccm.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria_gcm.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_camellia.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_chacha20.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_chacha20_poly1305.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_cts.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_sm4.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_default.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/blake2_impl.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/endecoder_local.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/blake2.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/ciphercommon.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/ciphercommon_aead.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/digestcommon.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/implementations.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/kdfexchange.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/macsignature.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/md5_sha1.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/seeding.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/pbkdf2.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/drbg_local.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/storemgmt/file_store_local.h
)

if (OPENSSL_SM2)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_sm2_key.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_sm2_sig.c
        ${CMAKE_BINARY_DIR}/providers/common/der/der_sm2_gen.c
        ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_sm2.h
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/asymciphers/sm2_enc.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/signature/sm2_sig.c
    )
endif()

if (OPENSSL_DES)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_common.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_hw.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_default.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_default_hw.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_wrap.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_wrap_hw.c
    )
endif()

if (OPENSSL_SIV)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_siv.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_siv_hw.c
    )
endif()

if (OPENSSL_ARIA)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria_hw.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria_gcm.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria_gcm_hw.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria_ccm.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aria_ccm_hw.c
    )
endif()

if (OPENSSL_CAMELLIA)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_camellia.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_camellia_hw.c
    )
endif()

if (OPENSSL_SM4)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_sm4.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_sm4_hw.c
    )
endif()

if (OPENSSL_OCB)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_ocb.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_aes_ocb_hw.c
    )
endif()

if (OPENSSL_CHACHA)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_chacha20.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_chacha20_hw.c
    )
endif()

if (OPENSSL_POLY1305)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_chacha20_poly1305.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_chacha20_poly1305_hw.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/macs/poly1305_prov.c
    )
endif()

if (OPENSSL_BLAKE2)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/blake2_prov.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/blake2b_prov.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/blake2s_prov.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/macs/blake2b_mac.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/macs/blake2s_mac.c
    )
endif()

if (OPENSSL_SM3)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/sm3_prov.c
    )
endif()

if (OPENSSL_MD5)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/md5_prov.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/md5_sha1_prov.c
    )
endif()

if (OPENSSL_RMD160)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/ripemd_prov.c
    )
endif()

if (OPENSSL_EC)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/encode_decode/encode_key2blob.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/exchange/ecx_exch.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/exchange/ecdh_exch.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/keymgmt/ec_kmgmt.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/keymgmt/ecx_kmgmt.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/signature/eddsa_sig.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/signature/ecdsa_sig.c
    )
endif()

if (OPENSSL_DH)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/exchange/dh_exch.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/keymgmt/dh_kmgmt.c
    )
endif()

if (OPENSSL_DSA)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/keymgmt/dsa_kmgmt.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/signature/dsa_sig.c
    )
endif()

if (OPENSSL_CMAC)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/macs/cmac_prov.c
    )
endif()

if (OPENSSL_SIPHASH)
    set(LIBDEFAULT_SOURCES
        ${LIBDEFAULT_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/macs/siphash_prov.c
    )
endif()

#if (VXWORKS)
#    set(LIBDEFAULT_SOURCES
#        ${LIBDEFAULT_SOURCES}
#        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/seeding/rand_vxworks.c
#    )
#endif()

#if (OPENVMS)
#    set(LIBDEFAULT_SOURCES
#        ${LIBDEFAULT_SOURCES}
#        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/rands/seeding/rand_vms.c
#    )
#endif()

add_library(libdefault STATIC
    ${LIBDEFAULT_SOURCES}
)

add_dependencies(libdefault generate_stackhash generate_der)

target_include_directories(libdefault
    PRIVATE ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/common/include
            ${CMAKE_BINARY_DIR}/include
            ${CMAKE_SOURCE_DIR}/openssl
            ${CMAKE_SOURCE_DIR}/openssl/include
            ${CMAKE_SOURCE_DIR}/openssl/crypto
            ${CMAKE_BINARY_DIR}/providers/common/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/include
)

target_compile_definitions(libdefault
    PRIVATE ${LIBCRYPTO_CFLAGS}
            -DOPENSSL_BUILDING_OPENSSL
            "-DOPENSSLDIR=\"${OPENSSL_OPENSSLDIR_ABSOLUTE}\""
            "-DENGINESDIR=\"${OPENSSL_ENGINESDIR_ABSOLUTE}\""
            "-DMODULESDIR=\"${OPENSSL_MODULESDIR_ABSOLUTE}\""
)
