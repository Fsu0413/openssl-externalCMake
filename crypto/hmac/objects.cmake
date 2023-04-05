
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hmac.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hm_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hm_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hmac.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)