
if (OPENSSL_ASM)
    if ( ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ( APPLE AND NOT IOS )
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_IA32_SSE2" "-DOPENSSL_BN_ASM_MONT" "-DOPENSSL_BN_ASM_MONT5" "-DOPENSSL_BN_ASM_GF2m")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_BN_ASM_PART_WORDS" "-DOPENSSL_IA32_SSE2" "-DOPENSSL_BN_ASM_MONT" "-DOPENSSL_BN_ASM_GF2m")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_BN_ASM_MONT" "-DOPENSSL_BN_ASM_GF2m")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm64" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        # no-asm
    endif()
endif()
