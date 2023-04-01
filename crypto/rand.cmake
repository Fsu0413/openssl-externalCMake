
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/md_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/randfile.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_egd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_win.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_unix.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_os2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_nw.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
