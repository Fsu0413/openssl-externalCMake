
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_dl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_dlfcn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_openssl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_win32.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_vms.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso_beos.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
