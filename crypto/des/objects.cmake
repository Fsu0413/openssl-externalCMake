# SPDX-License-Identifier: Unlicense

# What? m4?
# TODO: find_program(m4)
add_custom_command(
    OUTPUT des_enc-sparc.S
    COMMAND m4 -B 8192 ${CMAKE_SOURCE_DIR}/openssl/crypto/des/asm/des_enc.m4 > des_enc-sparc.S
    MAIN_DEPENDENCY ${CMAKE_SOURCE_DIR}/openssl/crypto/des/asm/des_enc.m4
    DEPENDS
    USES_TERMINAL
)

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

set(LIBCRYPTO_CURRENTDIR_SOURCES
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

set(OPENSSL_DES_ASM_SRCS
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/des_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/des/fcrypt_b.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(OPENSSL_DES_ASM_SRCS
            des-586${OPENSSL_ASM_PREPROCESSED}
            crypt586${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        # no-asm
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        # no-asm
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${OPENSSL_DES_ASM_SRCS}
)
