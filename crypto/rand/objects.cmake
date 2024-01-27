# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
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
