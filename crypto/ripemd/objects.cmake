# SPDX-License-Identifier: Unlicense

perlasm_generate_src(rmd-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/asm/rmd-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmd_dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmd_one.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmd_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmdconst.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    # empty by default
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            rmd-586${OPENSSL_ASM_PREPROCESSED}
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
