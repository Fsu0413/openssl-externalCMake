# SPDX-License-Identifier: Unlicense

perlasm_generate_src(aes-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aes-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(vpaes-x86${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/vpaes-x86.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(aesni-x86${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aesni-x86.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(aes-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aes-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(vpaes-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/vpaes-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(bsaes-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/bsaes-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesni-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aesni-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesni-sha1-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aesni-sha1-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesni-sha256-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aesni-sha256-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesni-mb-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aesni-mb-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aes-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aes-sparcv9.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aest4-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aest4-sparcv9.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/sparcv9_modes.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesfx-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aesfx-sparcv9.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aes-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aes-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(vpaes-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/vpaes-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesp8-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aesp8-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aes-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aes-parisc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aes-mips.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aes-mips.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesv8-armx.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aesv8-armx.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(vpaes-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/vpaes-armv8.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aes-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aes-armv4.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(bsaes-armv7.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/bsaes-armv7.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
# catch-all can't be used in CMake
perlasm_generate_src(aes-c64xplus.S ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/asm/aes-c64xplus.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_misc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_cfb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_ofb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_ige.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_wrap.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_locl.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_core.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_cbc.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            aes-x86_64${OPENSSL_ASM_PREPROCESSED}
            vpaes-x86_64${OPENSSL_ASM_PREPROCESSED}
            bsaes-x86_64${OPENSSL_ASM_PREPROCESSED}
            aesni-x86_64${OPENSSL_ASM_PREPROCESSED}
            aesni-sha1-x86_64${OPENSSL_ASM_PREPROCESSED}
            aesni-sha256-x86_64${OPENSSL_ASM_PREPROCESSED}
            aesni-mb-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            aes-586${OPENSSL_ASM_PREPROCESSED}
        )
        if (OPENSSL_SSE2)
            set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
                ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
                vpaes-x86${OPENSSL_ASM_PREPROCESSED}
                aesni-x86${OPENSSL_ASM_PREPROCESSED}
            )
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_cbc.c
            aes-armv4.S
            bsaes-armv7.S
            aesv8-armx.S
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_core.c
            ${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes_cbc.c
            aesv8-armx.S
            vpaes-armv8.S
        )
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
