
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_mem.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/store.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/store/str_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
