
# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY
perlasm_generate_src(cmll-x86${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/asm/cmll-x86.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(cmll-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/asm/cmll-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(cmllt4-sparcv9${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/asm/cmllt4-sparcv9.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/sparcv9_modes.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_ofb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_cfb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_ctr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_utl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/camellia.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_locl.h
)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/camellia.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_misc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_cbc.c
)
if (OPENSSL_ASM)
    if ( ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ( APPLE AND NOT IOS )
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            cmll-x86_64${OPENSSL_ASM_PREPROCESSED}
            ${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/cmll_misc.c
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            cmll-x86${OPENSSL_ASM_PREPROCESSED}
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

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES}
    ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
