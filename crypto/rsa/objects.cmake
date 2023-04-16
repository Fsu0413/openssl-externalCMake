
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_ossl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_gen.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_saos.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_pk1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_ssl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_none.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_oaep.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_chk.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_pss.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_x931.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_depr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_crpt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_x931g.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_mp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
