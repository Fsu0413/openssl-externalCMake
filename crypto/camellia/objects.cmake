# SPDX-License-Identifier: Unlicense

perlasm_generate_src(cmll-x86.S ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/asm/cmll-x86.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(cmll-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/asm/cmll-x86_64.pl)
perlasm_generate_src(cmllt4-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/asm/cmllt4-sparcv9.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/sparcv9_modes.pl
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_ofb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_cfb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_ctr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_local.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/camellia.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_misc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_cbc.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            cmll-x86_64${OPENSSL_ASM_PREPROCESSED}
            ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_misc.c
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            cmll-x86.S${OPENSSL_ASM_PREPROCESSED_X86}
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
