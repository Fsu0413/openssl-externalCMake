# SPDX-License-Identifier: Unlicense

if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DWHIRLPOOL_ASM")
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        if (NOT OPENSSL_386)
            set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DWHIRLPOOL_ASM")
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        # no-asm
    endif()
endif()
