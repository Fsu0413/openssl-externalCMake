# SPDX-License-Identifier: Unlicense

perlasm_generate_src(ecp_nistz256-x86${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-x86.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(ecp_nistz256-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ecp_nistz256-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-sparcv9.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ecp_nistz256-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-armv4.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ecp_nistz256-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-armv8.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ecp_nistz256-ppc64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-ppc64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(x25519-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/x25519-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(x25519-ppc64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/x25519-ppc64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/arch_32/f_impl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/f_generic.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/scalar.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/curve448_tables.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/eddsa.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/curve448.c
)

set_source_files_properties(${LIBCRYPTO_CURRENTDIR_SOURCES} PROPERTIES INCLUDE_DIRECTORIES
    "${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448;${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/arch_32"
)

set(LIBCRYPTO_CURRENTDIR_SOURCES ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_smpl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_mont.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nist.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_cvt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_mult.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_curve.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_check.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_print.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_key.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec2_smpl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/eck_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistp224.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistp256.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistp521.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistputil.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_oct.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec2_oct.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_oct.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_kmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecdh_ossl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecdh_kdf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecdsa_ossl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecdsa_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecdsa_vrf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve25519.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecx_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_local.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/arch_32/arch_intrinsics.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/arch_32/f_impl.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/curve448_local.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/ed448.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/field.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/point_448.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/curve448/word.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
    # empty by default
)
if (OPENSSL_ASM)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistz256.c
            ecp_nistz256-x86_64${OPENSSL_ASM_PREPROCESSED}
            x25519-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistz256.c
            ecp_nistz256-x86${OPENSSL_ASM_PREPROCESSED}
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistz256.c
            ecp_nistz256-armv4.S
        )
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistz256.c
            ecp_nistz256-armv8.S
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
