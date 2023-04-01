
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_gen.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_check.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_depr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_rfc5114.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh_kdf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
