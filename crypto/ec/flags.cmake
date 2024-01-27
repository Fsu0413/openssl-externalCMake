# SPDX-License-Identifier: Unlicense

if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DECP_NISTZ256_ASM")
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        # no-asm
    endif()
endif()
