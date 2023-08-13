# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/kdf/tls1_prf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/kdf/kdf_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/kdf/hkdf.c
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
