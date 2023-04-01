
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_cbc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_cfb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_ofb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/i_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/idea.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/idea_lcl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
