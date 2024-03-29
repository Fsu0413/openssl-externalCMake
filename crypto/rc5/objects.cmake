# SPDX-License-Identifier: Unlicense

perlasm_generate_src(rc5-586.S ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/asm/rc5-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/cbc.pl
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5cfb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5ofb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5_local.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5_enc.c
)
if (OPENSSL_ASM)
    if (  OPENSSL_TARGET_ARCH STREQUAL "x64" )
        # no-asm
    elseif (  OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            rc5-586.S${OPENSSL_ASM_PREPROCESSED_X86}
        )
    elseif (  OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        # no-asm
    elseif (  OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        # no-asm
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
