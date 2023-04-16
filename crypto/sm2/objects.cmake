
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sm2/sm2_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sm2/sm2_crypt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sm2/sm2_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sm2/sm2_pmeth.c
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
