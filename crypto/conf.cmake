
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
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

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
