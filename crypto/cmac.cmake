
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cmac/cmac.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cmac/cm_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cmac/cm_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cmac/cmac.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
