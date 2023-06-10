# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cmac/cmac.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cmac/cm_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cmac/cm_pmeth.c
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
