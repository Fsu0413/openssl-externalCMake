
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_api.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_def.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_mod.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_mall.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_sap.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_api.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_def.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)