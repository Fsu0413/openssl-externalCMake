
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_openssl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_util.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_compat.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_compat.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
