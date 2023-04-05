
perlasm_generate_src(bn-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/bn-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(co-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/co-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(x86-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86-mont.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(x86-gf2m${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86-gf2m.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(sparcv9a-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/sparcv9a-mont.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)
perlasm_generate_src(sparcv9-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/sparcv9-mont.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)
perlasm_generate_src(vis3-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/vis3-mont.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)
perlasm_generate_src(sparct4-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/sparct4-mont.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)
perlasm_generate_src(sparcv9-gf2m.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/sparcv9-gf2m.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
)
# asm/mips3.s - use alternate compiler for compiling when GCC is used
perlasm_generate_src(bn-mips${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/mips.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(mips-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/mips-mont.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(s390x-gf2m${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/s390x-gf2m.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(x86_64-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86_64-mont.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(x86_64-mont5${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86_64-mont5.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(x86_64-gf2m${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86_64-gf2m.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(rsaz-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/rsaz-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(rsaz-avx2${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/rsaz-avx2.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ia64-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/ia64-mont.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT BEFORE
)
perlasm_generate_src(parisc-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/parisc-mont.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(bn-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(ppc-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/ppc-mont.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(ppc64-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/ppc64-mont.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(alpha-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/alpha-mont.pl
)
perlasm_generate_src(armv4-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/armv4-mont.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(mips3-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/mips3-mont.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(via-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/via-mont.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(armv4-gf2m.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/armv4-gf2m.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_add.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_div.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_exp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_ctx.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_mul.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_mod.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_print.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_shift.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_word.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_blind.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_kron.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_sqrt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_gcd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_prime.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_sqr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_recp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_mont.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_mpi.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_exp2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_gf2m.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_nist.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_depr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_const.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_x931p.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_lcl.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_prime.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_asm.c
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
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86_64-gcc.c
            x86_64-mont${OPENSSL_ASM_PREPROCESSED}
            x86_64-mont5${OPENSSL_ASM_PREPROCESSED}
            x86_64-gf2m${OPENSSL_ASM_PREPROCESSED}
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/rsaz_exp.c
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/rsaz_exp.h
            rsaz-x86_64${OPENSSL_ASM_PREPROCESSED}
            rsaz-avx2${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            bn-586${OPENSSL_ASM_PREPROCESSED}
            co-586${OPENSSL_ASM_PREPROCESSED}
            x86-mont${OPENSSL_ASM_PREPROCESSED}
            x86-gf2m${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_asm.c
            armv4-mont.S
            armv4-gf2m.S
        )
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm64" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        # no-asm
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
