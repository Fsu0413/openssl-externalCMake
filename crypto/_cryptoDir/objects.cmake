# SPDX-License-Identifier: Unlicense

perlasm_generate_src(x86cpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/x86cpuid.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(x86_64cpuid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/x86_64cpuid.pl)
perlasm_generate_src(ppccpuid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ppccpuid.pl)
perlasm_generate_src(pariscid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/pariscid.pl)
perlasm_generate_src(alphacpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/alphacpuid.pl)
perlasm_generate_src(arm64cpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/arm64cpuid.pl)
perlasm_generate_src(armv4cpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/armv4cpuid.pl)
perlasm_generate_src(s390xcpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/s390xcpuid.pl)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/provider_core.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/provider_predefined.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/core_fetch.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/core_algorithm.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/core_namemap.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/self_test_core.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/provider_conf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/indicator_core.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cryptlib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/params.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/params_from_text.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bsearch.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ex_data.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_str.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/threads_pthread.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/threads_win.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/threads_none.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/initthread.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/context.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sparse_array.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/asn1_dsa.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/packet.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/param_build.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/param_build_set.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/der_writer.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/threads_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/params_dup.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mem.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mem_sec.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/comp_methods.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cversion.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/info.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cpt_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ebcdic.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/uid.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_time.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_dir.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_fopen.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/getenv.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_init.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/init.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/trace.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/provider.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/provider_child.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/punycode.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/passphrase.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/arm_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mips_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/provider_local.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/s390x_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/vms_rms.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/time.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sleep.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sslerr.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ssl_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/deterministic_nonce.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/quic_vlint.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/defaults.c
    params_idx.c
    buildinf.h
)

if (WIN32 OR CYGWIN)
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/dllmain.c
    )
endif()

set(OPENSSL_CPUID_SRCS
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mem_clr.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(OPENSSL_CPUID_SRCS
            x86_64cpuid${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND ( NOT OPENSSL_386 ) )
        set(OPENSSL_CPUID_SRCS
            x86cpuid.S${OPENSSL_ASM_PREPROCESSED_X86}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(OPENSSL_CPUID_SRCS
            armv4cpuid.S
            ${CMAKE_SOURCE_DIR}/openssl/crypto/armcap.c
            ${CMAKE_SOURCE_DIR}/openssl/crypto/arm_arch.h
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(OPENSSL_CPUID_SRCS
            arm64cpuid.S
            ${CMAKE_SOURCE_DIR}/openssl/crypto/armcap.c
            ${CMAKE_SOURCE_DIR}/openssl/crypto/arm_arch.h
        )
    endif()
endif()

set(OPENSSL_CPUID_SRCS
    ${OPENSSL_CPUID_SRCS}
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cpuid.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ctype.c
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${OPENSSL_CPUID_SRCS}
)
