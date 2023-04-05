
perlasm_generate_src(wp-mmx${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/asm/wp-mmx.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(wp-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/asm/wp-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/whrlpool.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_locl.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_block.c
)
if (OPENSSL_ASM)
    if ( ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ( APPLE AND NOT IOS )
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            wp-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_block.c
            wp-mmx${OPENSSL_ASM_PREPROCESSED}
        )
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

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)