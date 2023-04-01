
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/err/err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/err/err_all.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/err/err_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/err/err.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
