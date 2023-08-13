# SPDX-License-Identifier: Unlicense

perlasm_generate_src(ghash-ia64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-ia64.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)
perlasm_generate_src(ghash-x86${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-x86.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(ghash-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesni-gcm-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/aesni-gcm-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ghash-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-sparcv9.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ghash-alpha.S ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-alpha.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ghash-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-parisc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ghashp8-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghashp8-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ghash-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-armv4.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ghashv8-armx.S ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghashv8-armx.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
# catch-all can't be used in CMake
perlasm_generate_src(ghash-c64xplus.S ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-c64xplus.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/cbc128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/ctr128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/cts128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/cfb128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/ofb128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/gcm128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/ccm128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/xts128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/wrap128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/ocb128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/modes_lcl.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    # empty by default
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ghash-x86_64${OPENSSL_ASM_PREPROCESSED}
            aesni-gcm-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ghash-x86${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ghash-armv4.S
            ghashv8-armx.S
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ghashv8-armx.S
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
