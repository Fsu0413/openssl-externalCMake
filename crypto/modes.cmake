
# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY

perlasm_generate_src(ghash-ia64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-ia64.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT
)
perlasm_generate_src(ghash-x86${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-x86.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(ghash-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(aesni-gcm-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/aesni-gcm-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ghash-sparcv9${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-sparcv9.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT
)
perlasm_generate_src(ghash-alpha.S ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-alpha.pl
)
perlasm_generate_src(ghash-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-parisc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(ghashv8-armx.S ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghashv8-armx.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(ghashp8-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghashp8-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(ghash-armv4.S {CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-armv4.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(ghash-s390x.S ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/asm/ghash-s390x.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/cbc128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/ctr128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/cts128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/cfb128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/ofb128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/gcm128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/ccm128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/xts128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/wrap128.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/modes.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/modes/modes_lcl.h
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
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            ghash-x86_64${OPENSSL_ASM_PREPROCESSED}
            aesni-gcm-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DGHASH_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            ghash-x86${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DGHASH_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            ghash-armv4.S
            ghashv8-armx.S
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DGHASH_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm64" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            ghashv8-armx.S
        )
    endif()
endif()

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES}
    ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
