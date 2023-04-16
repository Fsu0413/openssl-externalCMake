
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/siphash/siphash.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/siphash/siphash_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/siphash/siphash_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/siphash/siphash_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
