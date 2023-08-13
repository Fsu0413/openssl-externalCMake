# SPDX-License-Identifier: Unlicense

perlasm_generate_src(rc4-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(rc4-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(rc4-md5-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-md5-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(rc4-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-parisc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
# catch-all can't be used in CMake
perlasm_generate_src(rc4-c64xplus.S ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-c64xplus.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    # pure-asm?
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_locl.h
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            rc4-x86_64${OPENSSL_ASM_PREPROCESSED}
            rc4-md5-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            rc4-586${OPENSSL_ASM_PREPROCESSED}
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

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
