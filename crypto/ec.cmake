
# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY
perlasm_generate_src(ecp_nistz256-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(ecp_nistz256-avx2${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/asm/ecp_nistz256-avx2.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
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

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
    # empty by default
)
if (OPENSSL_ASM)
    if ( ( ( CMAKE_SYSTEM_PROCESSOR MATCHES "[Xx]86[_\\-]64" ) OR ( CMAKE_SYSTEM_PROCESSOR MATCHES "[Aa][Mm][Dd]64" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR ( WIN32 AND NOT MSVC )
            OR ( APPLE AND NOT IOS )
    ) ) OR ( OPENSSL_PERLASM_MSVC_X86_64 ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ecp_nistz256.c
            ecp_nistz256-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DECP_NISTZ256_ASM")
    elseif ( ( ( CMAKE_SYSTEM_PROCESSOR MATCHES "i[2-7]86" ) OR ( CMAKE_SYSTEM_PROCESSOR MATCHES "[Xx]86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR ( WIN32 AND NOT MSVC )
            OR ANDROID
    ) ) OR ( OPENSSL_PERLASM_MSVC_I386 ) )
        # no-asm
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
