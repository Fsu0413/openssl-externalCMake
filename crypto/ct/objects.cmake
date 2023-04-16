
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_b64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_log.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_oct.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_policy.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_sct.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_sct_ctx.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_vfy.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_x509v3.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ct/ct_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
