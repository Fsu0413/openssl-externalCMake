
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ech_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ech_ossl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ech_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ech_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ech_kdf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ecdh.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ech_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
