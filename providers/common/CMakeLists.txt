set(LIBCOMMON_SOURCES
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

    ${CMAKE_SOURCE_DIR}/openssl/providers/common/provider_ctx.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/provider_err.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/ciphercommon.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/ciphercommon_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/ciphercommon_block.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/ciphercommon_gcm.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/ciphercommon_gcm_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/ciphercommon_ccm.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/ciphercommon_ccm_hw.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/digestcommon.c

    ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_rsa_key.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_rsa_sig.c
    ${CMAKE_BINARY_DIR}/providers/common/der/der_rsa_gen.c
    ${CMAKE_BINARY_DIR}/providers/common/der/der_digests_gen.c
    ${CMAKE_BINARY_DIR}/providers/common/der/der_wrap_gen.c
    ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_rsa.h
    ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_digests.h
    ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_wrap.h

    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/tls_pad.c

    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/proverr.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/provider_ctx.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/providercommon.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/ciphercommon_local.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/ciphercommon.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/ciphercommon_ccm.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/ciphercommon_gcm.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/digestcommon.h
)

if (OPENSSL_EC)
    set(LIBCOMMON_SOURCES
        ${LIBCOMMON_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_ec_key.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_ec_sig.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_ecx_key.c
        ${CMAKE_BINARY_DIR}/providers/common/der/der_ec_gen.c
        ${CMAKE_BINARY_DIR}/providers/common/der/der_ecx_gen.c
        ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_ec.h
        ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_ecx.h
    )
endif()

if (OPENSSL_DSA)
    set(LIBCOMMON_SOURCES
        ${LIBCOMMON_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_dsa_key.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_dsa_sig.c
        ${CMAKE_BINARY_DIR}/providers/common/der/der_dsa_gen.c
        ${CMAKE_BINARY_DIR}/providers/common/include/prov/der_dsa.h
    )
endif()

add_library(libcommon OBJECT
    ${LIBCOMMON_SOURCES}
)

add_dependencies(libcommon generate_stackhash generate_der)

target_include_directories(libcommon
    PRIVATE ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/common/include
            ${CMAKE_BINARY_DIR}/include
            ${CMAKE_SOURCE_DIR}/openssl
            ${CMAKE_SOURCE_DIR}/openssl/include
            ${CMAKE_SOURCE_DIR}/openssl/crypto
            ${CMAKE_BINARY_DIR}/providers/common/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/include
)

target_compile_definitions(libcommon
    PRIVATE ${LIBCRYPTO_CFLAGS}
            -DOPENSSL_BUILDING_OPENSSL
            "-DOPENSSLDIR=\"${OPENSSL_OPENSSLDIR_ABSOLUTE}\""
            "-DENGINESDIR=\"${OPENSSL_ENGINESDIR_ABSOLUTE}\""
            "-DMODULESDIR=\"${OPENSSL_MODULESDIR_ABSOLUTE}\""
)
