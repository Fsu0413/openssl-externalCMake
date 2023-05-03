
perlasm_generate_src(x86cpuid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/x86cpuid.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(x86_64cpuid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/x86_64cpuid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ppccpuid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ppccpuid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(pariscid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/pariscid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(alphacpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/alphacpuid.pl
)
perlasm_generate_src(arm64cpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/arm64cpuid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(armv4cpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/armv4cpuid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(s390xcpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/s390xcpuid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cryptlib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mem.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mem_dbg.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cversion.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ex_data.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cpt_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ebcdic.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/uid.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_time.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_str.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_dir.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_fopen.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ctype.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/threads_pthread.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/threads_win.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/threads_none.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/getenv.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_init.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_fips.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mem_sec.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/init.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/arm_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mips_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ppc_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/s390x_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sparc_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/vms_rms.h
    ${CMAKE_SOURCE_DIR}/openssl/e_os.h
    buildinf.h
)

if (WIN32 OR CYGWIN)
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/dllmain.c
    )
endif()

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mem_clr.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            x86_64cpuid${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND ( NOT OPENSSL_386 ) )
        # TODO: properly set up applink and uplink
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            x86cpuid${OPENSSL_ASM_PREPROCESSED}
        )
        if (false)
            if ( WIN32 )
                set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
                    ${LIBCRYPTO_CRYPTODIR_ASM_SOURCES}
                    ${CMAKE_SOURCE_DIR}/ms/applink.c
                    ${CMAKE_SOURCE_DIR}/ms/uplink.c
                    uplink-x86${OPENSSL_ASM_PREPROCESSED}
                )
            endif()
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            armv4cpuid.S
            ${CMAKE_SOURCE_DIR}/openssl/crypto/armcap.c
            ${CMAKE_SOURCE_DIR}/openssl/crypto/arm_arch.h
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            arm64cpuid.S
            ${CMAKE_SOURCE_DIR}/openssl/crypto/armcap.c
            ${CMAKE_SOURCE_DIR}/openssl/crypto/arm_arch.h
        )
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
