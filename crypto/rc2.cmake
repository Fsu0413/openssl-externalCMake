
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2_cbc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2cfb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2ofb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
