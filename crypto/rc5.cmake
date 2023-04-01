
# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY

perlasm_generate_src(rc5-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/asm/rc5-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/cbc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS}
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5cfb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5ofb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5_locl.h
)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5_enc.c
)
if (OPENSSL_ASM)
    if ( ( ( CMAKE_SYSTEM_PROCESSOR MATCHES "[Xx]86[_\\-]64" ) OR ( CMAKE_SYSTEM_PROCESSOR MATCHES "[Aa][Mm][Dd]64" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR ( WIN32 AND NOT MSVC )
            OR ( APPLE AND NOT IOS )
    ) ) OR ( OPENSSL_PERLASM_MSVC_X86_64 ) )
        # no-asm
    elseif ( ( ( CMAKE_SYSTEM_PROCESSOR MATCHES "i[2-7]86" ) OR ( CMAKE_SYSTEM_PROCESSOR MATCHES "[Xx]86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR ( WIN32 AND NOT MSVC )
            OR ANDROID
    ) ) OR ( OPENSSL_PERLASM_MSVC_I386 ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            rc5-586${OPENSSL_ASM_PREPROCESSED}
        )
    elseif (( CMAKE_SYSTEM_PROCESSOR MATCHES "armv\\d(-a)?") AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        # no-asm
    elseif (( CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64" ) AND (
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
