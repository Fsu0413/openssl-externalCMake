
# What? m4?
# TODO: find_program(m4)
add_custom_command(
    OUTPUT des_enc-sparc.S
    COMMAND m4 -B 8192 ${CMAKE_SOURCE_DIR}/openssl/crypto/des/asm/des_enc.m4 > des_enc-sparc.S
    MAIN_DEPENDENCY ${CMAKE_SOURCE_DIR}/openssl/crypto/des/asm/des_enc.m4
    DEPENDS
    USES_TERMINAL
)

# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY
perlasm_generate_src(dest4-sparcv9${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/des/asm/dest4-sparcv9.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)
perlasm_generate_src(des-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/des/asm/des-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
                 ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/cbc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(crypt586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/des/asm/crypt586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
                 ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/cbc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/set_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/ecb_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/cbc_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/ecb3_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/cfb64enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/cfb64ede.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/cfb_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/ofb64ede.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/enc_read.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/enc_writ.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/ofb64enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/ofb_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/str2key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/pcbc_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/qud_cksm.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/rand_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/fcrypt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/xcbc_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/rpc_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/cbc_cksm.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/ede_cbcm_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/des_old.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/des_old2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/read2pwd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/des.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/des_old.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/des_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/rpc_des.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/spr.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/des_ver.h
)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/des_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/fcrypt_b.c
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
            des-586${OPENSSL_ASM_PREPROCESSED}
            crypt586${OPENSSL_ASM_PREPROCESSED}
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
