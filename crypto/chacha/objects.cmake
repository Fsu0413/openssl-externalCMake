# SPDX-License-Identifier: Unlicense

perlasm_generate_src(chacha-x86.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-x86.pl)
perlasm_generate_src(chacha-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-x86_64.pl)
perlasm_generate_src(chacha-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-ppc.pl)
perlasm_generate_src(chacha-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-armv4.pl)
perlasm_generate_src(chacha-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-armv8.pl)
perlasm_generate_src(chacha-armv8-sve.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-armv8-sve.pl)
perlasm_generate_src(chacha-s390x.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-s390x.pl)
perlasm_generate_src(chacha-c64xplus.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-c64xplus.pl)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    # pure-asm?
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/chacha_enc.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            chacha-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            chacha-x86.S${OPENSSL_ASM_PREPROCESSED_X86}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            chacha-armv4.S
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            chacha-armv8.S
            chacha-armv8-sve.S
        )
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
