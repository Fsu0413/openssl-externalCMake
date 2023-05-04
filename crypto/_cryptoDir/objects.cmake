
perlasm_generate_src(x86cpuid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/x86cpuid.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(uplink-x86${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/ms/uplink-x86.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(x86_64cpuid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/x86_64cpuid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ppccpuid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ppccpuid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(pariscid${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/pariscid.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(alphacpuid.S ${CMAKE_SOURCE_DIR}/openssl/crypto/alphacpuid.pl
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
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_fips.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_init.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/fips_ers.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/getenv.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/crypto.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/opensslv.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ebcdic.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/symhacks.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ossl_typ.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cryptlib.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/md32_common.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_time.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_str.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/o_dir.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/constant_time_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn_int.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/arm_arch.h
    buildinf.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/mem_clr.c
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
            x86_64cpuid${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND ( NOT OPENSSL_386 ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
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
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/armv4cpuid.S
            ${CMAKE_SOURCE_DIR}/openssl/crypto/armcap.c
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm64" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/arm64cpuid.S
            ${CMAKE_SOURCE_DIR}/openssl/crypto/armcap.c
            ${CMAKE_SOURCE_DIR}/openssl/crypto/mem_clr.c
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
