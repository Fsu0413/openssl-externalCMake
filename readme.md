This is a totally external CMake project for building OpenSSL.

This branch is for OpenSSL 1.0.2 series.

## Why another makefile generator?

OpenSSL itself originally comes with its hand-craft Perl-based Makefile generator.
Developers of OpenSSL say that it satisfies their need of building this project on their supported platforms.

But things do not as that simple as they thought. There are some points people need but they do not pay attention of:

1. This generator have an assumed and fixed environment, toolchain and make tool combination. E.g., building for MinGW needs MSYS environment with MSYS make. cmd won't work.
1. Multi-process build progress on some platform is not ever considered. E.g., only Nmake is supported on MSVC which always runs commands one by one.
1. Command line instruction is confusing. No warning or error are populated to user even if wrong argument is provided. But instead it passes the unrecognized arguments directly to compiler or linker.
1. No IDE support for this hand-craft Makefile generator
1. (1.0.2 and before) Out-of-tree build (shadow build) is not supported.
1. (1.0.2 and before) Windows build have different instruction. It is not that straightforward for typical Configure-make-install instruction.

There have been since a lot of people requesting OpenSSL team switch to a common and widely used Makefile generator they still won't.
The reason is that any widely used one they have been told don't support all platforms OpenSSL is developing against.
See openssl/openssl#10902 and openssl/openssl#16812 for details.

Since OpenSSL build system is not that perfect I decided to write another build system for it.
In order not to touch OpenSSL source tree we'd build it externally.

## Why CMake? Or why not autotools / meson / (some other Makefile generator)?

1. CMake is widely used in open source projects. It supports a majority of common platforms and is easy for users to using it.
1. I'm slightly more familiar with CMake than other Makefile generators.

Not using autotools is because it has poor support on Windows.
Not using other generators is because I have never used them before.

(I hate using Gradle! But Android application development needs it)

## What issue won't be resolved for building OpenSSL with CMake?

### Dependency of Perl

Perl is used in generating ASM and some other source code for OpenSSL.
I personally don't mind that building software needs other tools, if using tools can make software better.

## How to use this project? Or how to use CMake to build OpenSSL?

Just typical CMake procedure will work.

## TODOs

Sort by priority

1. `make install` support
1. `crypto.pc` and `ssl.pc` generation
1. `make test` support
1. Check cross build for Android (arm, arm64, x86)
1. uplink / applink for Win32 Windows. Currently it is commented out
1. Check build with zlib
1. Check build with krb5
1. Check build without threads
1. `OpenSSLConfig.cmake` generation
1. Support for BSDs
1. Support for mips(64) and arm(64) Linux
1. Other uncommon platform

Note: I won't support building **ON** OpenVMS provided CMake can't be run on it. However cross build for OpenVMS should be supported when I start working on uncommon platform.
