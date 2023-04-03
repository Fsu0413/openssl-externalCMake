# openssl-externalCMake

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

## Why another CMake project?

There are currently some CMake project for OpenSSL on GitHub.
But I don't think either of them is a full-featured makefile generator.

The woes I spotted were:

- Some of them use ExternalProject for downloads on build .
- One of them calls `git config --global` which modifies global property of git (which makes it unusable for public)
- Some of them use original Perl-based configure script and make instructions (instead of replacing it)
- Some of them include only a subset of files of OpenSSL.
- Some of them only builds using a fixed set of options, not configurable.
- One of them is made for replacing `FindOpenSSL.cmake` by building it (which is not what I thinks of a CMake project)
- Some of them cannot build ASM. Mainly the ones which want to kill Perl dependency.

## Features for my CMake

What is my CMake project:

- A CMake project which aims for supporting all the features provided by the original Perl-based hand-crafted build system
- A more IDE-friendly alternative project file

What is NOT my CMake project:

- An alternative project which kills or tries to kill Perl dependency
- A wrapper which calls original Perl-based configure tool
- A CMake project which downloads stuff during build

## What issue won't be resolved for building OpenSSL with my CMake project?

### Dependency of Perl

Perl is used in generating ASM / documentation and some other source code for OpenSSL.
I personally don't mind that building software needs other tools, if using tools can make software better.

Perl is a language good at text manipulation thanks for its builtin regular expressions support.
I think that's why OpenSSL team decided to use Perl for code generation.

### Build errors which happens also using original Perl-based configuration tool

I'm using original OpenSSL as subproject and won't fix any problem which original OpenSSL have.

## How to use this project? Or how to use CMake to build OpenSSL?

Just typical CMake procedure will work.

## TODOs

Sort by priority

1. Windows resource file generation
1. `make test` support
1. 1.1.1 series support
1. 3.0 series support
1. 3.1 series support
1. 3.2 series support
1. Check cross build for Android (arm, arm64, x86)
1. Check build with krb5 - don't compile on 1.0.2 branch on arm64 macOS. Will try Windows and Linux
1. `OpenSSLConfig.cmake` generation
1. 1.0.1 series support
1. 1.0.0 series support
1. 0.9.8 series support
1. uplink / applink for Win32 Windows. Currently it is commented out (I don't even know what it does!)
1. Support for BSDs
1. Support for mips(64) and arm(64) Linux
1. Other uncommon platform

Note: I won't support building **ON** OpenVMS provided CMake can't be run on it. However cross build for OpenVMS should be supported when I start working on uncommon platform.
