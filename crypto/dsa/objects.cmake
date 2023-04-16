
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_gen.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_vrf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_ossl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_depr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
