
set(LIBLEGACY_SOURCES
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

    ${CMAKE_SOURCE_DIR}/openssl/providers/legacyprov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/pbkdf1.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/kdfs/pvkkdf.c

    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/provider_ctx.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/provider_util.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/providercommon.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_blowfish.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_cast.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_des.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_idea.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc2.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc4.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc4_hmac_md5.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc5.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_seed.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_default.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/ciphercommon.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/digestcommon.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/implementations.h
    ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include/prov/names.h
)

set(LIBLEGACY_SOURCES_MODULE
    ${CMAKE_SOURCE_DIR}/openssl/providers/prov_running.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/provider_util.c
)

if (OPENSSL_DES)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_desx.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_desx_hw.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_des.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_des_hw.c
    )
    set(LIBLEGACY_SOURCES_MODULE
        ${LIBLEGACY_SOURCES_MODULE}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_tdes_common.c
    )
endif()

if (OPENSSL_BF)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_blowfish.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_blowfish_hw.c
    )
endif()

if (OPENSSL_IDEA)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_idea.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_idea_hw.c
    )
endif()

if (OPENSSL_CAST)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_cast5.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_cast5_hw.c
    )
endif()

if (OPENSSL_SEED)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_seed.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_seed_hw.c
    )
endif()

if (OPENSSL_RC4)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc4.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc4_hw.c
    )
    if (OPENSSL_MD5)
        set(LIBLEGACY_SOURCES
            ${LIBLEGACY_SOURCES}
            ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc4_hmac_md5.c
            ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc4_hmac_md5_hw.c
        )
    endif()
endif()

if (OPENSSL_RC5)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc5.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc5_hw.c
    )
endif()

if (OPENSSL_RC2)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc2.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/ciphers/cipher_rc2_hw.c
    )
endif()

if (OPENSSL_MD2)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/md2_prov.c
    )
endif()

if (OPENSSL_MD4)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/md4_prov.c
    )
endif()

if (OPENSSL_MDC2)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/mdc2_prov.c
    )
endif()

if (OPENSSL_WHIRLPOOL)
    set(LIBLEGACY_SOURCES
        ${LIBLEGACY_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/wp_prov.c
    )
endif()

if (OPENSSL_RMD160)
    set(LIBLEGACY_SOURCES_MODULE
        ${LIBLEGACY_SOURCES_MODULE}
        ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/digests/ripemd_prov.c
    )
endif()

if (NOT OPENSSL_MODULE)
    set(LIBLEGACY_LIBRARY_TYPE OBJECT)
else()
    set(LIBLEGACY_LIBRARY_TYPE MODULE)
    set(LIBLEGACY_SOURCES ${LIBLEGACY_SOURCES} ${LIBLEGACY_SOURCES_MODULE})
endif()

add_library(legacy "${LIBLEGACY_LIBRARY_TYPE}"
    ${LIBLEGACY_SOURCES}
)

set_target_properties(legacy PROPERTIES
    PREFIX ""
)

target_include_directories(legacy
    PRIVATE ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/common/include
            ${CMAKE_BINARY_DIR}/include
            ${CMAKE_SOURCE_DIR}/openssl
            ${CMAKE_SOURCE_DIR}/openssl/include
            ${CMAKE_SOURCE_DIR}/openssl/crypto
            ${CMAKE_BINARY_DIR}/providers/common/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/include
)

# workaround!
set(LIBLEGACY_CFLAGS ${LIBCRYPTO_CFLAGS})
list(REMOVE_ITEM LIBLEGACY_CLFAGS "RC4_ASM")

target_compile_definitions(legacy
    PRIVATE ${LIBLEGACY_CLFAGS}
            -DOPENSSL_BUILDING_OPENSSL
            "-DOPENSSLDIR=\"${OPENSSL_OPENSSLDIR_ABSOLUTE}\""
            "-DENGINESDIR=\"${OPENSSL_ENGINESDIR_ABSOLUTE}\""
            "-DMODULESDIR=\"${OPENSSL_MODULESDIR_ABSOLUTE}\""
)

if (OPENSSL_MODULE)
    install(TARGETS legacy
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}/ossl-modules"
    )
endif()
