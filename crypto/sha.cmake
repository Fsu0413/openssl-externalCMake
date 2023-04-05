
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

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha_dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha1dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha_one.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha1_one.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha256.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha512.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha_locl.h
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
            sha1-x86_64${OPENSSL_ASM_PREPROCESSED}
            sha1-mb-x86_64${OPENSSL_ASM_PREPROCESSED}
            sha256-x86_64${OPENSSL_ASM_PREPROCESSED}
            sha256-mb-x86_64${OPENSSL_ASM_PREPROCESSED}
            sha512-x86_64${OPENSSL_ASM_PREPROCESSED}
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSHA1_ASM" "-DSHA256_ASM" "-DSHA512_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) AND (
               ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR WIN32
            OR ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        # TODO
        if (FALSE)
            set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
                sha1-586${OPENSSL_ASM_PREPROCESSED}
                sha256-586${OPENSSL_ASM_PREPROCESSED}
                sha512-586${OPENSSL_ASM_PREPROCESSED}
            )
            set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSHA1_ASM" "-DSHA256_ASM" "-DSHA512_ASM")
        endif()
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    ) )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            sha1-armv4-large.S
            sha256-armv4.S
            sha512-armv4.S
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSHA1_ASM" "-DSHA256_ASM" "-DSHA512_ASM")
    elseif ( ( OPENSSL_TARGET_ARCH STREQUAL "arm64" ) AND (
               ANDROID
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    ) )
        set(LIBCRYPTO_CURRENTDIR_ASM_SOURCES
            sha1-armv8.S
            sha256-armv8.S
            sha512-armv8.S
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSHA1_ASM" "-DSHA256_ASM" "-DSHA512_ASM")
    endif()
endif()

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${LIBCRYPTO_CURRENTDIR_SOURCES}
    ${LIBCRYPTO_CURRENTDIR_ASM_SOURCES}
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
unset(LIBCRYPTO_CURRENTDIR_ASM_SOURCES)
