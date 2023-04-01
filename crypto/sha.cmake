
# TODO: DO NOT USE CMAKE_C_FLAGS, USE CRYPTO_C_FLAGS INSTEAD WHEN READY

perlasm_generate_src(sha1-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(sha256-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha256-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(sha512-586${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-586.pl
    DEPENDENCIES ${CMAKE_SOURCE_DIR}/openssl/crypto/perlasm/x86asm.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386}
)
perlasm_generate_src(sha1-ia64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-ia64.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT BEFORE
)
perlasm_generate_src(sha256-ia64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-ia64.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT BEFORE
)
perlasm_generate_src(sha512-ia64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-ia64.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT BEFORE
)
perlasm_generate_src(sha256-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha256-armv4.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-alpha.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-alpha.pl
)
perlasm_generate_src(sha1-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(sha1-mb-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-mb-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(sha256-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha256-mb-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha256-mb-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
)
perlasm_generate_src(sha512-x86_64${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-x86_64.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-sparcv9.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT BEFORE
)
perlasm_generate_src(sha256-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-sparcv9.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT BEFORE
)
perlasm_generate_src(sha512-sparcv9.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-sparcv9.pl
    FLAGS ${LIBCRYPTO_CFLAGS}
    NO_STDOUT BEFORE
)
perlasm_generate_src(sha1-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha256-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha512-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha256p8-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512p8-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha512p8-ppc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512p8-ppc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-parisc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha256-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-parisc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha512-parisc${OPENSSL_ASM_PREPROCESSED} ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-parisc.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-mips.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-mips.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha256-mips.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-mips.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha512-mips.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-mips.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-armv4-large.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-armv4-large.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-armv8.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-s390x.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-s390x.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-sparcv9a.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-sparcv9a.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha1-thumb.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha1-thumb.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha256-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-armv4.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha512-armv4.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-armv4.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha256-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-armv8.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha512-armv8.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-armv8.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha256-s390x.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-s390x.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)
perlasm_generate_src(sha512-s390x.S ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/asm/sha512-s390x.pl
    FLAGS ${OPENSSL_PERLASM_SCHEME}
    NO_STDOUT
)

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha_dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha1dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha_one.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha1_one.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha256.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha512.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha_locl.h
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
            sha1-x86_64${OPENSSL_ASM_PREPROCESSED}
            sha1-mb-x86_64${OPENSSL_ASM_PREPROCESSED}
            sha256-x86_64${OPENSSL_ASM_PREPROCESSED}
            sha256-mb-x86_64${OPENSSL_ASM_PREPROCESSED}
            sha512-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSHA1_ASM" "-DSHA256_ASM" "-DSHA512_ASM")
    elseif ( ( ( CMAKE_SYSTEM_PROCESSOR MATCHES "i[2-7]86" ) OR ( CMAKE_SYSTEM_PROCESSOR MATCHES "[Xx]86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR ( WIN32 AND NOT MSVC )
            OR ANDROID
    ) ) OR ( OPENSSL_PERLASM_MSVC_I386 ) )
        # TODO
        if (FALSE)
            set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
                sha1-586${OPENSSL_ASM_PREPROCESSED}
                sha256-586${OPENSSL_ASM_PREPROCESSED}
                sha512-586${OPENSSL_ASM_PREPROCESSED}
            )
            set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSHA1_ASM" "-DSHA256_ASM" "-DSHA512_ASM")
        endif()
    elseif (( CMAKE_SYSTEM_PROCESSOR MATCHES "armv\\d(-a)?") AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            sha1-armv4-large.S
            sha256-armv4.S
            sha512-armv4.S
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSHA1_ASM" "-DSHA256_ASM" "-DSHA512_ASM")
    elseif (( CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES
            sha1-armv8.S
            sha256-armv8.S
            sha512-armv8.S
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSHA1_ASM" "-DSHA256_ASM" "-DSHA512_ASM")
    endif()
endif()

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES}
    ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
