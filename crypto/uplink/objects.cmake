# SPDX-License-Identifier: Unlicense

perlasm_generate_src(uplink-x86.S ${CMAKE_SOURCE_DIR}/openssl/ms/uplink-x86.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
add_custom_command(
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/uplink/uplink-x86_64-fix.pl"
    COMMAND ${CMAKE_COMMAND} "-DSOURCE_DIR=${CMAKE_SOURCE_DIR}" -P "${CMAKE_SOURCE_DIR}/crypto/uplink/patchUplink.cmake" "${CMAKE_SOURCE_DIR}/openssl/ms/uplink-x86_64.pl" "${CMAKE_CURRENT_BINARY_DIR}/uplink/uplink-x86_64-fix.pl"
    MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/ms/uplink-x86_64.pl"
    DEPENDS "${CMAKE_SOURCE_DIR}/crypto/uplink/patchUplink.cmake"
    USES_TERMINAL
)
add_custom_command(
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/uplink/uplink-common.pl"
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_SOURCE_DIR}/openssl/ms/uplink-common.pl" "${CMAKE_CURRENT_BINARY_DIR}/uplink/uplink-common.pl"
    MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/ms/uplink-x86_64.pl"
    USES_TERMINAL
)
add_custom_command(
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/uplink/applink.c"
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_SOURCE_DIR}/openssl/ms/applink.c" "${CMAKE_CURRENT_BINARY_DIR}/uplink/applink.c"
    MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/ms/applink.c"
    USES_TERMINAL
)
perlasm_generate_src(uplink-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_CURRENT_BINARY_DIR}/uplink/uplink-x86_64-fix.pl
    DEPENDENCIES "${CMAKE_CURRENT_BINARY_DIR}/uplink/uplink-common.pl"
                 "${CMAKE_CURRENT_BINARY_DIR}/uplink/applink.c"
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

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
