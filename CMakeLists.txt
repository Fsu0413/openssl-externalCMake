# SPDX-License-Identifier: Unlicense

cmake_minimum_required(VERSION 3.22)

project(OpenSSL
    VERSION 1.1.0.12
    DESCRIPTION "TLS/SSL and crypto library"
    HOMEPAGE_URL "https://www.openssl.org/"
    LANGUAGES C
)

if (CMAKE_VERSION VERSION_LESS 3.25)
    # set variable LINUX and BSD (which wasn't introduced until CMake 3.25)
    # Note: We don't actually judge the variant of Linux or BSD so just make it "if"-compatible
    if (CMAKE_SYSTEM_NAME MATCHES "[Ll]inux")
        set(LINUX true)
    elseif (CMAKE_SYSTEM_NAME MATCHES "BSD" OR CMAKE_SYSTEM_NAME STREQUAL "DragonFly")
        set(BSD "${CMAKE_SYSTEM_NAME}")
    endif()
endif()

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
elseif (APPLE AND NOT IOS)
    set(CMAKE_SHARED_MODULE_SUFFIX ".dylib")
endif()

set(CMAKE_C_STANDARD 99)

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
cmake_dependent_option(OPENSSL_THREADS "Build with threads supported" ON "NOT MSVC" ON)

# [no-]shared
# iOS supports only static libraries
cmake_dependent_option(BUILD_SHARED_LIBS "Build Shared Libraries" ON "NOT IOS" OFF)

# no-dso
cmake_dependent_option(OPENSSL_DSO "use dymamic shared object loader code" ON "BUILD_SHARED_LIBS" OFF)

# fips (OpenSSL 1.1.1 series doesn't bundle the FIPS module)
# option(OPENSSL_FIPS "use FIPS" OFF)
set(OPENSSL_FIPS OFF CACHE BOOL "use FIPS")

# [no-]zlib
option(OPENSSL_ZLIB "build with ZLIB" OFF)

# zlib-dynamic
cmake_dependent_option(OPENSSL_ZLIB_DYNAMIC "build ZLIB as dynamic loaded object" OFF "OPENSSL_ZLIB" OFF)

# static_engine
cmake_dependent_option(OPENSSL_STATIC_ENGINE "generate static engine library" OFF "BUILD_SHARED_LIBS" ON)

cmake_dependent_option(OPENSSL_BUILD_DOCS "Build documentation" ON "Perl_FOUND" OFF)

foreach (_OPTION IN ITEMS hw hw-padlock asm err nasm)
    string(TOUPPER ${_OPTION} _OPTION_UPPER)
    string(REPLACE "-" "_" _OPTION_SYMBOL ${_OPTION_UPPER})
    string(CONCAT _OPTION_STR "OPENSSL_" ${_OPTION_SYMBOL})
    string(CONCAT _OPTION_HELP "enable OpenSSL option " ${_OPTION})
    if (_OPTION STREQUAL "asm")
        # building ASM needs Perl
        cmake_dependent_option("${_OPTION_STR}" "${_OPTION_HELP}" ON "Perl_FOUND" OFF)
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
set(OPENSSL_DEFAULT_DISABLED_CIPHERS asan crypto-mdebug crypto-mdebug-backtrace ec_nistp_64_gcc_128 egd external-tests fuzz-libfuzzer fuzz-afl heartbeats md2 msan rc5
                                     sctp ssl-trace ssl3 ssl3-method ubsan unit-test weak-ssl-ciphers)

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

macro (get_current_cipher_name_instead_of_deprecated)
    set(CIPHERNAME ${ARGV0})
    set(OUTPUTVAR ${ARGV1})
    if (CIPHERNAME STREQUAL "ripemd")
        set(${OUTPUTVAR} "rmd160")
        message(FATAL_ERROR "${CIPHERNAME} is not deprecated.")
    endif()
    unset(OUTPUTVAR)
    unset(CIPHERNAME)
endmacro()

foreach (_CIPHER IN ITEMS ripemd)
    # option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}")
    string(TOUPPER ${_CIPHER} _CIPHER_UPPER)
    string(REPLACE "-" "_" _CIPHER_SYMBOL ${_CIPHER_UPPER})
    string(CONCAT _CIPHER_STR "OPENSSL_" ${_CIPHER_SYMBOL})
    if (DEFINED CACHE{${_CIPHER_STR}})
        get_current_cipher_name_instead_of_deprecated(${_CIPHER} _CURRENT_CIPHER)
        string(TOUPPER ${_CURRENT_CIPHER} _CURRENT_CIPHER_UPPER)
        string(REPLACE "-" "_" _CURRENT_CIPHER_SYMBOL ${_CURRENT_CIPHER_UPPER})
        string(CONCAT _CURRENT_CIPHER_STR "OPENSSL_" ${_CURRENT_CIPHER_SYMBOL})
        string(CONCAT _CURRENT_CIPHER_HELP "enable OpenSSL cipher " ${_CURRENT_CIPHER})
        message(AUTHOR_WARNING "${_CIPHER_STR} is deprecated. Please use ${_CURRENT_CIPHER_STR} instead.")
        if (NOT DEFINED CACHE{${_CURRENT_CIPHER_STR}})
            set(${_CURRENT_CIPHER_STR} $CACHE{${_CIPHER_STR}} CACHE BOOL ${_CURRENT_CIPHER_HELP} FORCE)
        endif()
        string(CONCAT _CIPHER_NO_STR "OPENSSL_NO_" ${_CIPHER_SYMBOL})
        unset("${_CIPHER_NO_STR}" CACHE)
        unset("${_CIPHER_STR}" CACHE)
    endif()
endforeach()

foreach (_CIPHER IN ITEMS
        ssl des ec sock dgram dtls tls crypto-mdebug engine afalgeng stdio comp unit-test msan # dependent
        ssl3-method tls1-method tls1_1-method tls1_2-method dtls1-method dtls1_2-method # method
        aes asn1 bio bn buffer conf evp hmac kdf lhash md5 modes objects pem pkcs12 pkcs7 rand rsa sha stack txt_db x509 x509v3 # directories
        dtls1_2 dtls1 tls1_2 tls1_1 tls1 ssl3  # TLS protocol
        asan async autoalginit autoerrinit autoload-config bf blake2 camellia capieng cast chacha cmac cms crypto-mdebug-backtrace ct deprecated devcryptoeng dh dsa ec2m ecdh
        ecdsa ec_nistp_64_gcc_128 egd err filenames fuzz-libfuzzer fuzz-afl gost heartbeats idea makedepend md2 md4 mdc2 multiblock nextprotoneg pinshared ocb ocsp poly1305
        posix-io psk rc2 rc4 rc5 rdrand rfc3779 rmd160 scrypt sctp seed srp srtp ssl-trace ts ubsan ui whirlpool weak-ssl-ciphers uplink
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

    if (_CIPHER STREQUAL "afalgeng")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "LINUX;OPENSSL_ENGINE" OFF)
    elseif (_CIPHER STREQUAL "mdc2")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_DES" OFF)
    elseif (_CIPHER STREQUAL "ecdsa")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_EC" OFF)
    elseif (_CIPHER STREQUAL "ecdh")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_EC" OFF)
    elseif (_CIPHER STREQUAL "ssl3")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_SSL;OPENSSL_SSL3_METHOD" OFF)
    elseif (_CIPHER STREQUAL "dtls")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_DGRAM" OFF)
    elseif (_CIPHER STREQUAL "sctp")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_DGRAM" OFF)
    elseif (_CIPHER STREQUAL "dgram")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_SOCK" OFF)
    elseif (_CIPHER STREQUAL "dtls1")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_DTLS1_2;OPENSSL_DTLS;OPENSSL_DTLS_1_METHOD" OFF)
    elseif (_CIPHER STREQUAL "dtls1_2")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_DTLS;OPENSSL_DTLS1_2_METHOD" OFF)
    elseif (_CIPHER STREQUAL "dtls1-method")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_DTLS" OFF)
    elseif (_CIPHER STREQUAL "dtls1_2-method")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_DTLS" OFF)
    elseif (_CIPHER STREQUAL "tls1")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLS1_1;OPENSSL_TLS;OPENSSL_TLS1_METHOD" OFF)
    elseif (_CIPHER STREQUAL "tls1_1")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLS1_2;OPENSSL_TLS;OPENSSL_TLS1_1_METHOD" OFF)
    elseif (_CIPHER STREQUAL "tls1_2")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLS;OPENSSL_TLS1_2_METHOD" OFF)
    elseif (_CIPHER STREQUAL "tls1-method")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLS" OFF)
    elseif (_CIPHER STREQUAL "tls1_1-method")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLS" OFF)
    elseif (_CIPHER STREQUAL "tls1_2-method")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_TLS" OFF)
    elseif (_CIPHER STREQUAL "crypto-mdebug-backtrace")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_CRYPTO_MDEBUG" OFF)
    elseif (_CIPHER STREQUAL "devcryptoeng")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_ENGINE" OFF)
    elseif (_CIPHER STREQUAL "autoalginit")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "BUILD_SHARED_LIBS" OFF)
    elseif (_CIPHER STREQUAL "capieng")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_STDIO" OFF)
    elseif (_CIPHER STREQUAL "egd")
        # TODO: HOW TO DEAL WITH THIS??
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_STDIO" OFF)
        # cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "NOT OPENSSL_RAND_SEED_EGD" ON) # original Configure deleted $disabled{'egd'}
    elseif (_CIPHER STREQUAL "comp")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_ZLIB" OFF)
    elseif (_CIPHER STREQUAL "heartbeats")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "OPENSSL_NO_UNITTEST" OFF)
    elseif (_CIPHER STREQUAL "uplink")
        cmake_dependent_option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}" "WIN32;MSVC OR ( OPENSSL_TARGET_ARCH STREQUAL \"x86\" );NOT OPENSSL_386;BUILD_SHARED_LIBS" OFF)
    else()
        option("${_CIPHER_STR}" "${_CIPHER_HELP}" "${_CIPHER_DEFAULT}")
    endif()
    string(CONCAT _CIPHER_NO_STR "OPENSSL_NO_" ${_CIPHER_SYMBOL})
    string(CONCAT _CIPHER_NO_HELP "disable OpenSSL cipher " ${_CIPHER} " (automatically set, use ${_CIPHER_STR} if this is to be modified)")
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
        if (OPENSSL_ASM)
            message(AUTHOR_WARNING "OpenSSL doesn't support MASM officially. See Comments in Configurations/50-masm.conf.")
        endif()
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
set (OPENSSL_HW_AFALG ${OPENSSL_AFALGENG} CACHE BOOL "(automatically set, use OPENSSL_AFALGENG if this is to be modified)" FORCE)
set (OPENSSL_NO_HW_AFALG ${OPENSSL_NO_AFALGENG} CACHE BOOL "(automatically set, use OPENSSL_AFALGENG if this is to be modified)" FORCE)

if (OPENSSL_NO_DEPRECATED)
    set(OPENSSL_MIN_API_LEVEL "1.1.0" CACHE STRING "OpenSSL SSL minimum API LEVEL" FORCE)
else()
    # --api
    # option(OPENSSL_MIN_API_LEVEL "OpenSSL SSL minimum API LEVEL" "1.1.0")
    # set(OPENSSL_MIN_API_LEVEL "0" CACHE STRING "OpenSSL SSL minimum API LEVEL")
endif()

# currently only "1.1.0" / "1.0.0" / "0.9.8" are supported
if (DEFINED CACHE{OPENSSL_MIN_API_LEVEL})
    if (OPENSSL_MIN_API_LEVEL STREQUAL "1.1.0")
        set(OPENSSL_MIN_API "0x10100000L" CACHE STRING "" FORCE)
    elseif (OPENSSL_MIN_API_LEVEL STREQUAL "1.0.0")
        set(OPENSSL_MIN_API "0x10000000L" CACHE STRING "" FORCE)
    elseif (OPENSSL_MIN_API_LEVEL STREQUAL "0.9.8")
        set(OPENSSL_MIN_API "0x00908000L" CACHE STRING "" FORCE)
    else()
        message(FATAL_ERROR "minimal api level ${OPENSSL_MIN_API_LEVEL} is not supported by OpenSSL.")
    endif()
endif()

# some TWEAKS
if (OPENSSL_NO_SSL3 AND OPENSSL_NO_SSL3_METHOD)
    unset(OPENSSL_SSL)
    unset(OPENSSL_NO_SSL)
    set(OPENSSL_SSL OFF CACHE BOOL "enable OpenSSL cipher ssl (automatically set, use OPENSSL_SSL3 if this is to be modified)" FORCE)
    set(OPENSSL_NO_SSL ON CACHE BOOL "disable OpenSSL cipher ssl (automatically set, use OPENSSL_SSL3 if this is to be modified)" FORCE)
endif()
if (OPENSSL_NO_TLS1 AND OPENSSL_NO_TLS1_1 AND OPENSSL_NO_TLS1_2 AND OPENSSL_NO_TLS1_3 AND OPENSSL_NO_TLS1_METHOD AND OPENSSL_NO_TLS1_1_METHOD AND OPENSSL_NO_TLS1_2_METHOD)
    unset(OPENSSL_TLS)
    unset(OPENSSL_NO_TLS)
    set(OPENSSL_TLS OFF CACHE BOOL "enable OpenSSL cipher tls (automatically set, use one of OPENSSL_TLS* if this is to be modified)" FORCE)
    set(OPENSSL_NO_TLS ON CACHE BOOL "disable OpenSSL cipher tls (automatically set, use one of OPENSSL_TLS* if this is to be modified)" FORCE)
endif()
if (OPENSSL_NO_DTLS1 AND OPENSSL_NO_DTLS1_2 AND OPENSSL_NO_DTLS1_METHOD AND OPENSSL_NO_DTLS1_2_METHOD)
    unset(OPENSSL_DTLS)
    unset(OPENSSL_NO_DTLS)
    set(OPENSSL_DTLS OFF CACHE BOOL "enable OpenSSL cipher dtls (automatically set, use one of OPENSSL_DTLS* if this is to be modified)" FORCE)
    set(OPENSSL_NO_DTLS ON CACHE BOOL "disable OpenSSL cipher dtls (automatically set, use one of OPENSSL_DTLS* if this is to be modified)" FORCE)
endif()

# NOT SUPPORTING SANTIZERS?
if (OPENSSL_ASAN OR OPENSSL_UBSAN OR OPENSSL_MSAN)
    message(FATAL_ERROR "santizers are not supported for now.")
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

if (OPENSSL_DSO)
    set(OPENSSL_NO_DSO OFF CACHE BOOL "build without DSO (automatically set, use OPENSSL_DSO if this is to be modified)" FORCE)
else()
    set(OPENSSL_NO_DSO ON CACHE BOOL "build without DSO (automatically set, use OPENSSL_DSO if this is to be modified)" FORCE)
endif()

# list the original platform descriptions - How can this be so complicated?
# currently only supported platforms are listed - other platforms will be added when finished
if (WIN32)
    if (MSVC)
        if (OPENSSL_TARGET_ARCH STREQUAL "x64")
            if ( ( NOT OPENSSL_ASM ) OR OPENSSL_NASM )
                set(OPENSSL_BUILD_PLATFORM "VC-WIN64A")
            else()
                set(OPENSSL_BUILD_PLATFORM "VC-WIN64A-masm")
            endif()
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
        set(OPENSSL_BUILD_PLATFORM "Cygwin-x86")
    endif()
elseif (APPLE AND NOT IOS)
    if (OPENSSL_OSX_ARCHITECTURES_LENGTH GREATER 1)
        # set in buildinf.h.appleUnified.cmake.in
    else()
        if (OPENSSL_TARGET_ARCH STREQUAL "x64")
            set(OPENSSL_BUILD_PLATFORM "darwin64-x86_64-cc")
        elseif (OPENSSL_TARGET_ARCH STREQUAL "arm64")
            set(OPENSSL_BUILD_PLATFORM "darwin64-arm64-cc")
        endif()
    endif()
elseif (IOS)
    if (OPENSSL_TARGET_ARCH STREQUAL "x64")
        set(OPENSSL_BUILD_PLATFORM "iossimulator-xcrun")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "arm32")
        set(OPENSSL_BUILD_PLATFORM "ios-xcrun")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "arm64")
        set(OPENSSL_BUILD_PLATFORM "ios64-xcrun")
    else()
        set(OPENSSL_BUILD_PLATFORM "iphoneos-cross")
    endif()
elseif (ANDROID)
    if (OPENSSL_TARGET_ARCH STREQUAL "x64")
        if (CMAKE_C_COMPILER_ID MATCHES "[Cc]lang")
            set(OPENSSL_BUILD_PLATFORM "linux-x86_64-clang")
        else()
            set(OPENSSL_BUILD_PLATFORM "linux-x86_64")
        endif()
    elseif (OPENSSL_TARGET_ARCH STREQUAL "arm32")
        set(OPENSSL_BUILD_PLATFORM "android-armeabi")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
        set(OPENSSL_BUILD_PLATFORM "android-x86")
    elseif (OPENSSL_TARGET_ARCH STREQUAL "arm64")
        set(OPENSSL_BUILD_PLATFORM "android64-aarch64")
    else()
        set(OPENSSL_BUILD_PLATFORM "android")
    endif()
elseif (LINUX)
    if (OPENSSL_TARGET_ARCH STREQUAL "x64")
        if (CMAKE_C_COMPILER_ID MATCHES "[Cc]lang")
            set(OPENSSL_BUILD_PLATFORM "linux-x86_64-clang")
        else()
            set(OPENSSL_BUILD_PLATFORM "linux-x86_64")
        endif()
    elseif (OPENSSL_TARGET_ARCH STREQUAL "x86")
        if (CMAKE_C_COMPILER_ID MATCHES "[Cc]lang")
            set(OPENSSL_BUILD_PLATFORM "linux-x86-clang")
        else()
            set(OPENSSL_BUILD_PLATFORM "linux-x86")
        endif()
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
elseif (BSD)
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
            # set(OPENSSL_BUILD_PLATFORM "solaris-x86-cc")
            message(FATAL_ERROR "OpenSSL no longer supports solaris-x86-cc target. "
                "Search \"solaris-x86-cc\" in openssl/Configurations/10-main.conf to see what happens to OpenSSL.")
        endif()
    endif()
endif()

if (BUILD_TESTING)
    add_custom_target(check ${CMAKE_CTEST_COMMAND})
endif()

add_subdirectory(crypto)
add_subdirectory(ssl)
add_subdirectory(apps)
add_subdirectory(engines)
add_subdirectory(tools)
add_subdirectory(exporters)

# OpenSSL 1.1 redesigns the whole test program.
# It currently depends on configdata.pm (It did "eval" it instead of "use" it. See "util/perl/OpenSSL/Test/Utils.pm", line 87) which we never generate in CMake.
# So the ctest things will be a whole rewrite of the OpenSSL test platform.
# All the test cases should be rewritten, just as what we did in OpenSSL 1.0.2.
# This time it comes with 157 test cases instead of 57 during 1.0.2.
# A good thing is that all test related stuff has been moved from the indivisual directory to this "test" directory.
#if (BUILD_TESTING)
#    add_subdirectory(test)
#endif()

# OpenSSL 1.1 changed the process for building documentations.
# Current documentation build has become a pain that it processes the pod files one by one.
# Probably we'd take previous 1.0.2 procedure back into our local repository...??
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
    [[/openssl/Configurations/90-team\\.norelease\\.conf$]]
    [[/openssl/util/mktar\\.sh$]]

    # OpenSSL fuzzer files
    [[/openssl/fuzz/corpora/]]
)
include(CPack)
