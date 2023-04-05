
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_mem.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
