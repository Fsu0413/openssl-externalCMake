
# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY

perlasm_generate_src(rc4-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(rc4-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(rc4-md5-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-md5-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
# TODO: special case for rc4-ia64.S, need another cflags. Maybe source file properties?
perlasm_generate_src(rc4-ia64.S ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-ia64.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)
perlasm_generate_src(rc4-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-parisc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(rc4-s390x.S ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/asm/rc4-s390x.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_utl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_locl.h
)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4_enc.c
)
if (OPENSSL_ASM)
    if ( ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            # OR ( APPLE AND NOT IOS )
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            rc4-x86_64${OPENSSL_ASM_PREPROCESSED}
            rc4-md5-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DRC4_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            rc4-586${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DRC4_ASM")
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
