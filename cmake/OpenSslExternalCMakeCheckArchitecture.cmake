# SPDX-License-Identifier: Unlicense

# CMake's builtin method (${CMAKE_SYSTEM_PROCERSSOR}) does not provide an accurate information, so we'd do it ourselves.

include(CheckSourceCompiles)

function(openssl_external_cmake_detect_target_arch arch)
    # Known conversions: Apple can define CMAKE_OSX_ARCHITECTURES, which will result in a multi-architecture build
    if (APPLE AND CMAKE_OSX_ARCHITECTURES)
        list(LENGTH CMAKE_OSX_ARCHITECTURES OPENSSL_OSX_ARCHITECTURES_LENGTH)
        set(OPENSSL_OSX_ARCHITECTURES_LENGTH "${OPENSSL_OSX_ARCHITECTURES_LENGTH}" PARENT_SCOPE)

        if (OPENSSL_OSX_ARCHITECTURES_LENGTH GREATER 1)
            if (OPENSSL_ASM)
                # TODO: complete this when CMake supports building different sets of file for different architectures
                # Currently only method for implementing it is to generate 2 set of libraries and use 'lipo' to combine them, since the compile flags are totally different.
                message(FATAL_ERROR "OPENSSL_ASM is incompatible with more than one CMAKE_OSX_ARCHITECTURES set on macOS, due to the file and compiler flags used for building it "
                                    "are totally different. "
                                    "If a multi-architecture build should be done, either build the all-in-one package with OPENSSL_ASM set to OFF or build them separately "
                                    "with OPENSSL_ASM set to ON and combine them using lipo provided by Apple.")
            endif()

            # since this is a multi-arch build detecting architecture is useless
            return()
        endif()
    endif()

    # https://github.com/cpredef/predef/blob/master/Architectures.md (2023/7/2)

    set(__openssl_external_cmake_detect_target_arch_alpha_IDENTIFICATION __alpha__ __alpha _M_ALPHA)
    set(__openssl_external_cmake_detect_target_arch_x64_IDENTIFICATION __amd64__ __amd64 __x86_64__ __x86_64 _M_X64 _M_AMD64)
    # CONSIDER: arm versions?
    set(__openssl_external_cmake_detect_target_arch_arm32_IDENTIFICATION __arm__ __thumb__ __TARGET_ARCH_ARM __TARGET_ARCH_THUMB _ARM _M_ARM _M_ARMT __arm)
    set(__openssl_external_cmake_detect_target_arch_arm64_IDENTIFICATION __aarch64__ _M_ARM64)
    set(__openssl_external_cmake_detect_target_arch_parisc_IDENTIFICATION __hppa__ __HPPA__ __hppa)
    set(__openssl_external_cmake_detect_target_arch_x86_IDENTIFICATION i386 __i386 __i386__ __IA32__ _M_IX86 __X86__ _X86_ __THW_INTEL__ __I86__ __INTEL__ __386)
    set(__openssl_external_cmake_detect_target_arch_ia64_IDENTIFICATION __ia64__ _IA64 __IA64__ __ia64 _M_IA64 __itanium__)
    # CONSIDER: la464 support?
    set(__openssl_external_cmake_detect_target_arch_loongarch_IDENTIFICATION __loongarch__ _LOONGARCH_ARCH)
    set(__openssl_external_cmake_detect_target_arch_m68k_IDENTIFICATION __m68k__ M68000 __MC68K__)
    # CONSIDER: mips versions? documentation of mips is unclear, maybe I'd find resources on Wikipedia
    set(__openssl_external_cmake_detect_target_arch_mips_IDENTIFICATION __mips__ mips __mips __MIPS__)
    set(__openssl_external_cmake_detect_target_arch_ppc_IDENTIFICATION __powerpc __powerpc__ __powerpc64__ __POWERPC__ __ppc__ __ppc64__ __PPC__ __PPC64__ _ARCH_PPC _ARCH_PPC64 _M_PPC __ppc)
    # CONSIDER: RISCV: Bit is determined in other macro
    set(__openssl_external_cmake_detect_target_arch_riscv_IDENTIFICATION __riscv __riscv__)
    # CONSIDER: separate sparcv7/v8/v9
    set(__openssl_external_cmake_detect_target_arch_sparc_IDENTIFICATION __sparc__ __sparc)
    set(__openssl_external_cmake_detect_target_arch_sh_IDENTIFICATION __sh__)
    # CONSIDER: separate s370/s390/s390x
    set(__openssl_external_cmake_detect_target_arch_systemz_IDENTIFICATION __370__ __THW_370__ __s390__ __s390x__ __zarch__ __SYSC_ZARCH__)

    # ARM64: must be checked before ARM (32-bit)
    # IA64, AMD64: must be checked before x86, although we'd not like to support ia64 soon
    # others are checked by priority, then popularity. LoongArch is prioritized for made by China!
    set(__openssl_external_cmake_detect_target_arch_IDENTIFICATION_LISTS x64 arm64 arm32 ia64 x86 loongarch riscv mips ppc parisc systemz sparc sh alpha m68k)
    unset(__openssl_external_cmake_detect_target_arch_IDENTIFIED_ARCH)
    foreach (__openssl_external_cmake_detect_target_arch_I IN LISTS __openssl_external_cmake_detect_target_arch_IDENTIFICATION_LISTS)
        set(__openssl_external_cmake_detect_target_arch_VAR "__openssl_external_cmake_detect_target_arch_${__openssl_external_cmake_detect_target_arch_I}_IDENTIFICATION")
        set(__openssl_external_cmake_detect_target_arch_SRC "#")
        foreach (__openssl_external_cmake_detect_target_arch_J IN LISTS ${__openssl_external_cmake_detect_target_arch_VAR})
            # The definitions are all macros so do not use the CheckSymbolExists
            set(__openssl_external_cmake_detect_target_arch_SRC "${__openssl_external_cmake_detect_target_arch_SRC}if defined(${__openssl_external_cmake_detect_target_arch_J})
#el")
        endforeach()
        set(__openssl_external_cmake_detect_target_arch_SRC "${__openssl_external_cmake_detect_target_arch_SRC}se
#error \"Macro for current architecture not found\"
#endif

int main(int argc, char *argv[]) {
(void)argc;
(void)argv;
return 0;
}")
        unset(__openssl_external_cmake_detect_target_arch_SRC_COMPILES)
        unset(__openssl_external_cmake_detect_target_arch_SRC_COMPILES CACHE)
        set(CMAKE_REQUIRED_QUIET true)
        check_source_compiles(C "${__openssl_external_cmake_detect_target_arch_SRC}" __openssl_external_cmake_detect_target_arch_SRC_COMPILES)
        unset(CMAKE_REQUIRED_QUIET)
        if (__openssl_external_cmake_detect_target_arch_SRC_COMPILES)
            set(__openssl_external_cmake_detect_target_arch_IDENTIFIED_ARCH "${__openssl_external_cmake_detect_target_arch_I}")
            break()
        endif()
    endforeach()

    if (DEFINED __openssl_external_cmake_detect_target_arch_IDENTIFIED_ARCH)
        set("${arch}" "${__openssl_external_cmake_detect_target_arch_IDENTIFIED_ARCH}" PARENT_SCOPE)
        message(NOTICE "Detected architecture - ${__openssl_external_cmake_detect_target_arch_IDENTIFIED_ARCH}")
        # TODO: consider above:
        # CONSIDER: ARM: arm versions?
        # CONSIDER: LoongArch: la464 support?
        # CONSIDER: MIPS: versions? documentation of mips is unclear, maybe I'd find resources on Wikipedia
        # CONSIDER: RISCV: Bit is determined in other macro
        # CONSIDER: SPARC: separate sparcv7/v8/v9
        # CONSIDER: SYSTEMZ: separate s370/s390/s390x
    else()
        if (OPENSSL_ASM)
            message(FATAL_ERROR "No supported architecture found. Since ASM only works with a known architecture please specify -DOPENSSL_ASM=NO during configure")
        else()
            message(WARNING "No supported architecture found.")
        endif()
    endif()
endfunction()

# Legacy method: read CMAKE_SYSTEM_PROCESSOR and CMAKE_SIZEOF_VOID_P

macro(openssl_external_cmake_detect_target_arch_legacy arch)
    set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET ${CMAKE_SYSTEM_PROCESSOR})
    set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH)

    # !!! for some platform host can run multiple architecture.
    # e.g. Windows amd64 can run / build Windows x86 in NATIVE.
    # Linux amd64 can run / build Linux x86 in NATIVE.
    # macOS arm64 can run / build macOS x86_64 in NATIVE.
    # need to figure out all these conditions?

    # for cross build on Apple platform
    if (APPLE AND ( NOT IOS ) AND CMAKE_OSX_ARCHITECTURES)
        list(LENGTH CMAKE_OSX_ARCHITECTURES OPENSSL_OSX_ARCHITECTURES_LENGTH)
        if (OPENSSL_OSX_ARCHITECTURES_LENGTH GREATER 1)
            if (OPENSSL_ASM)
                # TODO: complete this when CMake supports building different sets of file for different architectures
                # Currently only method for implementing it is to generate 2 set of libraries and use 'lipo' to combine them, since the compile flags are totally different.
                message(FATAL_ERROR "OPENSSL_ASM is incompatible with more than one CMAKE_OSX_ARCHITECTURES set on macOS, due to the file and compiler flags used for building it "
                                    "are totally different. "
                                    "If a multi-architecture build should be done, either build the all-in-one package with OPENSSL_ASM set to OFF or build them separately "
                                    "with OPENSSL_ASM set to ON and combine them using lipo provided by Apple.")
            endif()
        elseif (OPENSSL_OSX_ARCHITECTURES_LENGTH EQUAL 1)
            # the only target is the one from CMAKE_OSX_ARCHITECTURES
            list(GET CMAKE_OSX_ARCHITECTURES 0 __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET)
        else()
            # use CMAKE_SYSTEM_PROCESSOR directly since it is a fixed host build
        endif()
    elseif ( (NOT CMAKE_CROSSCOMPILING) OR ( CMAKE_SYSTEM_NAME STREQUAL CMAKE_HOST_SYSTEM_NAME ) )
        # treat this is host build if CMAKE_CROSSCOMPILING is not set or CMAKE_SYSTEM_NAME equals CMAKE_HST_SYSTEM_NAME
        # Normally CMake treats current build is cross build if CMAKE_SYSTEM_NAME is manually set
        # but it's not the case for Apple platforms!!

        if (MSVC)
            if ( ( DEFINED ENV{VSCMD_ARG_TGT_ARCH} ) AND ( NOT ( "x$ENV{VSCMD_ARG_TGT_ARCH}" STREQUAL "x" ) ) )
                # MSVC 2017 and later sets environment variable VSCMD_ARG_TGT_ARCH on execution of vcvars*.bat
                set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET $ENV{VSCMD_ARG_TGT_ARCH})
            elseif ( ( DEFINED ENV{PLATFORM} ) AND ( NOT ( "x$ENV{PLATFORM}" STREQUAL "x" ) ) )
                # MSVC 2015 sets environment variable PLATFORM on execution of vcvars*.bat
                set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET $ENV{PLATFORM})
            else()
                message(FATAL_ERROR "Please run vcvars*.bat before building using MSVC.")
            endif()
        elseif (CMAKE_SIZEOF_VOID_P EQUAL 4)
            # TODO: need to figure out if this is proper
            string(REGEX REPLACE "[\\-_]?64" "" __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET ${CMAKE_SYSTEM_PROCESSOR})
            string(TOUPPER ${__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET} __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_UPPER)
            if (__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_UPPER STREQUAL "AMD")
                set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET "x86")
            endif()
        endif()
    endif()

    if ( ( __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET MATCHES "[Aa][Mm][Dd]64" ) OR ( __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET MATCHES "[Xx]86[_\\-]64" ) OR ( __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET MATCHES "[Xx]64" ))
        set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH "x64")
    elseif ( ( __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET MATCHES "i[2-7]86" ) OR ( __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET MATCHES "[Xx]86" ) )
        set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH "x86")
    elseif ( ( __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET MATCHES "[Aa][Rr][Mm]") OR ( __openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET MATCHES "aarch" ) )
        if (__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET MATCHES "64")
            set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH "arm64")
        else()
            set(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH "arm32")
        endif()
    endif()
    set(${arch} ${__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH})
    unset(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH_GET)
    unset(__openssl_external_cmake_detect_target_arch_OPENSSL_TARGET_ARCH)
endmacro()
