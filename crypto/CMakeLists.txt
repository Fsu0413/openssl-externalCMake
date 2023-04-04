
set(OPENSSL_SYS_DEFINE)
if (MSVC)
    if (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYSNAME_WIN32")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x64")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYSNAME_WIN64A")
    else()
        message(FATAL_ERROR "This version of MSVC is not supported")
    endif()
elseif (WIN32 AND NOT MSVC)
    if (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYSNAME_MINGW32")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x64")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYSNAME_MINGW64")
    else()
        message(FATAL_ERROR "This version of MinGW is not supported")
    endif()
elseif (CYGWIN)
    set(OPENSSL_SYS_DEFINE "OPENSSL_SYSNAME_CYGWIN")
elseif (APPLE)
    if (IOS)
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYSNAME_iOS")
    else()
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYSNAME_MACOSX")
    endif()
endif()

set(EXTERNALCMAKE_HAS_SYSDEFINE NO)
if (OPENSSL_SYS_DEFINE)
    set(EXTERNALCMAKE_HAS_SYSDEFINE YES)
else()
    set(OPENSSL_SYS_DEFINE PREVENT_COMPILE_ERROR)
endif()

foreach (_CIPHER IN ITEMS
        krb5
        ssl tls ssl3-method # meta-cipher
        des ec md5 rsa sha dsa dh gost tlsext # dependent
        aes asn1 bf bio bn buf-freelists buffer camellia capieng cast chain-verify cmac cms comp conf deprecated descbcm dgram dso dtls dtls1 ec-nistp-64-gcc-128 ec2m ecdh ecdsa
        engine evp fp-api gmp hash-comp heartbeats hmac idea jpake lhash libunbound locking md2 md4 mdc2 modes multibyte nextprotoneg object objects ocsp pem pkcs7 pkcs12 posix-io
        pqueue psk rand rc2 rc4 rc5 rdrand rfc3779 ripemd ripemd160 rmd160 sctp seed setvbuf-ionbf sha0 sha1 sha256 sha512 sock speed srp srtp ssl-intern ssl-trace ssl2 ssl2-method
        ssl3 stack stdio store tls1 ts txt-db ui unit-test weak-ssl-ciphers whirlpool x509 x509-verify
    )
    string(TOUPPER ${_CIPHER} _CIPHER_UPPER)
    string(REPLACE "-" "_" _CIPHER_SYMBOL ${_CIPHER_UPPER})
    set(NO_${_CIPHER_SYMBOL} ${OPENSSL_NO_${_CIPHER_SYMBOL}})
    unset(_CIPHER_SYMBOL)
    unset(_CIPHER_UPPER)
endforeach()

set(OPENSSL_CPUID_OBJ ${OPENSSL_ASM})

# bn_ops
# TODO: reconsider following, use OPENSSL_TARGET_ARCH

#cmakedefine I386_ONLY
set(I386_ONLY ${OPENSSL_386})

#cmakedefine OPENSSL_EXPORT_VAR_AS_FUNCTION
if (WIN32)
    set(OPENSSL_EXPORT_VAR_AS_FUNCTION YES)
else()
    set(OPENSSL_EXPORT_VAR_AS_FUNCTION NO)
endif()

#define IDEA_INT unsigned @OPENSSL_IDEA_INT@
set(OPENSSL_IDEA_INT "int")

#define MD2_INT unsigned @OPENSSL_MD2_INT@
set(OPENSSL_MD2_INT "int")

#define RC2_INT unsigned @OPENSSL_RC2_INT@
if (BSD AND ( OPENSSL_TARGET_ARCH STREQUAL "x86") )
    set(OPENSSL_RC2_INT "char")
else()
    set(OPENSSL_RC2_INT "int")
endif()

#define RC4_INT unsigned @OPENSSL_RC4_INT@
if (NOT WIN32)
    set(OPENSSL_RC4_INT "char")
else()
    set(OPENSSL_RC4_INT "int")
endif()

#define EXTERNALCMAKE_RC4_CHUNK_TYPE @OPENSSL_RC4_CHUNK_TYPE@
if (       ( ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) AND ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) )
        OR ( CYGWIN AND ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) )
        OR ( ANDROID AND NOT ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR APPLE
        OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    )
    set(OPENSSL_RC4_CHUNK_TYPE 1)
elseif( WIN32 AND CMAKE_SIZEOF_VOID_P EQUAL 8 )
    set(OPENSSL_RC4_CHUNK_TYPE 2)
else()
    set(OPENSSL_RC4_CHUNK_TYPE 0)
endif()

#define DES_LONG unsigned @OPENSSL_DES_INT@
if(        ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
        OR ( CYGWIN AND CMAKE_SIZEOF_VOID_P EQUAL 8 )
        OR ( WIN32 AND CMAKE_SIZEOF_VOID_P EQUAL 8 )
        OR ( ANDROID AND NOT ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( APPLE AND NOT IOS )
        OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    )
    set(OPENSSL_DES_INT "int")
else()
    set(OPENSSL_DES_INT "long")
endif()

#cmakedefine BN_LLONG
if (       ( ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( CYGWIN AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( WIN32 AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( ANDROID AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) ) )
        OR IOS
        OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" AND CMAKE_SIZEOF_VOID_P EQUAL 4 )
    )
    set(BN_LLONG YES)
else()
    set(BN_LLONG NO)
endif()

#cmakedefine SIXTY_FOUR_BIT_LONG
#cmakedefine SIXTY_FOUR_BIT
#cmakedefine THIRTY_TWO_BIT
# Why OpenSSL decide to put 64bit data in platform table?
# We'd detect it on our own
include(CheckTypeSize)
check_type_size(long SIZEOF_LONG LANGUAGE C)
# CMAKE_SIZEOF_VOID_P
if (NOT HAVE_SIZEOF_LONG)
    message(FATAL_ERROR "type 'long' does not exist")
else()
    if (NOT SIZEOF_LONG)
        if (HAVE_SIZEOF_LONG AND SIZEOF_LONG_KEYS)
            foreach (SIZE_OF_LONG_KEY IN LIST SIZEOF_LONG_KEYS)
                if (SIZEOF_LONG EQUAL 0)
                    set(SIZEOF_LONG ${SIZEOF_LONG-${SIZE_OF_LONG_KEY}})
                elseif (NOT SIZEOF_LONG EQUAL ${SIZEOF_LONG-${SIZE_OF_LONG_KEY}})
                    message(FATAL_ERROR "sizeof 'long' is different on every architecture. Please build it separately and then combine them in to one later.")
                endif()
            endforeach()
        endif()
    endif()
endif()

if (SIZEOF_LONG EQUAL 8 AND CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(SIXTY_FOUR_BIT_LONG ON)
    set(SIXTY_FOUR_BIT OFF)
    set(THIRTY_TWO_BIT OFF)
elseif (SIZEOF_LONG EQUAL 4 AND CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(SIXTY_FOUR_BIT_LONG OFF)
    set(SIXTY_FOUR_BIT ON)
    set(THIRTY_TWO_BIT OFF)
elseif (SIZEOF_LONG EQUAL 4 AND CMAKE_SIZEOF_VOID_P EQUAL 4)
    set(SIXTY_FOUR_BIT_LONG OFF)
    set(SIXTY_FOUR_BIT OFF)
    set(THIRTY_TWO_BIT ON)
else()
    message(FATAL_ERROR "OpenSSL currently supports only 64-bit and 32-bit platform. Other platform is no longer supported.")
endif()

#cmakedefine RC4_INDEX
if (       ( ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( CYGWIN AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( WIN32 AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( ANDROID AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
    )
    set(RC4_INDEX YES)
else()
    set(RC4_INDEX NO)
endif()

#define EXTERNALCMAKE_BF_PTR @OPENSSL_BF_PTR@
if (       ( ANDROID AND NOT ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR IOS
        OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    )
    set(OPENSSL_BF_PTR 1)
else()
    set(OPENSSL_BF_PTR 0)
endif()

#cmakedefine DES_PTR
if (       ( ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( CYGWIN AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ))
        OR ( ANDROID AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( WIN32 AND NOT MSVC AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
    )
    set(DES_PTR YES)
else()
    set(DES_PTR NO)
endif()

#cmakedefine DES_RISC1
if (       ( ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( CYGWIN AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( ANDROID AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( WIN32 AND NOT MSVC AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
    )
    set(DES_RISC1 YES)
else()
    set(DES_RISC1 NO)
endif()

#cmakedefine DES_RISC2
set(DES_RISC2 NO)

#cmakedefine DES_UNROLL
if (       ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
        OR CYGWIN
        OR ANDROID
        OR APPLE
        OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
        OR ( WIN32 AND NOT MSVC AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
    )
    set(DES_UNROLL YES)
else()
    set(DES_UNROLL NO)
endif()

configure_file(opensslconf.h.cmake.in ${CMAKE_BINARY_DIR}/include/openssl/opensslconf.h @ONLY)

unset(DES_UNROLL)
unset(DES_RISC2)
unset(DES_RISC1)
unset(DES_PTR)
unset(OPENSSL_BF_PTR)
unset(RC4_INDEX)
unset(THIRTY_TWO_BIT)
unset(SIXTY_FOUR_BIT)
unset(SIXTY_FOUR_BIT_LONG)
unset(BN_LLONG)
unset(OPENSSL_DES_INT)
unset(OPENSSL_RC4_CHUNK_TYPE)
unset(OPENSSL_RC4_INT)
unset(OPENSSL_RC2_INT)
unset(OPENSSL_MD2_INT)
unset(OPENSSL_IDEA_INT)
unset(OPENSSL_EXPORT_VAR_AS_FUNCTION)
unset(I386_ONLY)

configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/crypto.h ${CMAKE_BINARY_DIR}/include/openssl/crypto.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/opensslv.h ${CMAKE_BINARY_DIR}/include/openssl/opensslv.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ebcdic.h ${CMAKE_BINARY_DIR}/include/openssl/ebcdic.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/symhacks.h ${CMAKE_BINARY_DIR}/include/openssl/symhacks.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ossl_typ.h ${CMAKE_BINARY_DIR}/include/openssl/ossl_typ.h COPYONLY)

# what poor design! Unneeded header file should also got deployed!!
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/aes/aes.h ${CMAKE_BINARY_DIR}/include/openssl/aes.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/asn1/asn1.h ${CMAKE_BINARY_DIR}/include/openssl/asn1.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/asn1/asn1_mac.h ${CMAKE_BINARY_DIR}/include/openssl/asn1_mac.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/asn1/asn1t.h ${CMAKE_BINARY_DIR}/include/openssl/asn1t.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/bf/blowfish.h ${CMAKE_BINARY_DIR}/include/openssl/blowfish.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio.h ${CMAKE_BINARY_DIR}/include/openssl/bio.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bn.h ${CMAKE_BINARY_DIR}/include/openssl/bn.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/buffer/buffer.h ${CMAKE_BINARY_DIR}/include/openssl/buffer.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/camellia/camellia.h ${CMAKE_BINARY_DIR}/include/openssl/camellia.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/cast/cast.h ${CMAKE_BINARY_DIR}/include/openssl/cast.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/cmac/cmac.h ${CMAKE_BINARY_DIR}/include/openssl/cmac.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms.h ${CMAKE_BINARY_DIR}/include/openssl/cms.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/comp/comp.h ${CMAKE_BINARY_DIR}/include/openssl/comp.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf.h ${CMAKE_BINARY_DIR}/include/openssl/conf.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/conf/conf_api.h ${CMAKE_BINARY_DIR}/include/openssl/conf_api.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/des/des.h ${CMAKE_BINARY_DIR}/include/openssl/des.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/des/des_old.h ${CMAKE_BINARY_DIR}/include/openssl/des_old.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dh.h ${CMAKE_BINARY_DIR}/include/openssl/dh.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsa.h ${CMAKE_BINARY_DIR}/include/openssl/dsa.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/dso/dso.h ${CMAKE_BINARY_DIR}/include/openssl/dso.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ec.h ${CMAKE_BINARY_DIR}/include/openssl/ec.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ecdh.h ${CMAKE_BINARY_DIR}/include/openssl/ecdh.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecdsa.h ${CMAKE_BINARY_DIR}/include/openssl/ecdsa.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/engine/engine.h ${CMAKE_BINARY_DIR}/include/openssl/engine.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/err/err.h ${CMAKE_BINARY_DIR}/include/openssl/err.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp.h ${CMAKE_BINARY_DIR}/include/openssl/evp.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hmac.h ${CMAKE_BINARY_DIR}/include/openssl/hmac.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/idea/idea.h ${CMAKE_BINARY_DIR}/include/openssl/idea.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/jpake/jpake.h ${CMAKE_BINARY_DIR}/include/openssl/jpake.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/krb5/krb5_asn.h ${CMAKE_BINARY_DIR}/include/openssl/krb5_asn.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/lhash/lhash.h ${CMAKE_BINARY_DIR}/include/openssl/lhash.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/md2/md2.h ${CMAKE_BINARY_DIR}/include/openssl/md2.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/md4/md4.h ${CMAKE_BINARY_DIR}/include/openssl/md4.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/md5/md5.h ${CMAKE_BINARY_DIR}/include/openssl/md5.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/mdc2/mdc2.h ${CMAKE_BINARY_DIR}/include/openssl/mdc2.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/modes/modes.h ${CMAKE_BINARY_DIR}/include/openssl/modes.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/objects/objects.h ${CMAKE_BINARY_DIR}/include/openssl/objects.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_mac.h ${CMAKE_BINARY_DIR}/include/openssl/obj_mac.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ocsp/ocsp.h ${CMAKE_BINARY_DIR}/include/openssl/ocsp.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem.h ${CMAKE_BINARY_DIR}/include/openssl/pem.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pem2.h ${CMAKE_BINARY_DIR}/include/openssl/pem2.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs12/pkcs12.h ${CMAKE_BINARY_DIR}/include/openssl/pkcs12.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/pkcs7/pkcs7.h ${CMAKE_BINARY_DIR}/include/openssl/pkcs7.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/pqueue/pqueue.h ${CMAKE_BINARY_DIR}/include/openssl/pqueue.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/rand/rand.h ${CMAKE_BINARY_DIR}/include/openssl/rand.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2.h ${CMAKE_BINARY_DIR}/include/openssl/rc2.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4.h ${CMAKE_BINARY_DIR}/include/openssl/rc4.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5.h ${CMAKE_BINARY_DIR}/include/openssl/rc5.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/ripemd.h ${CMAKE_BINARY_DIR}/include/openssl/ripemd.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa.h ${CMAKE_BINARY_DIR}/include/openssl/rsa.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/seed/seed.h ${CMAKE_BINARY_DIR}/include/openssl/seed.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha.h ${CMAKE_BINARY_DIR}/include/openssl/sha.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/srp/srp.h ${CMAKE_BINARY_DIR}/include/openssl/srp.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/stack/stack.h ${CMAKE_BINARY_DIR}/include/openssl/stack.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/stack/safestack.h ${CMAKE_BINARY_DIR}/include/openssl/safestack.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/store/store.h ${CMAKE_BINARY_DIR}/include/openssl/store.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts.h ${CMAKE_BINARY_DIR}/include/openssl/ts.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/txt_db/txt_db.h ${CMAKE_BINARY_DIR}/include/openssl/txt_db.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui.h ${CMAKE_BINARY_DIR}/include/openssl/ui.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/ui/ui_compat.h ${CMAKE_BINARY_DIR}/include/openssl/ui_compat.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/whrlpool.h ${CMAKE_BINARY_DIR}/include/openssl/whrlpool.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509.h ${CMAKE_BINARY_DIR}/include/openssl/x509.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_vfy.h ${CMAKE_BINARY_DIR}/include/openssl/x509_vfy.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/x509v3.h ${CMAKE_BINARY_DIR}/include/openssl/x509v3.h COPYONLY)

foreach (_CIPHER IN ITEMS
        krb5
        ssl tls ssl3-method # meta-cipher
        des ec md5 rsa sha dsa dh gost tlsext # dependent
        aes asn1 bf bio bn buf-freelists buffer camellia capieng cast chain-verify cmac cms comp conf deprecated descbcm dgram dso dtls dtls1 ec-nistp-64-gcc-128 ec2m ecdh ecdsa
        engine evp fp-api gmp hash-comp heartbeats hmac idea jpake lhash libunbound locking md2 md4 mdc2 modes multibyte nextprotoneg object objects ocsp pem pkcs7 pkcs12 posix-io
        pqueue psk rand rc2 rc4 rc5 rdrand rfc3779 ripemd ripemd160 rmd160 sctp seed setvbuf-ionbf sha0 sha1 sha256 sha512 sock speed srp srtp ssl-intern ssl-trace ssl2 ssl2-method
        ssl3 stack stdio store tls1 ts txt-db ui unit-test weak-ssl-ciphers whirlpool x509 x509-verify x509v3
    )
    string(TOUPPER ${_CIPHER} _CIPHER_UPPER)
    string(REPLACE "-" "_" _CIPHER_SYMBOL ${_CIPHER_UPPER})
    unset(NO_${_CIPHER_SYMBOL})
    unset(_CIPHER_SYMBOL)
    unset(_CIPHER_UPPER)
endforeach()
unset(EXTERNALCMAKE_HAS_SYSDEFINE)
unset(OPENSSL_SYS_DEFINE)

# TODO: consider nasm
if (OPENSSL_ASM)
    set(OPENSSL_PERLASM_SCHEME)
    if ( APPLE AND NOT IOS )
        set(OPENSSL_PERLASM_SCHEME "macosx")

        if (OPENSSL_TARGET_ARCH STREQUAL "arm64")
            message(WARNING
                "OpenSSL doesn't yet support macOS ARM as for version 1.0.2. The ASM doesn't compile on this platform so is currently disabled. "
                "Building with OPENSSL_ASM value ON will make build fail since the build system links to the ASM code which does not exist. "
                "Use -DOPENSSL_ASM=NO to pass the build."
            )
        endif()
    elseif (IOS)
        set(OPENSSL_PERLASM_SCHEME "void")
    else()
        if ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
            if ( CYGWIN OR ( WIN32 AND NOT MSVC ) )
                set(OPENSSL_PERLASM_SCHEME "coff")
            elseif (MSVC)
                set(OPENSSL_PERLASM_SCHEME "win32")
            elseif (ANDROID)
                set(OPENSSL_PERLASM_SCHEME "android")
            elseif( CMAKE_SYSTEM_NAME MATCHES "BSD" )
                set(OPENSSL_PERLASM_SCHEME "elf")
            endif()
        elseif ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
            if ( CYGWIN OR ( WIN32 AND NOT MSVC ) )
                set(OPENSSL_PERLASM_SCHEME "mingw64")
            elseif (MSVC)
                set(OPENSSL_PERLASM_SCHEME "masm")
            elseif ( ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) )
                set(OPENSSL_PERLASM_SCHEME "elf")
            endif()
        elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
            if ( ANDROID OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) )
                set(OPENSSL_PERLASM_SCHEME "void")
            endif()
        elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
            if ( ANDROID OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) )
                set(OPENSSL_PERLASM_SCHEME "linux64")
            endif()
        endif()
    endif()

    if ( NOT OPENSSL_PERLASM_SCHEME AND ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) )
        set(OPENSSL_PERLASM_SCHEME "void")
    endif()

    if (NOT OPENSSL_PERLASM_SCHEME)
        message(FATAL_ERROR "OpenSSL does not support ASM on this platform - Please set OPENSSL_ASM to OFF and reconfigure")
    endif()

    if (NOT PERL_FOUND)
        message(FATAL_ERROR "building OpenSSL with ASM needs Perl installed - Please set PERL_EXECUTABLE before running CMake or set OPENSSL_ASM to OFF and reconfigure")
    endif()
endif()

# Usage:
# perlasm_generate_src(<out-asmfile> <src-perlfile>
#                   [DEPENDENDCIES <depend1> <depend2> ...]
#                   [FLAGS <flag1> <flag2> ...]
#                   [NO_STDOUT [BEFORE | NONE]]
# )
macro (perlasm_generate_src OUT_ASMFILE SRC_PERLFILE)
    set(DEPENDENCIES)
    set(FLAGS)
    set(_CURRENTPARSING)
    set(STDOUT TRUE)
    set(NO_STDOUT)
    foreach (_ITEM IN ITEMS ${ARGN})
        if (_ITEM STREQUAL "DEPENDENCIES")
            set(_CURRENTPARSING "DEPENDENCIES")
        elseif (_ITEM STREQUAL "FLAGS")
            set(_CURRENTPARSING "FLAGS")
        elseif (_ITEM STREQUAL "NO_STDOUT")
            set(STDOUT FALSE)
            set(_CURRENTPARSING "NO_STDOUT")
        else()
            if (NOT _CURRENTPARSING)
                message(FATAL_ERROR "perlasm_generate_src: either DEPENDENCIES or FLAGS should be specified")
            endif()
            set(${_CURRENTPARSING} ${${_CURRENTPARSING}} ${_ITEM})
        endif()
    endforeach()
    if (STDOUT)
        set(FLAGS ${FLAGS} ">" ${OUT_ASMFILE})
    else()
        if (NO_STDOUT STREQUAL "BEFORE")
            set(FLAGS ${OUT_ASMFILE} ${FLAGS})
        elseif (NO_STDOUT STREQUAL "NONE")
            # DO NOTHING
        else()
            set(FLAGS ${FLAGS} ${OUT_ASMFILE})
        endif()
    endif()
    add_custom_command(
        OUTPUT ${OUT_ASMFILE}
        COMMAND ${PERL_EXECUTABLE} ${SRC_PERLFILE} ${FLAGS}
        MAIN_DEPENDENCY ${SRC_PERLFILE}
        DEPENDS ${DEPENDENCIES}
        USES_TERMINAL
    )
    unset(NO_STDOUT)
    unset(STDOUT)
    unset(_CURRENTPARSING)
    unset(FLAGS)
    unset(DEPENDENCIES)
endmacro()

# original OpenSSL building progress made static libraries, and link the static libraries to the final libraries
# we create a variable for recording the C / S files...
set(LIBCRYPTO_SOURCES)
set(LIBCRYPTO_DIRECTORIES)
set(LIBCRYPTO_CFLAGS)
if (WIN32)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_SYSNAME_WIN32" "-DWIN32_LEAN_AND_MEAN" "-D_WINSOCK_DEPRECATED_NO_WARNINGS")
    if (CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DUNICODE" "-D_UNICODE")
    endif()
endif()
if (OPENSSL_SSE2)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_IA32_SSE2")
endif()
if (OPENSSL_KRB5)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DKRB5_MIT")
endif()
if (OPENSSL_THREADS)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_THREADS")

    if (   ( CMAKE_SYSTEM_NAME MATCHES "BSD" ))
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-D_THREAD_SAFE" "-D_REENTRANT")
    elseif (   ANDROID
            OR APPLE
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
        )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-D_REENTRANT")
    elseif (WIN32 AND NOT MSVC)
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-D_MT")
    endif()
endif()
if (BUILD_SHARED_LIBS)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_PIC")
endif()
if (OPENSSL_DSO)
    if (       ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR ANDROID
            OR APPLE
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    )
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DDSO_DLFCN" "-DHAVE_DLFCN_H")
    elseif (WIN32)
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DDSO_WIN32")
    else()
        message(WARNING "We are not supporting corresponding flags in this platform - DSO related functions will not work")
    endif()
endif()
if (OPENSSL_ZLIB)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DZLIB")
    if (NOT OPENSSL_ZLIB_DYNAMIC)
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DZLIB_SHARED")
    endif()
endif()
if (CMAKE_C_BYTE_ORDER EQUAL BIG_ENDIAN)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DB_ENDIAN")
else()
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DL_ENDIAN")
endif()

include(_cryptoDir.cmake)
foreach (_DIRECTORY IN ITEMS
        aes asn1 bf bio bn buffer camellia cast cmac cms comp conf des dh dsa dso ec ecdh ecdsa engine err evp hmac idea jpake krb5 lhash md2 md4 md5 mdc2 modes objects ocsp pem
        pkcs12 pkcs7 pqueue rand rc2 rc4 rc5 ripemd rsa seed sha srp stack store ts txt_db ui whrlpool x509 x509v3
    )
    set(_CIPHER ${_DIRECTORY})
    if (_CIPHER STREQUAL "whrlpool")
        set(_CIPHER "whirlpool")
    endif()
    string(TOUPPER ${_CIPHER} _CIPHER_UPPER)
    string(REPLACE "-" "_" _CIPHER_SYMBOL ${_CIPHER_UPPER})
    if (OPENSSL_${_CIPHER_SYMBOL})
        include(${_DIRECTORY}.cmake)
        set(LIBCRYPTO_DIRECTORIES ${LIBCRYPTO_DIRECTORIES} ${CMAKE_SOURCE_DIR}/openssl/crypto/${_DIRECTORY})
    endif()
    unset(_CIPHER_SYMBOL)
    unset(_CIPHER_UPPER)
    unset(_CIPHER)
endforeach()

foreach (_EXPERIMENTALCIPHER IN LISTS OPENSSL_EXPERIMENTAL_CIPHERS)
    if (OPENSSL_EXPERIMENTAL_${_EXPERIMENTALCIPHER})
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_EXPERIMENTAL_${_EXPERIMENTALCIPHER}")
    endif()
endforeach()

if (OPENSSL_HW AND ( NOT ( BUILD_SHARED_LIBS AND OPENSSL_DYNAMIC_ENGINE ) ) )
    foreach (_OPTION IN ITEMS 4758-cca aep atalla cswift gmp chil nuron sureware ubsec padlock capi ccgost)
        set(_ENGINE ${_OPTION})
        if (_OPTION STREQUAL "4758-cca")
            set(_ENGINE "4758cca")
        elseif (_OPTION STREQUAL "ccgost")
            set(_ENGINE "gost")
        endif()
        string(TOUPPER ${_OPTION} _OPTION_UPPER)
        string(REPLACE "-" "_" _OPTION_SYMBOL ${_OPTION_UPPER})
        if (OPENSSL_HW_${_OPTION_SYMBOL})
            set(ENGINE_SOURCES)
            include(../engines/${_OPTION}.cmake)
            set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${ENGINE_SOURCES})
            unset(ENGINE_SOURCES)
        endif()
        unset(_OPTION_SYMBOL)
        unset(_OPTION_UPPER)
    endforeach()
endif()
if (WIN32)
    configure_file(crypto.rc.cmake.in crypto.rc @ONLY)
    set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} crypto.rc)
endif()
add_library(crypto
    ${CMAKE_BINARY_DIR}/include/openssl/opensslconf.h
    ${LIBCRYPTO_SOURCES}
)
if (OPENSSL_KRB5)
    target_link_libraries(crypto PUBLIC PkgConfig::MIT_KRB5)
endif()
if (OPENSSL_THREADS)
    target_link_libraries(crypto PUBLIC Threads::Threads)
endif()
if (OPENSSL_ZLIB AND ( NOT OPENSSL_ZLIB_DYNAMIC ) )
    target_link_libraries(crypto PUBLIC ZLIB::ZLIB)
endif()
if (WIN32)
    set_target_properties(crypto PROPERTIES
        RUNTIME_OUTPUT_NAME libeay32
    )
endif()
set_target_properties(crypto PROPERTIES
    SOVERSION 1.0.0
    VERSION ${OPENSSL_VERSION_REAL}
)

target_include_directories(crypto
    PUBLIC ${CMAKE_BINARY_DIR}/include
           ${CMAKE_CURRENT_BINARY_DIR}
           ${CMAKE_SOURCE_DIR}/openssl
           ${CMAKE_SOURCE_DIR}/openssl/crypto
           ${LIBCRYPTO_DIRECTORIES}
)

target_compile_definitions(crypto
    PUBLIC ${LIBCRYPTO_CFLAGS}
)

if (WIN32)
    target_link_libraries(crypto
        PUBLIC ws2_32 crypt32
    )
endif()

install(TARGETS crypto
    RUNTIME
    LIBRARY
    ARCHIVE
)

install(DIRECTORY ${CMAKE_BINARY_DIR}/include/openssl
    TYPE INCLUDE
)

# issue: can't specify zlib path, especially for the condition that zlib is found by CMake but can't be found by pkgconfig
configure_file(libcrypto.pc.cmake.in libcrypto.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libcrypto.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)
