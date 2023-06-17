# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/encode_decode/encoder_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/encode_decode/encoder_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/encode_decode/encoder_pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/encode_decode/decoder_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/encode_decode/decoder_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/encode_decode/decoder_pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/encode_decode/encoder_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/encode_decode/decoder_err.c
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
