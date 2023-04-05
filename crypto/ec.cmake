
perlasm_generate_src(ecp_nistz256-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ecp_nistz256-avx2${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-avx2.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

set(LIBCRYPTO_CURRENTDIR_SOURCES
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
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec2_mult.c
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
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec_lcl.h
)

set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
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
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistz256.c
            ecp_nistz256-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DECP_NISTZ256_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        # no-asm
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

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
