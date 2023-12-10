# SPDX-License-Identifier: Unlicense

perlasm_generate_src(sm4-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sm4/asm/sm4-armv8.pl)
perlasm_generate_src(vpsm4-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sm4/asm/vpsm4-armv8.pl)
perlasm_generate_src(vpsm4_ex-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sm4/asm/vpsm4_ex-armv8.pl)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sm4/sm4.c
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    # empty by default
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            sm4-armv8.S
            vpsm4-armv8.S
            vpsm4_ex-armv8.S
        )
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
