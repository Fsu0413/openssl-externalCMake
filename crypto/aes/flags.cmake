# SPDX-License-Identifier: Unlicense

if (OPENSSL_ASM)
    if ( ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ( APPLE AND NOT IOS )
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DAES_ASM" "-DVPAES_ASM" "-DBSAES_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DAES_ASM")
        if (OPENSSL_SSE2)
            set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DVPAES_ASM")
        endif()
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DAES_ASM" "-DBSAES_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm64" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        # no flags set for ASM
    endif()
endif()
