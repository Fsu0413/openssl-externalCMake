
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/randfile.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_egd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_win.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_unix.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_vms.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/drbg_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/drbg_ctr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
