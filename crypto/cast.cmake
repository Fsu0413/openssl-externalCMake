
# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY
perlasm_generate_src(cast-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/asm/cast-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/cbc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_ecb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_cfb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_ofb64.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/cast.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/cast_s.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/cast_lcl.h
)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/c_enc.c
)
# CAST assembler is not PIC
if ( OPENSSL_ASM AND NOT BUILD_SHARED_LIBS )
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
            cast-586${OPENSSL_ASM_PREPROCESSED}
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
