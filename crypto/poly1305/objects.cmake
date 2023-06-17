# SPDX-License-Identifier: Unlicense

perlasm_generate_src(poly1305-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-sparcv9.pl)
perlasm_generate_src(poly1305-x86.S ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-x86.pl)
perlasm_generate_src(poly1305-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-x86_64.pl)
perlasm_generate_src(poly1305-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-ppc.pl)
perlasm_generate_src(poly1305-ppcfp${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-ppcfp.pl)
perlasm_generate_src(poly1305-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-armv4.pl)
perlasm_generate_src(poly1305-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-armv8.pl)
perlasm_generate_src(poly1305-mips.S ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-mips.pl)
perlasm_generate_src(poly1305-s390x.S ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-s390x.pl)
perlasm_generate_src(poly1305-c64xplus.S ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/asm/poly1305-c64xplus.pl)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/poly1305/poly1305.c
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    # empty by default
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            poly1305-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            poly1305-x86.S${OPENSSL_ASM_PREPROCESSED_X86}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            poly1305-armv4.S
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            poly1305-armv8.S
        )
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
