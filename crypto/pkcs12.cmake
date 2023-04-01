
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_add.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_asn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_attr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_crpt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_crt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_decr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_init.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_kiss.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_mutl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_utl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_npas.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/pk12err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_p8d.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/p12_p8e.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/pkcs12.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
