# SPDX-License-Identifier: Unlicense

set(OPENSSL_SYS_DEFINE)
if (MSVC)
    if (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_WIN32")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x64")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_WIN64A")
    else()
        message(FATAL_ERROR "This version of MSVC is not yet supported")
    endif()
elseif (WIN32 AND NOT MSVC)
    if (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_MINGW32")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x64")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_MINGW64")
    else()
        message(FATAL_ERROR "This version of MinGW is not yet supported")
    endif()
elseif (CYGWIN)
    set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_CYGWIN")
elseif (APPLE)
    if (IOS)
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_iOS")
    else()
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_MACOSX")
    endif()
endif()

set(EXTERNALCMAKE_HAS_SYSDEFINE NO)
if (OPENSSL_SYS_DEFINE)
    set(EXTERNALCMAKE_HAS_SYSDEFINE YES)
else()
    set(OPENSSL_SYS_DEFINE PREVENT_COMPILE_ERROR)
endif()

set(EXTERNALCMAKE_MIN_API_LEVEL NO)
if (DEFINED CACHE{OPENSSL_MIN_API_LEVEL})
    set(EXTERNALCMAKE_MIN_API_LEVEL YES)
endif()

# bn_ops

#cmakedefine I386_ONLY
set(I386_ONLY ${OPENSSL_386})

#cmakedefine OPENSSL_EXPORT_VAR_AS_FUNCTION
if (WIN32)
    set(OPENSSL_EXPORT_VAR_AS_FUNCTION YES)
else()
    set(OPENSSL_EXPORT_VAR_AS_FUNCTION NO)
endif()

#define RC4_INT unsigned @OPENSSL_RC4_INT@
if ( WIN32 OR ( ANDROID AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) ) ) OR APPLE )
    set(OPENSSL_RC4_INT "int")
else()
    set(OPENSSL_RC4_INT "char")
endif()

#cmakedefine BN_LLONG
if (       ( ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( CYGWIN AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( WIN32 AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( ANDROID AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) ) )
        OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) ) )
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
if (OPENSSL_DSO)
    if (       ( CMAKE_SYSTEM_NAME MATCHES "BSD" )
            OR CYGWIN
            OR ANDROID
            OR APPLE
            OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" )
    )
        set(DSO_WIN32 OFF)
        set(DSO_DLFCN ON)
        set(HAVE_DLFCN_H ON)
    elseif (WIN32)
        set(DSO_WIN32 ON)
        set(DSO_DLFCN OFF)
        set(HAVE_DLFCN_H OFF)
    else()
        message(WARNING "We are not supporting corresponding flags in this platform - DSO related functions will not work")
    endif()
endif()

configure_file(opensslconf.h.cmake.in ${CMAKE_BINARY_DIR}/include/openssl/opensslconf.h @ONLY)
configure_file(bn_conf.h.cmake.in ${CMAKE_BINARY_DIR}/include/crypto/bn_conf.h @ONLY)
configure_file(dso_conf.h.cmake.in ${CMAKE_BINARY_DIR}/include/crypto/dso_conf.h @ONLY)

unset(HAVE_DLFCN_H)
unset(DSO_DLFCN)
unset(DSO_WIN32)
unset(THIRTY_TWO_BIT)
unset(SIXTY_FOUR_BIT)
unset(SIXTY_FOUR_BIT_LONG)
unset(BN_LLONG)
unset(OPENSSL_RC4_INT)
unset(OPENSSL_EXPORT_VAR_AS_FUNCTION)
unset(I386_ONLY)
unset(EXTERNALCMAKE_HAS_SYSDEFINE)
unset(OPENSSL_SYS_DEFINE)

if (OPENSSL_ASM)
    set(OPENSSL_PERLASM_SCHEME)
    if ( OPENSSL_TARGET_ARCH STREQUAL "x86" )
        if ( OPENSSL_NASM )
            set(OPENSSL_PERLASM_SCHEME "win32n")
        elseif ( CYGWIN OR ( WIN32 AND NOT MSVC ) )
            set(OPENSSL_PERLASM_SCHEME "coff")
        elseif (MSVC)
            set(OPENSSL_PERLASM_SCHEME "win32")
        elseif (ANDROID)
            set(OPENSSL_PERLASM_SCHEME "android")
        elseif( CMAKE_SYSTEM_NAME MATCHES "BSD" OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) )
            set(OPENSSL_PERLASM_SCHEME "elf")
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        if ( OPENSSL_NASM )
            set(OPENSSL_PERLASM_SCHEME "nasm")
        elseif ( CYGWIN OR ( WIN32 AND NOT MSVC ) )
            set(OPENSSL_PERLASM_SCHEME "mingw64")
        elseif (MSVC)
            set(OPENSSL_PERLASM_SCHEME "masm")
        elseif ( ANDROID OR ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) )
            set(OPENSSL_PERLASM_SCHEME "elf")
        elseif ( APPLE AND NOT IOS )
            set(OPENSSL_PERLASM_SCHEME "macosx")
        elseif (IOS)
            set(OPENSSL_PERLASM_SCHEME "osx32")
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        if ( ANDROID OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) )
            set(OPENSSL_PERLASM_SCHEME "linux32")
        elseif (APPLE)
            set(OPENSSL_PERLASM_SCHEME "ios32")
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        if ( ANDROID OR ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) OR ( CMAKE_SYSTEM_NAME MATCHES "BSD" ) )
            set(OPENSSL_PERLASM_SCHEME "linux64")
        elseif (APPLE)
            set(OPENSSL_PERLASM_SCHEME "ios64")
        endif()
    endif()

    if ( NOT OPENSSL_PERLASM_SCHEME AND ( CMAKE_SYSTEM_NAME MATCHES "[Ll]inux" ) )
        set(OPENSSL_PERLASM_SCHEME "void")
    endif()

    if (NOT OPENSSL_PERLASM_SCHEME)
        message(FATAL_ERROR "OpenSSL does not yet support ASM on this platform - Please set OPENSSL_ASM to OFF and reconfigure")
    endif()

    if (NOT PERL_FOUND)
        message(FATAL_ERROR "building OpenSSL with ASM needs Perl installed - Please set PERL_EXECUTABLE before running CMake or set OPENSSL_ASM to OFF and reconfigure")
    endif()
endif()

# Usage:
# perlasm_generate_src(<out-asmfile> <src-perlfile>
#                   [DEPENDENDCIES <depend1> <depend2> ...]
#                   [FLAGS <flag1> <flag2> ...]
# )
macro (perlasm_generate_src OUT_ASMFILE SRC_PERLFILE)
    set(DEPENDENCIES)
    set(FLAGS)
    set(_CURRENTPARSING)
    foreach (_ITEM IN ITEMS ${ARGN})
        if (_ITEM STREQUAL "DEPENDENCIES")
            set(_CURRENTPARSING "DEPENDENCIES")
        elseif (_ITEM STREQUAL "FLAGS")
            set(_CURRENTPARSING "FLAGS")
        else()
            if (NOT _CURRENTPARSING)
                message(FATAL_ERROR "perlasm_generate_src: either DEPENDENCIES or FLAGS should be specified")
            endif()
            set(${_CURRENTPARSING} ${${_CURRENTPARSING}} ${_ITEM})
        endif()
    endforeach()
    if ( BUILD_SHARED_LIBS AND NOT ( WIN32 OR CYGWIN ) AND OPENSSL_TARGET_ARCH STREQUAL "x86" )
        # PIC needs to be specified manually...???
        # Only recoginzed when target is x86
        set(FLAGS ${FLAGS} -fPIC)
    endif()
    add_custom_command(
        OUTPUT ${OUT_ASMFILE}
        COMMAND ${PERL_EXECUTABLE} ${SRC_PERLFILE} ${FLAGS} ${OUT_ASMFILE}
        MAIN_DEPENDENCY ${SRC_PERLFILE}
        DEPENDS ${DEPENDENCIES}
        USES_TERMINAL
    )
    if (WIN32 AND OPENSSL_TARGET_ARCH STREQUAL "x64" AND OPENSSL_NASM )
        set_source_files_properties(${OUT_ASMFILE} PROPERTIES
            COMPILE_DEFINITIONS NEAR
        )
    endif()
    unset(_CURRENTPARSING)
    unset(FLAGS)
    unset(DEPENDENCIES)
endmacro()

# original OpenSSL building progress made archive of static libraries, and link the static libraries to the final shared / dynamic loaded libraries
# we create a variable for recording the C / S files...
set(LIBCRYPTO_SOURCES)
set(LIBCRYPTO_DIRECTORIES _cryptoDir async err dso)
set(LIBCRYPTO_CFLAGS)
if (WIN32)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_SYS_WIN32" "-DWIN32_LEAN_AND_MEAN" "-D_WINSOCK_DEPRECATED_NO_WARNINGS" "-DUNICODE" "-D_UNICODE")
endif()
if (OPENSSL_SSE2)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_IA32_SSE2")
endif()
if (OPENSSL_THREADS)
    # set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_THREADS")

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

foreach (_DIRECTORY IN ITEMS
        aes aria asn1 bf bio blake2 bn buffer camellia cast chacha cmac cms comp conf ct des dh dsa ec engine evp hmac idea kdf lhash md2 md4 md5 mdc2 modes objects ocsp pem pkcs7
        pkcs12 poly1305 rand rc2 rc4 rc5 ripemd rsa seed sha siphash sm2 sm3 sm4 srp stack store ts txt_db ui whrlpool x509 x509v3
    )
    set(_CIPHER ${_DIRECTORY})
    if (_CIPHER STREQUAL "whrlpool")
        set(_CIPHER "whirlpool")
    elseif (_CIPHER STREQUAL "ripemd")
        set(_CIPHER "rmd160")
    elseif (_CIPHER STREQUAL "ui")
        set(_CIPHER "ui-console")
    endif()
    string(TOUPPER ${_CIPHER} _CIPHER_UPPER)
    string(REPLACE "-" "_" _CIPHER_SYMBOL ${_CIPHER_UPPER})
    if (OPENSSL_${_CIPHER_SYMBOL})
        set(LIBCRYPTO_DIRECTORIES ${LIBCRYPTO_DIRECTORIES} ${_DIRECTORY})
    endif()
    unset(_CIPHER_SYMBOL)
    unset(_CIPHER_UPPER)
    unset(_CIPHER)
endforeach()

foreach (_DIRECTORY IN LISTS LIBCRYPTO_DIRECTORIES)
    include(${_DIRECTORY}/flags.cmake OPTIONAL)
endforeach()

string(TIMESTAMP OPENSSL_BUILD_TIMESTAMP "%a %b %d %H:%M:%S %Y" UTC)
if (NOT OPENSSL_BUILD_TIMESTAMP)
    set(OPENSSL_BUILD_TIMESTAMP "date not available")
endif()
set(OPENSSL_BUILDINF_H_CMAKE_IN "buildinf.h.cmake.in")
if ( APPLE AND ( NOT IOS ) AND CMAKE_OSX_ARCHITECTURES )
    list(LENGTH CMAKE_OSX_ARCHITECTURES OPENSSL_OSX_ARCHITECTURES_LENGTH)
    if (OPENSSL_OSX_ARCHITECTURES_LENGTH GREATER 1)
        set(OPENSSL_BUILDINF_H_CMAKE_IN "buildinf.h.appleUnified.cmake.in")
    endif()
    unset(OPENSSL_OSX_ARCHITECTURES_LENGTH)
endif()
set(LIBCRYPTO_CFLAGS_SOOOOOOOOLONG)
string(LENGTH ${CMAKE_C_COMPILER} CCOMPILER_LENGTH)
foreach (I RANGE ${CCOMPILER_LENGTH})
    if (I EQUAL CCOMPILER_LENGTH)
        break()
    endif()
    math(EXPR IMOD35 "${I} % 35")
    if (IMOD35 EQUAL 0)
        if (I EQUAL 0)
            string(APPEND LIBCRYPTO_CFLAGS_SOOOOOOOOLONG "\n    /* CMAKE_C_COMPILER */")
        endif()
        string(APPEND LIBCRYPTO_CFLAGS_SOOOOOOOOLONG "\n   ")
    endif()
    unset(IMOD35)
    string(SUBSTRING ${CMAKE_C_COMPILER} ${I} 1 STRI)
    string(APPEND LIBCRYPTO_CFLAGS_SOOOOOOOOLONG " '${STRI}',")
    unset(STRI)
endforeach()
unset(CCOMPILER_LENGTH)
string(APPEND LIBCRYPTO_CFLAGS_SOOOOOOOOLONG "\n\n    ' ',\n")
string(REGEX REPLACE ";" " " LIBCRYPTO_CFLAGS_SPACES "${LIBCRYPTO_CFLAGS}")
string(LENGTH ${LIBCRYPTO_CFLAGS_SPACES} CFLAGS_LENGTH)
foreach (I RANGE ${CFLAGS_LENGTH})
    if (I EQUAL CFLAGS_LENGTH)
        break()
    endif()
    math(EXPR IMOD35 "${I} % 35")
    if (IMOD35 EQUAL 0)
        if (I EQUAL 0)
            string(APPEND LIBCRYPTO_CFLAGS_SOOOOOOOOLONG "\n    /* LIBCRYPTO_CFLAGS */")
        endif()
        string(APPEND LIBCRYPTO_CFLAGS_SOOOOOOOOLONG "\n   ")
    endif()
    unset(IMOD35)
    string(SUBSTRING ${LIBCRYPTO_CFLAGS_SPACES} ${I} 1 STRI)
    string(APPEND LIBCRYPTO_CFLAGS_SOOOOOOOOLONG " '${STRI}',")
    unset(STRI)
endforeach()
unset(CFLAGS_LENGTH)
string(APPEND LIBCRYPTO_CFLAGS_SOOOOOOOOLONG "\n")
configure_file(${OPENSSL_BUILDINF_H_CMAKE_IN} buildinf.h @ONLY)
unset(LIBCRYPTO_CFLAGS_SOOOOOOOOLONG)
unset(LIBCRYPTO_CFLAGS_SPACES)
unset(OPENSSL_BUILDINF_H_CMAKE_IN)

foreach (_DIRECTORY IN LISTS LIBCRYPTO_DIRECTORIES)
    include(${_DIRECTORY}/objects.cmake)
endforeach()

if (OPENSSL_HW AND ( NOT ( BUILD_SHARED_LIBS AND OPENSSL_DYNAMIC_ENGINE ) ) )
    foreach (_OPTION IN ITEMS padlock capi afalg)
        set(_ENGINE ${_OPTION})
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
    ${CMAKE_BINARY_DIR}/include/crypto/dso_conf.h
    ${CMAKE_BINARY_DIR}/include/crypto/bn_conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/lhash.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/mdc2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/modes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/obj_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/objectserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ocsp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ocsperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/opensslv.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ossl_typ.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pemerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs7.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs7err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs12.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs12err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rand.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rand_drbg.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/randerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ripemd.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rsaerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/safestack.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/seed.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srtp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sslerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/stack.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/store.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/storeerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/symhacks.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/tls1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ts.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/tserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/txt_db.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ui.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/uierr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/whrlpool.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509_vfy.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509v3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509v3err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/aes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1t.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/async.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asyncerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bioerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/blowfish.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bn.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bnerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/buffer.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/buffererr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/camellia.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cast.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cms.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/comperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf_api.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conferr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/crypto.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cryptoerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ct.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cterr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/des.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dherr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dsaerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dtls1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/e_os2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ebcdic.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ec.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecdh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecdsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/engine.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/engineerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/evp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/evperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/hmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/idea.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/kdf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/kdferr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sockets.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sslconf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/thread_once.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/tsan_assist.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/constant_time.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/cryptlib.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dane.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dso.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dsoerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/nelem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/numbers.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/o_dir.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/o_str.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/refcount.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/chacha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/cryptlib.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ctype.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ec.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/engine.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/evp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/lhash.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/md32_common.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/poly1305.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/rand.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/siphash.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sm2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sm2err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sm3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sm4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/store.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/x509.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/aria.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/asn1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/async.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/bn.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/bn_dh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/bn_srp.h
    ${LIBCRYPTO_SOURCES}
)
if (OPENSSL_THREADS)
    target_link_libraries(crypto PUBLIC Threads::Threads)
endif()
if (OPENSSL_ZLIB AND ( NOT OPENSSL_ZLIB_DYNAMIC ) )
    target_link_libraries(crypto PUBLIC ZLIB::ZLIB)
endif()
if (WIN32)
    if (OPENSSL_TARGET_ARCH STREQUAL x64)
        set_target_properties(crypto PROPERTIES
            RUNTIME_OUTPUT_NAME libcrypto-1_1-x64
        )
    else()
        set_target_properties(crypto PROPERTIES
            RUNTIME_OUTPUT_NAME libcrypto-1_1
        )
    endif()
    if (MSVC)
        set_target_properties(crypto PROPERTIES
            ARCHIVE_OUTPUT_NAME libcrypto
        )
    endif()
endif()
set_target_properties(crypto PROPERTIES
    SOVERSION 1.1
    VERSION ${OPENSSL_VERSION_REAL}
)

target_include_directories(crypto
    PUBLIC ${CMAKE_BINARY_DIR}/include
           ${CMAKE_CURRENT_BINARY_DIR}
           ${CMAKE_SOURCE_DIR}/openssl
           ${CMAKE_SOURCE_DIR}/openssl/include
           ${CMAKE_SOURCE_DIR}/openssl/crypto
)

get_filename_component(OPENSSL_ENGINESDIR_ABSOLUTE ${CMAKE_INSTALL_LIBDIR}/engine-1_1 ABSOLUTE BASE_DIR ${CMAKE_INSTALL_PREFIX})

target_compile_definitions(crypto
    PRIVATE ${LIBCRYPTO_CFLAGS}
            "-DOPENSSLDIR=\"${OPENSSL_OPENSSLDIR_ABSOLUTE}\""
            "-DENGINESDIR=\"${OPENSSL_ENGINESDIR_ABSOLUTE}\""
)

if (WIN32)
    target_link_libraries(crypto
        PUBLIC ws2_32 crypt32
    )
endif()

if (OPENSSL_DSO)
    target_link_libraries(crypto
        PUBLIC ${CMAKE_DL_LIBS}
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

install(DIRECTORY ${CMAKE_SOURCE_DIR}/openssl/include/openssl
    TYPE INCLUDE
    REGEX "^.+\\.in$" EXCLUDE
    REGEX "^(.*[/\\])?__DECC_INCLUDE.+$" EXCLUDE
)
