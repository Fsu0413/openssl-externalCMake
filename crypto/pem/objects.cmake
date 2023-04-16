
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_info.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_all.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_x509.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_xaux.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_oth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_pk8.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem_pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pvkfmt.c
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
