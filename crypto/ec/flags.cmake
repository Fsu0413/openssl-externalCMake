# SPDX-License-Identifier: Unlicense

if (OPENSSL_ASM)
    if (  OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DECP_NISTZ256_ASM")
        if ( OPENSSL_ECX )
            set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DX25519_ASM")
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DECP_NISTZ256_ASM")
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DECP_NISTZ256_ASM")
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DECP_NISTZ256_ASM")
        if (OPENSSL_SM2)
            set(LIBCRYPTO_CURRENTDIR_CFLAGS ${LIBCRYPTO_CURRENTDIR_CFLAGS} "-DECP_SM2P256_ASM")
        endif()
    endif()
endif()
