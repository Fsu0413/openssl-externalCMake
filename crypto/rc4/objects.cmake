# SPDX-License-Identifier: Unlicense

perlasm_generate_src(rc4-586.S ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(rc4-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-x86_64.pl)
perlasm_generate_src(rc4-md5-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-md5-x86_64.pl)
perlasm_generate_src(rc4-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-parisc.pl)
perlasm_generate_src(rc4-s390x${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-s390x.pl)
perlasm_generate_src(rc4-c64xplus.S ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-c64xplus.pl)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    # pure-asm?
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_local.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_enc.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            rc4-x86_64${OPENSSL_ASM_PREPROCESSED}
            rc4-md5-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            rc4-586.S${OPENSSL_ASM_PREPROCESSED_X86}
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
