# SPDX-License-Identifier: Unlicense

perlasm_generate_src(bf-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/asm/bf-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
                 ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/cbc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/bf_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/bf_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/bf_cfb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/bf_ofb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/blowfish.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/bf_pi.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/bf_locl.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/bf_enc.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            bf-586${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        # no-asm
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
