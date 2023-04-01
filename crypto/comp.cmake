
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/c_rle.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/c_zlib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
