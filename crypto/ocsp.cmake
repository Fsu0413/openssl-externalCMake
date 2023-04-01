
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_asn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_ext.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_ht.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_cl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_srv.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_vfy.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
