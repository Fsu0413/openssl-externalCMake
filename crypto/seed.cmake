
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_cbc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_cfb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_ofb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
