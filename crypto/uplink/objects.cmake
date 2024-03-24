# SPDX-License-Identifier: Unlicense

perlasm_generate_src(uplink-x86.S ${CMAKE_SOURCE_DIR}/openssl/ms/uplink-x86.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(uplink-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/ms/uplink-x86_64.pl
    DEPENDENCIES "${CMAKE_SOURCE_DIR}/openssl/ms/uplink-common.pl"
                 "${CMAKE_SOURCE_DIR}/openssl/ms/applink.c"
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    # empty
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    # empty
)

if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
    set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/ms/uplink.c
        ${CMAKE_SOURCE_DIR}/openssl/ms/uplink.h
        uplink-x86_64${OPENSSL_ASM_PREPROCESSED}
    )
elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
    if (NOT OPENSSL_386)
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/ms/uplink.c
            ${CMAKE_SOURCE_DIR}/openssl/ms/uplink.h
        )
        if (NOT MSVC)
            set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
                ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
                uplink-x86.S${OPENSSL_ASM_PREPROCESSED_X86}
            )
        endif()
    endif()
elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
    # no-asm
elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
    # no-asm
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
