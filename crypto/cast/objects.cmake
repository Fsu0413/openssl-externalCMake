# SPDX-License-Identifier: Unlicense

perlasm_generate_src(cast-586.S ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/asm/cast-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
                 ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/cbc.pl
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_cfb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_ofb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/cast_s.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/cast_local.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_enc.c
)
# CAST assembler is not PIC
if ( OPENSSL_ASM AND NOT CMAKE_POSITION_INDEPENDENT_CODE )
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            cast-586.S${OPENSSL_ASM_PREPROCESSED_X86}
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
