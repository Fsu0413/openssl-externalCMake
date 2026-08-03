# SPDX-License-Identifier: Unlicense

perlasm_generate_src(bn-586.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/bn-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(co-586.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/co-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(x86-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86-mont.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(x86-gf2m.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86-gf2m.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
)
perlasm_generate_src(sparcv9a-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/sparcv9a-mont.pl)
perlasm_generate_src(sparcv9-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/sparcv9-mont.pl)
perlasm_generate_src(vis3-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/vis3-mont.pl)
perlasm_generate_src(sparct4-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/sparct4-mont.pl)
perlasm_generate_src(sparcv9-gf2m.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/sparcv9-gf2m.pl)
perlasm_generate_src(bn-mips.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/mips.pl)
perlasm_generate_src(mips-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/mips-mont.pl)
perlasm_generate_src(s390x-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/s390x-mont.pl)
perlasm_generate_src(s390x-gf2m${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/s390x-gf2m.pl)
perlasm_generate_src(x86_64-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86_64-mont.pl)
perlasm_generate_src(x86_64-mont5${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86_64-mont5.pl)
perlasm_generate_src(x86_64-gf2m${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86_64-gf2m.pl)
perlasm_generate_src(rsaz-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/rsaz-x86_64.pl)
perlasm_generate_src(rsaz-avx2${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/rsaz-avx2.pl)
perlasm_generate_src(rsaz-2k-avx512${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/rsaz-2k-avx512.pl)
perlasm_generate_src(rsaz-3k-avx512${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/rsaz-3k-avx512.pl)
perlasm_generate_src(rsaz-4k-avx512${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/rsaz-4k-avx512.pl)
perlasm_generate_src(ia64-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/ia64-mont.pl)
perlasm_generate_src(parisc-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/parisc-mont.pl)
perlasm_generate_src(bn-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/ppc.pl)
perlasm_generate_src(ppc-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/ppc-mont.pl)
perlasm_generate_src(ppc64-mont${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/ppc64-mont.pl)
perlasm_generate_src(alpha-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/alpha-mont.pl)
perlasm_generate_src(armv4-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/armv4-mont.pl)
perlasm_generate_src(armv4-gf2m.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/armv4-gf2m.pl)
perlasm_generate_src(armv8-mont.S ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/armv8-mont.pl)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_add.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_div.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_exp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_ctx.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_mul.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_mod.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_conv.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_shift.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_word.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_blind.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_kron.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_sqrt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_gcd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_prime.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_sqr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_recp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_mont.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_mpi.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_exp2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_gf2m.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_nist.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_intern.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_dh.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_rsa_fips186_4.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_const.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_print.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_srp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_local.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_prime.h
)

if ( OPENSSL_DEPRECATED_0_9_8 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_depr.c
    )
endif()

if ( OPENSSL_DEPRECATED_3_0 )
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_x931p.c
    )
endif()

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_asm.c
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            x86_64-mont${OPENSSL_ASM_PREPROCESSED}
            x86_64-mont5${OPENSSL_ASM_PREPROCESSED}
            x86_64-gf2m${OPENSSL_ASM_PREPROCESSED}
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/rsaz_exp.c
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/rsaz_exp.h
            rsaz-x86_64${OPENSSL_ASM_PREPROCESSED}
            rsaz-avx2${OPENSSL_ASM_PREPROCESSED}
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/rsaz_exp_x2.c
            rsaz-2k-avx512${OPENSSL_ASM_PREPROCESSED}
            rsaz-3k-avx512${OPENSSL_ASM_PREPROCESSED}
            rsaz-4k-avx512${OPENSSL_ASM_PREPROCESSED}
        )
        if (MSVC)
            set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
                ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
                ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_asm.c
            )
        else()
            set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
                ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
                ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/asm/x86_64-gcc.c
            )
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            bn-586.S${OPENSSL_ASM_PREPROCESSED_X86}
            co-586.S${OPENSSL_ASM_PREPROCESSED_X86}
            x86-mont.S${OPENSSL_ASM_PREPROCESSED_X86}
            x86-gf2m.S${OPENSSL_ASM_PREPROCESSED_X86}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_asm.c
            armv4-mont.S
            armv4-gf2m.S
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn_asm.c
            armv8-mont.S
        )
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
