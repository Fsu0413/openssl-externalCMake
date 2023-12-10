# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/randfile.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_deprecated.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/prov_seed.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_pool.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_local.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_uniform.c
)

if ( OPENSSL_EGD )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_egd.c
    )
endif()

if ( OPENSSL_DEPRECATED_3_0 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand_meth.c
    )
endif()

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
