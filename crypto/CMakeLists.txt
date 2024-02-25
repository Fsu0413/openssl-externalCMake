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
if (       WIN32
        OR ( ANDROID AND ( ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) ) )
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
        OR ( WIN32 AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
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
if (OPENSSL_DSO)
    if (       BSD
            OR CYGWIN
            OR ANDROID
            OR APPLE
            OR LINUX
            OR ( CMAKE_SYSTEM_NAME MATCHES "SunOS" )
    )
        set(DSO_WIN32 OFF)
        set(DSO_DLFCN ON)
        set(HAVE_DLFCN_H ON)
    elseif (WIN32)
        set(DSO_WIN32 ON)
        set(DSO_DLFCN OFF)
        set(HAVE_DLFCN_H OFF)
    else()
        set(DSO_NONE ON)
        message(WARNING "We are not supporting corresponding flags in this platform - DSO related functions will not work")
    endif()
else()
    set(DSO_NONE ON)
endif()

configure_file(configuration.h.cmake.in ${CMAKE_BINARY_DIR}/include/openssl/configuration.h @ONLY)
configure_file(bn_conf.h.cmake.in ${CMAKE_BINARY_DIR}/include/crypto/bn_conf.h @ONLY)
configure_file(dso_conf.h.cmake.in ${CMAKE_BINARY_DIR}/include/crypto/dso_conf.h @ONLY)

unset(HAVE_DLFCN_H)
unset(DSO_DLFCN)
unset(DSO_WIN32)
unset(DSO_NONE)
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
        elseif (APPLE)
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

if (MSVC)
    set(OPENSSL_ASM_PREPROCESSED_X86 ${OPENSSL_ASM_PREPROCESSED})
else()
    set(OPENSSL_ASM_PREPROCESSED_X86)
endif()

# Usage:
# perlasm_generate_src(<out-asmfile> <src-perlfile>
#                   [DEPENDENDCIES <depend1> <depend2> ...]
# )
macro (perlasm_generate_src OUT_ASMFILE SRC_PERLFILE)
    set(DEPENDENCIES)
    set(FLAGS ${OPENSSL_PERLASM_SCHEME} ${LIBCRYPTO_CFLAGS} ${OPENSSL_USE_386})
    set(_CURRENTPARSING)
    foreach (_ITEM IN ITEMS ${ARGN})
        if (_ITEM STREQUAL "DEPENDENCIES")
            set(_CURRENTPARSING "DEPENDENCIES")
        else()
            if (NOT _CURRENTPARSING)
                message(FATAL_ERROR "perlasm_generate_src: DEPENDENCIES should be specified")
            endif()
            set(${_CURRENTPARSING} ${${_CURRENTPARSING}} ${_ITEM})
        endif()
    endforeach()
    if (CMAKE_POSITION_INDEPENDENT_CODE)
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
    if (MSVC AND ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        # need to figure out if this works under clang-cl
        add_custom_command(
            OUTPUT ${OUT_ASMFILE}${OPENSSL_ASM_PREPROCESSED_X86}
            COMMAND ${CMAKE_C_COMPILER} "/EP" "-D__ASSEMBLER__" ${CMAKE_C_FLAGS} ${LIBCRYPTO_CFLAGS} ${OUT_ASMFILE} > ${OUT_ASMFILE}${OPENSSL_ASM_PREPROCESSED_X86}
            MAIN_DEPENDENCY ${OUT_ASMFILE}
            USES_TERMINAL
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
if (CMAKE_SYSTEM_NAME MATCHES "SunOS")
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DFILIO_H")
endif()
if (OPENSSL_SSE2)
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DOPENSSL_IA32_SSE2")
endif()
if (OPENSSL_THREADS)
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

set(LIBCRYPTO_PROVIDER_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/providers/defltprov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/baseprov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/nullprov.c
    ${CMAKE_SOURCE_DIR}/openssl/providers/prov_running.c
)
if (OPENSSL_LEGACY AND ( NOT OPENSSL_MODULE ) )
    set(LIBCRYPTO_CFLAGS ${LIBCRYPTO_CFLAGS} "-DSTATIC_LEGACY")
endif()

foreach (_DIRECTORY IN ITEMS
        aes aria asn1 bf bio bn buffer camellia cast chacha cmac cmp cms comp conf crmf ct des dh dsa ec encode_decode engine ess evp ffc hmac http idea kdf lhash md2 md4 md5 mdc2
        modes objects ocsp pem pkcs7 pkcs12 poly1305 property rand rc2 rc4 rc5 ripemd rsa seed sha siphash sm2 sm3 sm4 srp stack store ts txt_db ui whrlpool x509 uplink
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

foreach (_STACKHASH_HEADER_FILE_PATH IN ITEMS
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1t.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bio.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmp.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cms.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/crmf.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/crypto.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ct.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/err.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ess.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/lhash.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ocsp.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs7.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs12.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/safestack.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srp.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ui.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509_vfy.h.in
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509v3.h.in
)
    get_filename_component(_STACKHASH_HEADER_FILE_NAME "${_STACKHASH_HEADER_FILE_PATH}" NAME_WLE)
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/include/openssl/${_STACKHASH_HEADER_FILE_NAME}"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/include/openssl/${_STACKHASH_HEADER_FILE_NAME}" -P "${CMAKE_CURRENT_SOURCE_DIR}/stackhash.cmake" "${_STACKHASH_HEADER_FILE_PATH}"
        MAIN_DEPENDENCY "${_STACKHASH_HEADER_FILE_PATH}"
        DEPENDS stackhash.cmake
        USES_TERMINAL
    )
endforeach()
add_custom_target(generate_stackhash SOURCES
    ${CMAKE_BINARY_DIR}/include/openssl/asn1.h
    ${CMAKE_BINARY_DIR}/include/openssl/asn1t.h
    ${CMAKE_BINARY_DIR}/include/openssl/bio.h
    ${CMAKE_BINARY_DIR}/include/openssl/cmp.h
    ${CMAKE_BINARY_DIR}/include/openssl/cms.h
    ${CMAKE_BINARY_DIR}/include/openssl/conf.h
    ${CMAKE_BINARY_DIR}/include/openssl/crmf.h
    ${CMAKE_BINARY_DIR}/include/openssl/crypto.h
    ${CMAKE_BINARY_DIR}/include/openssl/ct.h
    ${CMAKE_BINARY_DIR}/include/openssl/err.h
    ${CMAKE_BINARY_DIR}/include/openssl/ess.h
    ${CMAKE_BINARY_DIR}/include/openssl/lhash.h
    ${CMAKE_BINARY_DIR}/include/openssl/ocsp.h
    ${CMAKE_BINARY_DIR}/include/openssl/pkcs7.h
    ${CMAKE_BINARY_DIR}/include/openssl/pkcs12.h
    ${CMAKE_BINARY_DIR}/include/openssl/safestack.h
    ${CMAKE_BINARY_DIR}/include/openssl/srp.h
    ${CMAKE_BINARY_DIR}/include/openssl/ssl.h
    ${CMAKE_BINARY_DIR}/include/openssl/ui.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509_vfy.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509v3.h
)

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

# This line need to be after setting LIBCRYPTO_CFLAGS
add_subdirectory(../providers ../providers)

foreach (_DIRECTORY IN LISTS LIBCRYPTO_DIRECTORIES)
    unset(LIBCRYPTO_CURRENTDIR_SOURCES)
    include(${_DIRECTORY}/objects.cmake)
    set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})
endforeach()
unset(LIBCRYPTO_CURRENTDIR_SOURCES)

configure_file(opensslv.h.cmake.in ${CMAKE_BINARY_DIR}/include/openssl/opensslv.h @ONLY)

if (OPENSSL_HW AND OPENSSL_ENGINE AND ( NOT ( BUILD_SHARED_LIBS AND OPENSSL_DYNAMIC_ENGINE ) ) )
    foreach (_OPTION IN ITEMS padlock capi afalg devcrypto)
        set(_ENGINE ${_OPTION})
        string(TOUPPER ${_OPTION} _OPTION_UPPER)
        string(REPLACE "-" "_" _OPTION_SYMBOL ${_OPTION_UPPER})
        if (OPENSSL_${_OPTION_SYMBOL}ENG)
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
        set(LIBCRYPTO_RUNTIME_OUTPUT_NAME libcrypto-3-x64)
    else()
        set(LIBCRYPTO_RUNTIME_OUTPUT_NAME libcrypto-3)
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
    ${CMAKE_BINARY_DIR}/include/openssl/opensslv.h
    ${CMAKE_BINARY_DIR}/include/openssl/configuration.h
    ${CMAKE_BINARY_DIR}/include/openssl/asn1.h
    ${CMAKE_BINARY_DIR}/include/openssl/asn1t.h
    ${CMAKE_BINARY_DIR}/include/openssl/bio.h
    ${CMAKE_BINARY_DIR}/include/openssl/cmp.h
    ${CMAKE_BINARY_DIR}/include/openssl/cms.h
    ${CMAKE_BINARY_DIR}/include/openssl/conf.h
    ${CMAKE_BINARY_DIR}/include/openssl/crmf.h
    ${CMAKE_BINARY_DIR}/include/openssl/crypto.h
    ${CMAKE_BINARY_DIR}/include/openssl/ct.h
    ${CMAKE_BINARY_DIR}/include/openssl/err.h
    ${CMAKE_BINARY_DIR}/include/openssl/ess.h
    ${CMAKE_BINARY_DIR}/include/openssl/lhash.h
    ${CMAKE_BINARY_DIR}/include/openssl/ocsp.h
    ${CMAKE_BINARY_DIR}/include/openssl/pkcs7.h
    ${CMAKE_BINARY_DIR}/include/openssl/pkcs12.h
    ${CMAKE_BINARY_DIR}/include/openssl/safestack.h
    ${CMAKE_BINARY_DIR}/include/openssl/srp.h
    ${CMAKE_BINARY_DIR}/include/openssl/ssl.h
    ${CMAKE_BINARY_DIR}/include/openssl/ui.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509_vfy.h
    ${CMAKE_BINARY_DIR}/include/openssl/x509v3.h
    ${CMAKE_BINARY_DIR}/include/crypto/dso_conf.h
    ${CMAKE_BINARY_DIR}/include/crypto/bn_conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/aes_platform.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/aria.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/asn1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/asn1err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/asn1_dsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/async.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/asyncerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/bioerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/bn.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/bnerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/bn_dh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/bn_srp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/buffererr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/chacha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/cmll_platform.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/cmperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/cmserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/comperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/conferr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/crmferr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/cryptlib.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/cryptoerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/cterr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ctype.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/decoder.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/decodererr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/des_platform.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/dh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/dherr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/dsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/dsaerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ec.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ecerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ecx.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/encoder.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/encodererr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/engine.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/engineerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ess.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/esserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/evp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/evperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/httperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/lhash.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/md32_common.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/modes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/objectserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ocsperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/pem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/pemerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/pkcs12err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/pkcs7.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/pkcs7err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/poly1305.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/ppc_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/punycode.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/rand.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/randerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/rand_pool.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/rsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/rsaerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/security_bits.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/siphash.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/siv.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sm2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sm2err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sm4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sparc_arch.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/sparse_array.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/store.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/storeerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/tserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/types.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/uierr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/x509.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/x509err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/crypto/x509v3err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/asn1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/constant_time.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/core.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/cryptlib.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dane.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/deprecated.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/der.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dso.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dsoerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/e_os.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/endian.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/ffc.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/ktls.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/namemap.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/nelem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/numbers.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/o_dir.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/packet.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/param_build_set.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/passphrase.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/property.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/propertyerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/provider.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/refcount.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sha3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sizes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sm3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sockets.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sslconf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/symhacks.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/thread_once.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/tlsgroups.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/tsan_assist.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/unicode.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/aes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/async.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asyncerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bioerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/blowfish.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bn.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bnerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/buffer.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/buffererr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/camellia.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cast.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmp_util.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/comperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conferr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conftypes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf_api.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/core.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/core_dispatch.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/core_names.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/core_object.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/crmferr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cryptoerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cryptoerr_legacy.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cterr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/decoder.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/decodererr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/des.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dherr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dsaerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dtls1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ebcdic.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ec.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecdh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecdsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/encoder.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/encodererr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/engine.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/engineerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/esserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/evp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/evperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/e_os2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/fips_names.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/hmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/http.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/httperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/idea.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/kdf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/kdferr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/macros.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/mdc2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/modes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/objectserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/obj_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ocsperr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/opensslconf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ossl_typ.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/params.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/param_build.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pemerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs12err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs7err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/proverr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/provider.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/prov_ssl.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rand.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/randerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ripemd.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rsaerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/seed.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/self_test.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srtp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sslerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sslerr_legacy.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/stack.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/store.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/storeerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/symhacks.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/tls1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/trace.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ts.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/tserr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/txt_db.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/types.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/uierr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/whrlpool.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509v3err.h
    ${LIBCRYPTO_SOURCES}
    ${LIBCRYPTO_PROVIDER_SOURCES}
)

add_dependencies(crypto generate_stackhash)

if (BUILD_SHARED_LIBS)
    target_link_libraries(crypto
        PRIVATE libdefault
                libcommon
    )
else()
    target_sources(crypto
        PRIVATE $<TARGET_OBJECTS:libdefault>
                $<TARGET_OBJECTS:libcommon>
    )
endif()
if (OPENSSL_LEGACY)
    if ( NOT OPENSSL_MODULE )
        if (BUILD_SHARED_LIBS)
            target_link_libraries(crypto
                PRIVATE legacy
            )
        else()
            target_sources(crypto
                PRIVATE $<TARGET_OBJECTS:legacy>
            )
        endif()
    else()
        target_link_libraries(legacy
            PRIVATE crypto
        )
    endif()
endif()

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
elseif ( ( CMAKE_C_COMPILER_ID MATCHES "GNU" OR CMAKE_C_COMPILER_ID MATCHES "[Cc]lang" ) AND NOT APPLE AND NOT ( CMAKE_SYSTEM_NAME MATCHES "SunOS") )
    if (BUILD_SHARED_LIBS)
        add_custom_command(
            OUTPUT crypto.ld
            COMMAND "${CMAKE_COMMAND}" -DNUMFILE="${CMAKE_SOURCE_DIR}/openssl/util/libcrypto.num" -DLIBRARY_FILE="${LIBCRYPTO_RUNTIME_OUTPUT_NAME}" -DBINARY_DIR="${CMAKE_BINARY_DIR}" -DOUTPUT_FILE="${CMAKE_CURRENT_BINARY_DIR}/crypto.ld" -DPLATFORM=ELF -P "${CMAKE_CURRENT_SOURCE_DIR}/mkdef.cmake"
            MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/util/libcrypto.num"
            DEPENDS mkdef.cmake
        )
        add_custom_target(crypto_map SOURCES crypto.ld)
        add_dependencies(crypto crypto_map)
        target_link_options(crypto PRIVATE "LINKER:--version-script=${CMAKE_CURRENT_BINARY_DIR}/crypto.ld")
    endif()
endif()
set_target_properties(crypto PROPERTIES
    SOVERSION 3
    VERSION ${OPENSSL_VERSION_REAL}
)

target_include_directories(crypto
    PRIVATE ${CMAKE_SOURCE_DIR}/openssl/providers/implementations/include
            ${CMAKE_SOURCE_DIR}/openssl/providers/common/include
    PUBLIC  ${CMAKE_BINARY_DIR}/include
            ${CMAKE_CURRENT_BINARY_DIR}
            ${CMAKE_SOURCE_DIR}/openssl
            ${CMAKE_SOURCE_DIR}/openssl/include
            ${CMAKE_SOURCE_DIR}/openssl/crypto
)

get_filename_component(OPENSSL_ENGINESDIR_ABSOLUTE ${CMAKE_INSTALL_LIBDIR}/engine-3 ABSOLUTE BASE_DIR ${CMAKE_INSTALL_PREFIX})
get_filename_component(OPENSSL_MODULESDIR_ABSOLUTE ${CMAKE_INSTALL_LIBDIR}/ossl-modules ABSOLUTE BASE_DIR ${CMAKE_INSTALL_PREFIX})

target_compile_definitions(crypto
    PRIVATE ${LIBCRYPTO_CFLAGS}
            -DOPENSSL_BUILDING_OPENSSL
            "-DOPENSSLDIR=\"${OPENSSL_OPENSSLDIR_ABSOLUTE}\""
            "-DENGINESDIR=\"${OPENSSL_ENGINESDIR_ABSOLUTE}\""
            "-DMODULESDIR=\"${OPENSSL_MODULESDIR_ABSOLUTE}\""
)

if (OPENSSL_ASM AND ( OPENSSL_TARGET_ARCH STREQUAL "arm32" ) AND NOT MSVC)
    target_link_options(crypto PUBLIC "-Wl,-Bsymbolic")
endif()

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
