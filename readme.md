# openssl-externalCMake

This is a totally external CMake project for building OpenSSL.

This branch is for OpenSSL 1.1.0 series.

## Disclaimer

This project includes a full OpenSSL source code tree.  
The OpenSSL part of source is not made by me and I have no control of them. I just wrote build system for them.  
For any problem caused by OpenSSL please consult the responsible person for them, not me.  
I am not responsible for any problem caused by original OpenSSL.  
Also this project is using the Unlicense. Please check the LICENSE file for details of this license.

Recently I have received E-mails about the security problem and licensing issue of this project, in which I should register some kinds of VIP account for checking them out.  
I believe that the problems should comes with the OpenSSL part since this project includes EOL versions of OpenSSL in branches of past version (currently only 1.0.2).  
So stop checking this project for security issues since it always exists, where I can do nothing for it. Also stop bothering me with this kinds of E-mail with registration wall, I have no interest for registering VIP for any site.  
If problem is occuring in my part, file an issue here on GitHub, or E-mailing me with clear information. E-mails with registration walls will be simply ignored.

## Why another makefile generator?

OpenSSL itself originally comes with its hand-craft Perl-based Makefile generator.
Developers of OpenSSL say that it satisfies their need of building this project on their supported platforms.

But things do not as that simple as they thought. There are some points people need but they do not pay attention of:

1. This generator have an assumed and fixed environment, toolchain and make tool combination. E.g., building for MinGW needs MSYS environment with MSYS make. cmd won't work.
1. Multi-process build progress on some platform is not ever considered. E.g., only Nmake is supported on MSVC which always runs commands one by one.
1. Command line instruction is confusing. No warning or error are populated to user even if wrong argument is provided. But instead it passes the unrecognized arguments directly to compiler or linker.
1. No IDE support for this hand-craft Makefile generator

There have been since a lot of people requesting OpenSSL team switch to a common and widely used Makefile generator they still won't.
The reason is that any widely used one they have been told don't support all platforms OpenSSL is developing against.
See openssl/openssl#10902 and openssl/openssl#16812 for details.

Since OpenSSL build system is not that perfect I decided to write another build system for it.
In order not to touch OpenSSL source tree we'd build it externally.

## Why CMake? Or why not autotools / meson / (some other Makefile generator)?

1. CMake is widely used in open source projects. It supports a majority of common platforms and is easy for users to using it.
1. I'm slightly more familiar with CMake than other Makefile generators.
1. CMake itself is also a full-featured script interpretor with a lot of common file operations built-in (cmake -P / -E). With CMake one can create a simple runnable script on its own and does not depends on any other script interpretor.

Not using autotools is because it has poor support on Windows. It depends on full unix instructions even if the target platform is Microsoft Visual Studio.
Not using other generators is because I have never used them before.

(I hate using Gradle! But Android application development needs it)

## Why another CMake project?

There are currently some CMake project for OpenSSL on GitHub.
But I don't think either of them is a full-featured Makefile generator.

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
- A faster build method to build OpenSSL on some platforms

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

### Build errors and test failures which happens also using original Perl-based configuration tool

I'm using original OpenSSL as subproject and won't fix any problem which original OpenSSL have.

### Build and test of Krb5

It does not build on macOS on 1.0.2 branch and got removed on 1.1.1.

### Extra tests on submodule of OpenSSL

They are not even released to users. Maybe they are some kinds of internal test run by OpenSSL developers. I don't care if and how the internal tests passes.

## How to use this project? Or how to use CMake to build OpenSSL?

Just typical CMake procedure will work.

## TODOs

Sort by priority

### On 1.1.0 branch:

1. `make check` support
