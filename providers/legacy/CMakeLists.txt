
if (NOT OPENSSL_MODULE)
    set(_LEGACY_LIBRARY_TYPE_AND_RUNNER_FILE STATIC)
else()
    set(_LEGACY_LIBRARY_TYPE_AND_RUNNER_FILE MODULE
        ${CMAKE_SOURCE_DIR}/openssl/providers/prov_running.c
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/provider_util.c
    )
endif()

add_library(legacy ${_LEGACY_LIBRARY_TYPE_AND_RUNNER_FILE}

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
)

target_include_directories(legacy
    PRIVATE ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/common/include
            ${CMAKE_BINARY_DIR}/include
            ${CMAKE_SOURCE_DIR}/openssl
            ${CMAKE_SOURCE_DIR}/openssl/include
            ${CMAKE_SOURCE_DIR}/openssl/crypto
            ${CMAKE_BINARY_DIR}/providers/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/include
)

if (OPENSSL_MODULE)
    install(TARGETS legacy
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}/ossl-modules"
    )
endif()

# D:\openssl\openssl-3.0.9\providers\implementations\ciphers
#$DES_GOAL=../../liblegacy.a
#IF[{- !$disabled{des} -}]
#  SOURCE[$DES_GOAL]=\
#      cipher_desx.c cipher_desx_hw.c \
#      cipher_des.c cipher_des_hw.c
# IF[{- !$disabled{module} -}]
#   SOURCE[$DES_GOAL]=\
#       cipher_tdes_common.c
# ENDIF
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\ciphers
#$BLOWFISH_GOAL=../../liblegacy.a
#IF[{- !$disabled{bf} -}]
#  SOURCE[$BLOWFISH_GOAL]=\
#      cipher_blowfish.c cipher_blowfish_hw.c
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\ciphers
#$IDEA_GOAL=../../liblegacy.a
#IF[{- !$disabled{idea} -}]
#  SOURCE[$IDEA_GOAL]=\
#      cipher_idea.c cipher_idea_hw.c
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\ciphers
#$CAST5_GOAL=../../liblegacy.a
#IF[{- !$disabled{cast} -}]
#  SOURCE[$CAST5_GOAL]=\
#      cipher_cast5.c cipher_cast5_hw.c
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\ciphers
#$SEED_GOAL=../../liblegacy.a
#IF[{- !$disabled{seed} -}]
#  SOURCE[$SEED_GOAL]=\
#      cipher_seed.c cipher_seed_hw.c
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\ciphers
#$RC4_GOAL=../../liblegacy.a
#IF[{- !$disabled{rc4} -}]
#  SOURCE[$RC4_GOAL]=\
#      cipher_rc4.c cipher_rc4_hw.c
# IF[{- !$disabled{md5} -}]
#   SOURCE[$RC4_GOAL]=\
#       cipher_rc4_hmac_md5.c cipher_rc4_hmac_md5_hw.c
# ENDIF
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\ciphers
#$RC5_GOAL=../../liblegacy.a
#IF[{- !$disabled{rc5} -}]
#  SOURCE[$RC5_GOAL]=\
#      cipher_rc5.c cipher_rc5_hw.c
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\ciphers
#$RC2_GOAL=../../liblegacy.a
#IF[{- !$disabled{rc2} -}]
#  SOURCE[$RC2_GOAL]=\
#      cipher_rc2.c cipher_rc2_hw.c
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\digests
#$MD2_GOAL=../../liblegacy.a
#$MD4_GOAL=../../liblegacy.a
#$MDC2_GOAL=../../liblegacy.a
#$WHIRLPOOL_GOAL=../../liblegacy.a

#IF[{- !$disabled{md2} -}]
#  SOURCE[$MD2_GOAL]=md2_prov.c
#ENDIF

#IF[{- !$disabled{md4} -}]
#  SOURCE[$MD4_GOAL]=md4_prov.c
#ENDIF

#IF[{- !$disabled{mdc2} -}]
#  SOURCE[$MDC2_GOAL]=mdc2_prov.c
#ENDIF

#IF[{- !$disabled{whirlpool} -}]
#  SOURCE[$WHIRLPOOL_GOAL]=wp_prov.c
#ENDIF

# D:\openssl\openssl-3.0.9\providers\implementations\digests
#IF[{- !$disabled{module} -}]
#  $RIPEMD_GOAL=../../libdefault.a ../../liblegacy.a
#ELSE
#  $RIPEMD_GOAL=../../libdefault.a
#ENDIF
#IF[{- !$disabled{rmd160} -}]
#  SOURCE[$RIPEMD_GOAL]=ripemd_prov.c
#ENDIF

#D:\openssl\openssl-3.0.9\providers\implementations\kdfs
#$PBKDF1_GOAL=../../liblegacy.a
#SOURCE[$PBKDF1_GOAL]=pbkdf1.c
