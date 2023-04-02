
# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY
perlasm_generate_src(rmd-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/asm/rmd-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS}
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmd_dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmd_one.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/ripemd.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmd_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmdconst.h
)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
    # empty by default
)
if (OPENSSL_ASM)
    if ( ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ( APPLE AND NOT IOS )
    ) )
        # no-asm
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            rmd-586${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DRMD160_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        # no-asm
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm64" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        # no-asm
    endif()
endif()

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES}
    ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
