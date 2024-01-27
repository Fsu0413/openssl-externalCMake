# SPDX-License-Identifier: Unlicense

perlasm_generate_src(wp-mmx.S ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/asm/wp-mmx.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(wp-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/asm/wp-x86_64.pl)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_local.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_block.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            wp-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        if (NOT OPENSSL_386)
            set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
                ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_block.c
                wp-mmx.S${OPENSSL_ASM_PREPROCESSED_X86}
            )
        endif()
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
