
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/buffer/buffer.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/buffer/buf_str.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/buffer/buf_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/buffer/buffer.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)