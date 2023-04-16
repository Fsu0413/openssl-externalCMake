
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/blake2/blake2b.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/blake2/blake2s.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/blake2/m_blake2b.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/blake2/m_blake2s.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/blake2/blake2_impl.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/blake2/blake2_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
