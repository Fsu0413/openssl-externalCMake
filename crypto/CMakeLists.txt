# SPDX-License-Identifier: Unlicense

set(OPENSSL_SYS_DEFINE)
if (MSVC)
    # Note: All Windows platform defines OPENSSL_SYS_WIN32 regardless of what OPENSSL_SYS_DEFINE is

    if (OPENSSL_TARGET_ARCH STREQUAL "x86")
        # Seems unneeded, but keep compatibility with OpenSSL
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_WIN32")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x64")
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_WIN64A")
    elseif (OPENSSL_TARGET_ARCH MATCHES "arm")
        # Nothing should be defined. OPENSSL_SYS_WIN_CORE is not OPENSSL_SYS_DEFINE
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
        # assume macOS since OpenSSL hasn't yet supports watchOS, tvOS, etc.
        set(OPENSSL_SYS_DEFINE "OPENSSL_SYS_MACOSX")
    endif()
endif()

set(EXTERNALCMAKE_HAS_SYSDEFINE NO)
if (OPENSSL_SYS_DEFINE)
    set(EXTERNALCMAKE_HAS_SYSDEFINE YES)
else()
    set(OPENSSL_SYS_DEFINE PREVENT_COMPILE_ERROR)
endif()

set(OPENSSL_CPUID_OBJ ${OPENSSL_ASM})

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
if (       ( WIN32 AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) ) )
        OR ( ANDROID AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR APPLE
        OR BSD
        OR ( CMAKE_SYSTEM_NAME MATCHES "SunOS" ) # TODO: Solaris on sparcv7 and sparcv9-64 have RC4_CHAR
    )
    set(OPENSSL_RC4_INT "int")
else()
    set(OPENSSL_RC4_INT "char")
endif()

#cmakedefine BN_LLONG
if (       ( BSD AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( CYGWIN AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        OR ( WIN32 AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) ) )
        OR ( ANDROID AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) ) )
        OR ( LINUX AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) ) )
        OR ( CMAKE_SYSTEM_NAME MATCHES "SunOS" AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) ) # # TODO: Solaris on sparcv7 and sparcv9-64 have BN_LLONG
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
            foreach (SIZE_OF_LONG_KEY IN LISTS SIZEOF_LONG_KEYS)
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

configure_file(opensslconf.h.cmake.in ${CMAKE_BINARY_DIR}/include/openssl/opensslconf.h @ONLY)
configure_file(bn_conf.h.cmake.in ${CMAKE_BINARY_DIR}/include/internal/bn_conf.h @ONLY)
configure_file(dso_conf.h.cmake.in ${CMAKE_BINARY_DIR}/include/internal/dso_conf.h @ONLY)

unset(THIRTY_TWO_BIT)
unset(SIXTY_FOUR_BIT)
unset(SIXTY_FOUR_BIT_LONG)
unset(BN_LLONG)
unset(OPENSSL_RC4_INT)
unset(OPENSSL_EXPORT_VAR_AS_FUNCTION)
unset(I386_ONLY)
unset(EXTERNALCMAKE_HAS_SYSDEFINE)
unset(OPENSSL_SYS_DEFINE)

if (OPENSSL_ASM OR OPENSSL_UPLINK)
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
        elseif( BSD OR LINUX OR ( CMAKE_SYSTEM_NAME MATCHES "SunOS" ) )
            set(OPENSSL_PERLASM_SCHEME "elf")
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "x64" )
        if ( OPENSSL_NASM )
            set(OPENSSL_PERLASM_SCHEME "nasm")
        elseif ( CYGWIN OR ( WIN32 AND NOT MSVC ) )
            set(OPENSSL_PERLASM_SCHEME "mingw64")
        elseif (MSVC)
            set(OPENSSL_PERLASM_SCHEME "masm")
        elseif ( ANDROID OR BSD OR LINUX OR ( CMAKE_SYSTEM_NAME MATCHES "SunOS" ) )
            set(OPENSSL_PERLASM_SCHEME "elf")
        elseif ( APPLE AND NOT IOS )
            set(OPENSSL_PERLASM_SCHEME "macosx")
        elseif (IOS)
            set(OPENSSL_PERLASM_SCHEME "osx32")
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm32" )
        if ( ANDROID OR LINUX )
            set(OPENSSL_PERLASM_SCHEME "linux32")
        elseif (IOS)
            set(OPENSSL_PERLASM_SCHEME "ios32")
        endif()
    elseif ( OPENSSL_TARGET_ARCH STREQUAL "arm64" )
        if ( ANDROID OR LINUX OR BSD )
            set(OPENSSL_PERLASM_SCHEME "linux64")
        elseif (APPLE)
            set(OPENSSL_PERLASM_SCHEME "ios64")
        endif()
    endif()

    if ( NOT OPENSSL_PERLASM_SCHEME AND LINUX )
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
    if (BUILD_SHARED_LIBS)
        # PIC needs to be specified manually...???
        if (CMAKE_SYSTEM_NAME MATCHES "SunOS" AND CMAKE_C_COMPILER_ID MATCHES "SunPro" )
            set(FLAGS ${FLAGS} -KPIC)
        elseif ( NOT ( WIN32 OR CYGWIN ) AND OPENSSL_TARGET_ARCH STREQUAL "x86" )
            # Only recoginzed when target is x86
            set(FLAGS ${FLAGS} -fPIC)
        endif()
    endif()
    add_custom_command(
        OUTPUT ${OUT_ASMFILE}
        COMMAND ${CMAKE_COMMAND} -E env "CC=\"${CMAKE_C_COMPILER}\"" "ASM=\"${OPENSSL_ASM_COMPILER}\"" ${PERL_EXECUTABLE} ${SRC_PERLFILE} ${FLAGS} ${OUT_ASMFILE}
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
    if (WINDOWS_ONECORE OR WINDOWS_PHONE OR WINDOWS_STORE)
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_SYS_WIN_CORE")
        if (OPENSSL_TARGET_ARCH MATCHES "arm")
            set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-D_ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE")
        endif()
    endif()
endif()
if (CMAKE_SYSTEM_NAME MATCHES "SunOS")
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DFILIO_H")
endif()
if (ANDROID OR LINUX)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_USE_NODELETE")
endif()
if (OPENSSL_SSE2)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_IA32_SSE2")
endif()
if (OPENSSL_THREADS)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_THREADS")
    if (BSD)
        set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-D_THREAD_SAFE" "-D_REENTRANT")
    elseif (   ANDROID
            OR APPLE
            OR LINUX
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
    if (       BSD
            OR CYGWIN
            OR ANDROID
            OR APPLE
            OR LINUX
            OR ( CMAKE_SYSTEM_NAME MATCHES "SunOS" )
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

foreach (_DIRECTORY IN ITEMS
        aes asn1 bf bio blake2 bn buffer camellia cast chacha cmac cms comp conf ct des dh dsa ec engine evp hmac idea kdf lhash md2 md4 md5 mdc2 modes objects ocsp pem pkcs7
        pkcs12 poly1305 rand rc2 rc4 rc5 ripemd rsa seed sha srp stack ts txt_db ui whrlpool x509 x509v3 uplink
    )
    set(_CIPHER ${_DIRECTORY})
    if (_CIPHER STREQUAL "whrlpool")
        set(_CIPHER "whirlpool")
    elseif (_CIPHER STREQUAL "ripemd")
        set(_CIPHER "rmd160")
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
    unset(LIBCRYPTO_CURRENTDIR_CFLAGS)
    include(${_DIRECTORY}/flags.cmake OPTIONAL)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} ${LIBCRYPTO_CURRENTDIR_CFLAGS})
endforeach()
unset(LIBCRYPTO_CURRENTDIR_CFLAGS)

string(TIMESTAMP OPENSSL_BUILD_TIMESTAMP "%a %b %d %H:%M:%S %Y" UTC)
if (NOT OPENSSL_BUILD_TIMESTAMP)
    set(OPENSSL_BUILD_TIMESTAMP "date not available")
endif()
set(OPENSSL_BUILDINF_H_CMAKE_IN "buildinf.h.cmake.in")
if ( APPLE AND CMAKE_OSX_ARCHITECTURES )
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
    unset(LIBCRYPTO_CURRENTDIR_SOURCES)
    include(${_DIRECTORY}/objects.cmake)
    set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})
endforeach()
unset(LIBCRYPTO_CURRENTDIR_SOURCES)

if (OPENSSL_HW AND OPENSSL_ENGINE AND ( NOT ( BUILD_SHARED_LIBS AND OPENSSL_DYNAMIC_ENGINE ) ) )
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
    set(LIBCRYPTO_RUNTIME_OUTPUT_NAME )
    if (OPENSSL_TARGET_ARCH STREQUAL x64)
        set(LIBCRYPTO_RUNTIME_OUTPUT_NAME libcrypto-1_1-x64)
    else()
        set(LIBCRYPTO_RUNTIME_OUTPUT_NAME libcrypto-1_1)
    endif()

    if (BUILD_SHARED_LIBS)
        add_custom_command(
            OUTPUT crypto.def
            COMMAND "${CMAKE_COMMAND}" -DNUMFILE="${CMAKE_SOURCE_DIR}/openssl/util/libcrypto.num" -DLIBRARY_FILE="${LIBCRYPTO_RUNTIME_OUTPUT_NAME}" -DBINARY_DIR="${CMAKE_BINARY_DIR}" -DOUTPUT_FILE="${CMAKE_CURRENT_BINARY_DIR}/crypto.def" -DPLATFORM=_WIN32 -P "${CMAKE_CURRENT_SOURCE_DIR}/mkdef.cmake"
            MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/util/libcrypto.num"
            DEPENDS mkdef.cmake
        )
        set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} crypto.def)
    endif()
endif()
add_library(crypto
    ${CMAKE_BINARY_DIR}/include/openssl/opensslconf.h
    ${CMAKE_BINARY_DIR}/include/internal/dso_conf.h
    ${CMAKE_BINARY_DIR}/include/internal/bn_conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/aes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1t.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/async.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/blowfish.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bn.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/buffer.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/camellia.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cast.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cms.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf_api.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/crypto.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ct.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/des.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dtls1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/e_os2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ebcdic.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ec.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecdh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecdsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/engine.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/evp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/hmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/idea.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/kdf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/lhash.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/mdc2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/modes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/obj_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ocsp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/opensslv.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ossl_typ.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs12.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs7.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rand.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ripemd.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/safestack.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/seed.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srtp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/stack.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/symhacks.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/tls1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ts.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/txt_db.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ui.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/whrlpool.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509_vfy.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509v3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/asn1t.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/constant_time_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dane.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dso.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/numbers.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/o_dir.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/o_str.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sslconf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/thread_once.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/asn1_int.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/async.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/bn_dh.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/bn_int.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/bn_srp.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/chacha.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/cryptlib.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/cryptlib_int.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/engine.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/err_int.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/evp_int.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/lhash.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/md32_common.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/poly1305.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/rand.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/include/internal/x509_int.h
    ${LIBCRYPTO_SOURCES}
)
if (OPENSSL_THREADS)
    target_link_libraries(crypto PUBLIC Threads::Threads)
endif()
if (OPENSSL_ZLIB AND ( NOT OPENSSL_ZLIB_DYNAMIC ) )
    target_link_libraries(crypto PUBLIC ZLIB::ZLIB)
endif()
if (WIN32)
    set_target_properties(crypto PROPERTIES
        RUNTIME_OUTPUT_NAME "${LIBCRYPTO_RUNTIME_OUTPUT_NAME}"
    )
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
           ${CMAKE_SOURCE_DIR}/openssl/crypto/include
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

if (CMAKE_SYSTEM_NAME MATCHES "SunOS")
    target_link_libraries(crypto
        PUBLIC socket nsl
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
