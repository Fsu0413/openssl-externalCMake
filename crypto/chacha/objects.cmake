# SPDX-License-Identifier: Unlicense

perlasm_generate_src(chacha-x86${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-x86.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(chacha-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(chacha-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(chacha-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-armv4.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(chacha-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-armv8.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(chacha-s390x.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-s390x.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(chacha-c64xplus.S ${CMAKE_SOURCE_DIR}/openssl/crypto/chacha/asm/chacha-c64xplus.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

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
            chacha-x86${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            chacha-armv4.S
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            chacha-armv8.S
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
