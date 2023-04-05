
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/srp/srp_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/srp/srp_vfy.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/srp/srp.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
