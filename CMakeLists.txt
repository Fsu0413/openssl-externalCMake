# SPDX-License-Identifier: Unlicense

cmake_minimum_required(VERSION 3.22)

project(OpenSSL
    VERSION 1.0.2.21
    DESCRIPTION "TLS/SSL and crypto library"
    HOMEPAGE_URL "https://www.openssl.org/"
    LANGUAGES C
)

get_filename_component(OPENSSL_C_COMPILER "${CMAKE_C_COMPILER}" NAME_WLE)

if (PROJECT_VERSION_MAJOR LESS 3)
    set(OPENSSL_VERSION_PRE3_SUFFICES
        ";a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u;v;w;x;y;za;zb;zc;zd;ze;zf;zg;zh"
    )
    list(GET OPENSSL_VERSION_PRE3_SUFFICES ${PROJECT_VERSION_TWEAK} OPENSSL_VERSION_PRE3_SUFFIX)
    set(OPENSSL_VERSION_REAL "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}${OPENSSL_VERSION_PRE3_SUFFIX}")
    unset(OPENSSL_VERSION_PRE3_SUFFIX)
    unset(OPENSSL_VERSION_PRE3_SUFFICES)
else()
    set(OPENSSL_VERSION_REAL "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
endif()

if (WIN32)
    set(CMAKE_SHARED_LIBRARY_PREFIX "")
    set(CMAKE_SHARED_MODULE_PREFIX "")
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS YES)
elseif (APPLE AND NOT IOS)
    set(CMAKE_SHARED_MODULE_SUFFIX ".dylib")
endif()

set(CMAKE_C_STANDARD 99)

# check if some file exists
# our CMake won't work if the file exists, need to remove some of the generated file from packaged source (tarball)
foreach (_UNNEEDED_GENERATED_FILE IN ITEMS
    ${CMAKE_CURRENT_LIST_DIR}/openssl/Makefile
    ${CMAKE_CURRENT_LIST_DIR}/openssl/apps/CA.pl
    ${CMAKE_CURRENT_LIST_DIR}/openssl/crypto/opensslconf.h
    ${CMAKE_CURRENT_LIST_DIR}/openssl/test/evptests.txt
    ${CMAKE_CURRENT_LIST_DIR}/openssl/tools/c_rehash
)
    if (EXISTS ${_UNNEEDED_GENERATED_FILE})
        message(FATAL_ERROR ${_UNNEEDED_GENERATED_FILE} " exists and we don't expect this file exist during our build. Please remove them before proceeding.")
    endif()
endforeach()

include(GNUInstallDirs)
include(CMakeDependentOption)

include("./.FsEnv.cmake" OPTIONAL)
find_package(Perl)

if (Perl_FOUND)
    # include(CTest)
else()
    message(AUTHOR_WARNING "Perl is not found. Since test cases depends on Perl testing is disabled.")
endif()

# --openssldir
# option(OPENSSL_OPENSSLDIR "OpenSSL SSL install directory, relative to CMAKE_INSTALL_PREFIX" "ssl")
set(OPENSSL_OPENSSLDIR "ssl" CACHE STRING "OpenSSL SSL install directory, relative to CMAKE_INSTALL_PREFIX")
get_filename_component(OPENSSL_OPENSSLDIR_ABSOLUTE ${OPENSSL_OPENSSLDIR} ABSOLUTE BASE_DIR ${CMAKE_INSTALL_PREFIX})

# [no-]threads
option(OPENSSL_THREADS "Build with threads supported" ON)

# [no-]shared
# iOS supports only static libraries
cmake_dependent_option(BUILD_SHARED_LIBS "Build Shared Libraries" ON "NOT IOS" OFF)

# no-dso
option(OPENSSL_DSO "use dymamic shared object loader code" ON)

# fips (OpenSSL 1.0.2 series doesn't bundle the FIPS module)
# option(OPENSSL_FIPS "use FIPS" OFF)
set(OPENSSL_FIPS OFF CACHE BOOL "use FIPS")

# [no-]zlib
option(OPENSSL_ZLIB "build with ZLIB" OFF)

# zlib-dynamic
cmake_dependent_option(OPENSSL_ZLIB_DYNAMIC "build ZLIB as dynamic loaded object" OFF "OPENSSL_ZLIB" OFF)

# --with-krb5-*
OPTION(OPENSSL_KRB5 "build OpenSSL with Kerberos 5" OFF)

# static_engine
cmake_dependent_option(OPENSSL_STATIC_ENGINE "generate static engine library" OFF "BUILD_SHARED_LIBS" ON)

cmake_dependent_option(OPENSSL_BUILD_DOCS "Build documentation" ON "Perl_FOUND" OFF)

foreach (_OPTION IN ITEMS hw hw-4758-cca hw-aep hw-atalla hw-chil hw-cswift hw-ibmca hw-ncipher hw-nuron hw-padlock hw-sureware hw-ubsec hw-zencod asm err nasm)
    string(TOUPPER ${_OPTION} _OPTION_UPPER)
    string(REPLACE "-" "_" _OPTION_SYMBOL ${_OPTION_UPPER})
    string(CONCAT _OPTION_STR "OPENSSL_" ${_OPTION_SYMBOL})
    string(CONCAT _OPTION_HELP "enable OpenSSL option " ${_OPTION})
    if (_OPTION STREQUAL "asm")
        # building ASM needs Perl
        # ASM is not supported on iOS
        cmake_dependent_option("${_OPTION_STR}" "${_OPTION_HELP}" ON "Perl_FOUND;NOT IOS" OFF)
    elseif (_OPTION STREQUAL "nasm")
        cmake_dependent_option("${_OPTION_STR}" "${_OPTION_HELP}" OFF "OPENSSL_ASM;MSVC" OFF)
    else()
        option("${_OPTION_STR}" "${_OPTION_HELP}" ON)
    endif()
    string(CONCAT _OPTION_NO_STR "OPENSSL_NO_" ${_OPTION_SYMBOL})
    string(CONCAT _OPTION_NO_HELP "disable OpenSSL option " ${_OPTION} " (automatically set, use ${_OPTION_STR} if this is to be modified)")
    set("${_OPTION_NO_STR}" ON CACHE BOOL "${_OPTION_NO_HELP}" FORCE)
    if (${_OPTION_STR})
        set("${_OPTION_NO_STR}" OFF CACHE BOOL "${_OPTION_NO_HELP}" FORCE)
    endif()
    unset(_OPTION_NO_HELP)
    unset(_OPTION_NO_STR)
    unset(_OPTION_HELP)
    unset(_OPTION_STR)
    unset(_OPTION_SYMBOL)
    unset(_OPTION_UPPER)
endforeach()

# no-<cipher>
set(OPENSSL_DEFAULT_DISABLED_CIPHERS ec-nistp-64-gcc-128 gmp md2 rc5 rfc3779 sctp ssl-trace ssl2 unit-test weak-ssl-ciphers jpake libunbound store)
set(OPENSSL_EXPERIMENTAL_CIPHERS jpake libunbound store)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(OpenSslExternalCMakeCheckArchitecture)

# undocumented!
if ( NOT OPENSSL_TARGET_ARCH )
    openssl_external_cmake_detect_target_arch(OPENSSL_TARGET_ARCH)
endif()

# 386 and SSE2
if (OPENSSL_TARGET_ARCH STREQUAL "x64")
    set(OPENSSL_386 OFF CACHE BOOL "generate 80386 code in assembly modules" FORCE)
    set(OPENSSL_SSE2 ON CACHE BOOL "Enable SSE2 instructions in assembly" FORCE)
elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
    option(OPENSSL_386 "generate 80386 code in assembly modules" OFF)
    cmake_dependent_option(OPENSSL_SSE2 "Enable SSE2 instructions in assembly" ON "NOT OPENSSL_386" OFF)
else()
    set(OPENSSL_386 OFF CACHE BOOL "generate 80386 code in assembly modules" FORCE)
    set(OPENSSL_SSE2 OFF CACHE BOOL "Enable SSE2 instructions in assembly" FORCE)
endif()
if (OPENSSL_386)
    set(OPENSSL_USE_386 "386" CACHE STRING "" FORCE)
endif()


foreach (_CIPHER IN ITEMS
        ssl tls ssl3-method # meta-cipher
        des ec md5 rsa sha dsa dh tlsext # dependent
        aes asn1 bf bio bn buf-freelists buffer camellia capieng cast chain-verify cmac cms comp conf deprecated descbcm dgram dso dtls dtls1 ec-nistp-64-gcc-128 ec2m ecdh ecdsa
        engine evp fp-api gmp gost hash-comp heartbeats hmac idea jpake lhash libunbound locking md2 md4 mdc2 modes multibyte nextprotoneg object objects ocsp pem pkcs7 pkcs12
        posix-io pqueue psk rand rc2 rc4 rc5 rdrand rfc3779 ripemd ripemd160 rmd160 sctp seed setvbuf-ionbf sha0 sha1 sha256 sha512 sock speed srp srtp ssl-intern ssl-trace ssl2
        ssl2-method ssl3 stack stdio store tls1 ts txt-db ui unit-test weak-ssl-ciphers whirlpool x509 x509-verify x509v3 uplink
)
    list(FIND OPENSSL_DEFAULT_DISABLED_CIPHERS ${_CIPHER} _CIPHER_IS_DEFAULT_DISABLED)
    set(_CIPHER_DEFAULT ON)
    if (NOT _CIPHER_IS_DEFAULT_DISABLED EQUAL -1)
        set(_CIPHER_DEFAULT OFF)
    endif()
    string(TOUPPER ${_CIPHER} _CIPHER_UPPER)
    string(REPLACE "-" "_" _CIPHER_SYMBOL ${_CIPHER_UPPER})
    string(CONCAT _CIPHER_STR "OPENSSL_" ${_CIPHER_SYMBOL})
    string(CONCAT _CIPHER_HELP "enable OpenSSL cipher " ${_CIPHER})
    if (_CIPHER STREQUAL "mdc2")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_DES" OFF)
    elseif (_CIPHER STREQUAL "ecdsa")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_EC" OFF)
    elseif (_CIPHER STREQUAL "ecdh")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_EC" OFF)
    elseif (_CIPHER STREQUAL "ssl2")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_SSL;OPENSSL_MD5;OPENSSL_RSA" OFF)
    elseif (_CIPHER STREQUAL "rsax")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_FIPS" OFF)
    elseif (_CIPHER STREQUAL "ssl3")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}"
            "OPENSSL_SSL;OPENSSL_SSL3_METHOD;OPENSSL_MD5;OPENSSL_SHA;( OPENSSL_RSA OR ( OPENSSL_DSA AND OPENSSL_DH ) )" OFF)
    elseif (_CIPHER STREQUAL "tls1")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLS;OPENSSL_MD5;OPENSSL_SHA;( OPENSSL_RSA OR ( OPENSSL_DSA AND OPENSSL_DH ) )" OFF)
    elseif (_CIPHER STREQUAL "gost")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_EC;OPENSSL_DSA;OPENSSL_DH" OFF)
    elseif (_CIPHER STREQUAL "srp")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLSEXT" OFF)
    elseif (_CIPHER STREQUAL "heartbeats")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLSEXT" OFF)
    elseif (_CIPHER STREQUAL "uplink")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "WIN32;MSVC OR ( OPENSSL_TARGET_ARCH STREQUAL \"x86\" );NOT OPENSSL_386;BUILD_SHARED_LIBS" OFF)
    else()
        option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}")
    endif()
    string(CONCAT _CIPHER_NO_STR "OPENSSL_NO_" ${_CIPHER_SYMBOL})
    string(CONCAT _CIPHER_NO_HELP "disable OpenSSL cipher " ${_CIPHER} " (automatically set, use ${_CIPHER_STR} if this is to be modified)")
    list(FIND OPENSSL_EXPERIMENTAL_CIPHERS ${_CIPHER} _CIPHER_IS_EXPERIMENTAL)
    if (${_CIPHER_STR} AND NOT _CIPHER_IS_EXPERIMENTAL EQUAL -1)
        string(CONCAT _CIPHER_FORCE_STR "OPENSSL_EXPERIMENTAL_" ${_CIPHER_SYMBOL})
        string(CONCAT _CIPHER_FORCE_HELP "force enable experimental OpenSSL cipher " ${_CIPHER})
        cmake_dependent_option("${_CIPHER_FORCE_STR}" "${_CIPHER_FORCE_HELP}" OFF "${_CIPHER_STR}" OFF)
        if (NOT "${_CIPHER_FORCE_STR}")
            message(FATAL_ERROR "You are enabling experimental cipher " ${_CIPHER} ". Please use -D" "${_CIPHER_FORCE_STR}" "=1 to proceed with experimental setting.")
        endif()
    endif()
    set("${_CIPHER_NO_STR}" ON CACHE BOOL "${_CIPHER_NO_HELP}" FORCE)
    if (${_CIPHER_STR})
        set("${_CIPHER_NO_STR}" OFF CACHE BOOL "${_CIPHER_NO_HELP}" FORCE)
    endif()
    unset(_CIPHER_NO_HELP)
    unset(_CIPHER_NO_STR)
    unset(_CIPHER_HELP)
    unset(_CIPHER_STR)
    unset(_CIPHER_SYMBOL)
    unset(_CIPHER_UPPER)
    unset(_CIPHER_DEFAULT)
    unset(_CIPHER_IS_EXPERIMENTAL)
    unset(_CIPHER_IS_DEFAULT_DISABLED)
endforeach()

if (OPENSSL_ASM OR OPENSSL_UPLINK)
    if (OPENSSL_ASM AND OPENSSL_NASM)
        enable_language(ASM_NASM)
        set(OPENSSL_ASM_PREPROCESSED ".nasm")
        get_filename_component(OPENSSL_ASM_COMPILER "${CMAKE_ASM_NASM_COMPILER}" NAME_WLE)
    elseif (MSVC)
        enable_language(ASM_MASM)
        set(OPENSSL_ASM_PREPROCESSED ".asm")
        get_filename_component(OPENSSL_ASM_COMPILER "${CMAKE_ASM_NASM_COMPILER}" NAME_WLE)
    else()
        enable_language(ASM)
        set(OPENSSL_ASM_PREPROCESSED ".s")
        get_filename_component(OPENSSL_ASM_COMPILER "${CMAKE_ASM_NASM_COMPILER}" NAME_WLE)
    endif()
endif()

# HACK
set (OPENSSL_HW_CAPI ${OPENSSL_CAPIENG} CACHE BOOL "(automatically set, use OPENSSL_CAPIENG if this is to be modified)" FORCE)
set (OPENSSL_NO_HW_CAPI ${OPENSSL_NO_CAPIENG} CACHE BOOL "(automatically set, use OPENSSL_CAPIENG if this is to be modified)" FORCE)
set (OPENSSL_HW_CCGOST ${OPENSSL_GOST} CACHE BOOL "(automatically set, use OPENSSL_GOST if this is to be modified)" FORCE)
set (OPENSSL_NO_HW_CCGOST ${OPENSSL_NO_GOST} CACHE BOOL "(automatically set, use OPENSSL_GOST if this is to be modified)" FORCE)
set (OPENSSL_HW_GMP ${OPENSSL_GMP} CACHE BOOL "(automatically set, use OPENSSL_GMP if this is to be modified)" FORCE)
set (OPENSSL_NO_HW_GMP ${OPENSSL_NO_GMP} CACHE BOOL "(automatically set, use OPENSSL_GMP if this is to be modified)" FORCE)

if (OPENSSL_KRB5)
    # let's just find MIT krb5 temporarily
    # ... then using PkgConfig::MIT_KRB5 for further linking is fine, it is an imported target
    # TODO: cflags = -DKRB5_MIT_OLD11 (if krb5 version is older than 1.1)
    find_package(PkgConfig REQUIRED)
    pkg_search_module(MIT_KRB5 REQUIRED IMPORTED_TARGET GLOBAL mit-krb5 krb5)
    set(OPENSSL_NO_KRB5 OFF CACHE BOOL "build OpenSSL without Kerberos 5 (automatically set, use OPENSSL_KRB5 if this is to be modified)" FORCE)
else()
    set(OPENSSL_NO_KRB5 ON CACHE BOOL "build OpenSSL without Kerberos 5 (automatically set, use OPENSSL_KRB5 if this is to be modified)" FORCE)
endif()

if (NOT OPENSSL_COMP AND OPENSSL_ZLIB)
    message(AUTHOR_WARNING "comp cipher is not included and zlib is meaningless. Original OpenSSL desided to directly disable zlib build. "
                           "Let's just copy their behavior.")
    set(OPENSSL_ZLIB OFF CACHE BOOL "build with ZLIB" FORCE)
endif()

if (OPENSSL_ZLIB)
    find_package(ZLIB REQUIRED)
    if (OPENSSL_ZLIB_DYNAMIC)
        set(OPENSSL_NO_ZLIB_DYNAMIC OFF CACHE BOOL "build ZLIB not as dynamic loaded object (automatically set, use OPENSSL_ZLIB_DYNAMIC if this is to be modified)" FORCE)
    else()
        set(OPENSSL_NO_ZLIB_DYNAMIC ON CACHE BOOL "build ZLIB not as dynamic loaded object (automatically set, use OPENSSL_ZLIB_DYNAMIC if this is to be modified)" FORCE)
    endif()
    set(OPENSSL_NO_ZLIB OFF CACHE BOOL "build without ZLIB (automatically set, use OPENSSL_ZLIB if this is to be modified)" FORCE)
else()
    set(OPENSSL_NO_ZLIB ON CACHE BOOL "build without ZLIB (automatically set, use OPENSSL_ZLIB if this is to be modified)" FORCE)
endif()

if (OPENSSL_STATIC_ENGINE)
    set(OPENSSL_NO_DYNAMIC_ENGINE ON CACHE BOOL "generate static engine library (automatically set, use OPENSSL_STATIC_ENGINE if this is to be modified)" FORCE)
    set(OPENSSL_NO_STATIC_ENGINE OFF CACHE BOOL "generate dynamic engine library (automatically set, use OPENSSL_STATIC_ENGINE if this is to be modified)" FORCE)
    set(OPENSSL_DYNAMIC_ENGINE OFF CACHE BOOL "generate dynamic engine library (automatically set, use OPENSSL_STATIC_ENGINE if this is to be modified)" FORCE)
else()
    set(OPENSSL_NO_DYNAMIC_ENGINE OFF CACHE BOOL "generate static engine library (automatically set, use OPENSSL_STATIC_ENGINE if this is to be modified)" FORCE)
    set(OPENSSL_NO_STATIC_ENGINE ON CACHE BOOL "generate dynamic engine library (automatically set, use OPENSSL_STATIC_ENGINE if this is to be modified)" FORCE)
    set(OPENSSL_DYNAMIC_ENGINE ON CACHE BOOL "generate dynamic engine library (automatically set, use OPENSSL_STATIC_ENGINE if this is to be modified)" FORCE)
endif()

if (OPENSSL_THREADS)
    find_package(Threads REQUIRED)
    set(OPENSSL_NO_THREADS OFF CACHE BOOL "Build without threads supported (automatically set, use OPENSSL_THREADS if this is to be modified)" FORCE)
else()
    set(OPENSSL_NO_THREADS ON CACHE BOOL "Build without threads supported (automatically set, use OPENSSL_THREADS if this is to be modified)" FORCE)
endif()

configure_file(${CMAKE_SOURCE_DIR}/openssl/e_os2.h ${CMAKE_BINARY_DIR}/include/openssl/e_os2.h COPYONLY)


# list the original platform descriptions - How can this be so complicated?
# currently only supported platforms are listed - other platforms will be added when finished
if (WIN32)
    if (MSVC)
        if (OPENSSL_TARGET_ARCH STREQUAL "x64")
            set(OPENSSL_BUILD_PLATFORM "VC-WIN64A")
        elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
            set(OPENSSL_BUILD_PLATFORM "VC-WIN32")
        endif()
    else()
        if (OPENSSL_TARGET_ARCH STREQUAL "x64")
            set(OPENSSL_BUILD_PLATFORM "mingw64")
        elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
            set(OPENSSL_BUILD_PLATFORM "mingw")
        endif()
    endif()
elseif (CYGWIN)
    if (OPENSSL_TARGET_ARCH STREQUAL "x64")
        set(OPENSSL_BUILD_PLATFORM "Cygwin-x86_64")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_BUILD_PLATFORM "Cygwin")
    endif()
elseif (APPLE AND NOT IOS)
    if (OPENSSL_OSX_ARCHITECTURES_LENGTH GREATER 1)
        # set in buildinf.h.appleUnified.cmake.in
    else()
        if (OPENSSL_TARGET_ARCH STREQUAL "x64")
            set(OPENSSL_BUILD_PLATFORM "darwin64-x86_64-cc")
        elseif (OPENSSL_TARGET_ARCH STREQUAL "arm64")
            # This is not something OpenSSL 1.0.2 is currently supporting.
            set(OPENSSL_BUILD_PLATFORM "darwin64-arm64-cc")
        endif()
    endif()
elseif (IOS)
    set(OPENSSL_BUILD_PLATFORM "iphoneos-cross")
elseif (ANDROID)
    if (OPENSSL_TARGET_ARCH STREQUAL "arm32")
        set(OPENSSL_BUILD_PLATFORM "android-armv7")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_BUILD_PLATFORM "android-x86")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "arm64")
        set(OPENSSL_BUILD_PLATFORM "android64-aarch64")
    else()
        set(OPENSSL_BUILD_PLATFORM "android")
    endif()
elseif (CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
    if (OPENSSL_TARGET_ARCH STREQUAL "x64")
        if (CMAKE_C_COMPILER_ID MATCHES "[Cc]lang")
            set(OPENSSL_BUILD_PLATFORM "linux-x86_64-clang")
        else()
            set(OPENSSL_BUILD_PLATFORM "linux-x86_64")
        endif()
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_BUILD_PLATFORM "linux-elf")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "arm32")
        set(OPENSSL_BUILD_PLATFORM "linux-armv4")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "arm64")
        set(OPENSSL_BUILD_PLATFORM "linux-aarch64")
    else()
        if (CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(OPENSSL_BUILD_PLATFORM "linux-generic64")
        else()
            set(OPENSSL_BUILD_PLATFORM "linux-generic32")
        endif()
    endif()
elseif (CMAKE_SYSTEM_NAME MATCHES "BSD")
    if (OPENSSL_TARGET_ARCH STREQUAL "x64")
        set(OPENSSL_BUILD_PLATFORM "BSD-x86_64")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_BUILD_PLATFORM "BSD-x86-elf")
    else()
        if (CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(OPENSSL_BUILD_PLATFORM "BSD-generic64")
        else()
            set(OPENSSL_BUILD_PLATFORM "BSD-generic32")
        endif()
    endif()
elseif (CMAKE_SYSTEM_NAME MATCHES "SunOS")
    if (OPENSSL_TARGET_ARCH STREQUAL "x64")
        if (CMAKE_C_COMPILER_ID MATCHES "GNU")
            set(OPENSSL_BUILD_PLATFORM "solaris64-x86_64-gcc")
        elseif (CMAKE_C_COMPILER_ID MATCHES "SunPro")
            set(OPENSSL_BUILD_PLATFORM "solaris64-x86_64-cc")
        endif()
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
        if (CMAKE_C_COMPILER_ID MATCHES "GNU")
            set(OPENSSL_BUILD_PLATFORM "solaris-x86-gcc")
        elseif (CMAKE_C_COMPILER_ID MATCHES "SunPro")
            set(OPENSSL_BUILD_PLATFORM "solaris-x86-cc")
        endif()
    endif()
endif()

if (BUILD_TESTING)
    add_library(OpenSSLTest INTERFACE)
    target_include_directories(OpenSSLTest INTERFACE "${CMAKE_SOURCE_DIR}/openssl/test")
    target_sources(OpenSSLTest INTERFACE "${CMAKE_SOURCE_DIR}/openssl/test/testutil.h" "${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.h")
    add_custom_target(check ${CMAKE_CTEST_COMMAND})

    # builtin "make test" is useless for us.
    # it does not build the dependencies needed for our test.
    # cmake_policy(PUSH)
    # cmake_policy(SET CMP0037 OLD)
    # add_custom_target(test DEPENDS check)
    # cmake_policy(POP)
endif()

add_subdirectory(crypto)
add_subdirectory(ssl)
add_subdirectory(apps)
add_subdirectory(engines)
add_subdirectory(tools)
add_subdirectory(exporters)
#if (BUILD_TESTING)
#    add_subdirectory(test)
#endif()
if (OPENSSL_BUILD_DOCS)
    add_subdirectory(doc)
endif()

# CPack configuration items
if (DEFINED OPENSSL_BUILD_PLATFORM)
    set(CPACK_SYSTEM_NAME "${OPENSSL_BUILD_PLATFORM}")
elseif (APPLE AND NOT IOS AND ( OPENSSL_OSX_ARCHITECTURES_LENGTH GREATER 1 ) )
    set(CPACK_SYSTEM_NAME "darwin64-unified64")
endif()
set(CPACK_PACKAGE_VENDOR "Fsu0413/openssl-externalCMake")
set(CPACK_THREADS 0)
set(CPACK_PACKAGE_VERSION "${OPENSSL_VERSION_REAL}")
if (WIN32)
    set(CPACK_GENERATOR 7Z ZIP)
else()
    set(CPACK_GENERATOR TGZ TXZ)
endif()
if (CMAKE_HOST_WIN32)
    set(CPACK_SOURCE_GENERATOR 7Z ZIP)
else()
    set(CPACK_SOURCE_GENERATOR TGZ TXZ)
endif()
set(CPACK_SOURCE_IGNORE_FILES
    # Git / GitHub files
    [[/\\.git]]

    # Local configuration file - used in development environment for Fsu0413
    [[\\.FsEnv\\.cmake$]]

    # Temporary files
    [[~]]
    [[\\.orig$]]
    [[/\\.DS_Store/]]
    [[CMakeLists\\.txt\\.user.*$]]
    [[\\.autosave$]]

    # OpenSSL Travis CI files
    [[/openssl/\\.travis]]

    # OpenSSL Files not for release
    [[/openssl/crypto/des/t/]]
    [[/openssl/TABLE$]]
)
include(CPack)
