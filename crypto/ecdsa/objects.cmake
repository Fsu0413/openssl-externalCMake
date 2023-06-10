# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_ossl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_vrf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecdsa.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
