# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/drbg_ctr.c
)

set_source_files_properties(${LIBCRYPTO_CURRENTDIR_SOURCES} PROPERTIES INCLUDE_DIRECTORIES
    "${CMAKE_SOURCE_DIR}/openssl/crypto/modes"
)

set(LIBCRYPTO_CURRENTDIR_SOURCES ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/randfile.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_egd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_win.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_unix.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_vms.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/drbg_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_local.h
)
