# Parameter mapping

## Parameter map for this CMake project and original Perl-based `Configure`

| Perl `Configure` item | CMake parameter | Notes |
|-|-|-|
| `no-<cipher/something>` | `-DOPENSSL_<CIPHER/SOMETHING>=0` | Use capitalized CIPHER name in CMake.<br />`OPENSSL_NO_<CIPHER>` is set automatically. |
| `enable-<cipher/something>`<br />`threads` / `sctp` / `386` | `-DOPENSSL_<CIPHER/SOMETHING>=1`| |
| `--prefix=` | `-DCMAKE_INSTALL_PREFIX=` | |
| `--openssldir=` | `-DOPENSSL_OPENSSLDIR=` | Relative to `CMAKE_INSTALL_PREFIX` |
| `--api=` | `-DOPENSSL_MIN_API_LEVEL=` | |
| `no-shared static` | `-DBUILD_SHARED_LIBS=OFF` | A series of shared library is built by default.<br />Building shared and static library in one go is not supported by now. |
| (os/platform) | (automatically detected) | See following OS / Platform mapping |
| `--cross-compile-prefix=` | `-DCMAKE_TOOLCHAIN_FILE=`<br />(A totally different design) | Typical CMake cross build method are used |

## OS / Platform mapping

| Host | Auto-detected platform name (as if passed to `Configure`) | Notes |
|-|-|-|
| Windows x86_64 MSVC with NASM or without ASM | `VC-WIN64A` | |
| Windows x86_64 MSVC with ASM without NASM | `VC-WIN64A-MASM` | |
| Windows x86 MSVC | `VC-WIN32` | |
| Windows x86_64 MinGW | `mingw64` | |
| Windows x86 MinGW | `mingw` | |
| Cygwin x86_64 | `Cygwin-x86_64` | |
| Cygwin x86 | `Cygwin-x86` | Deprecated? |
| macOS x86_64 | `darwin64-x86_64-cc` | |
| macOS arm64 | `darwin64-arm64-cc` | |
| iOS x86_64 | `iossimulator-xcrun` | Distinguishing simulator / actual machine is not done |
| iOS arm32 | `ios-xcrun` | |
| iOS arm64 | `ios64-xcrun` | |
| iOS (unknown architecture) | `iphoneos-cross` | Legacy |
| Android x86_64 | `android-x86_64` | |
| Android arm32 | `android-arm` | |
| Android x86 | `android-x86` | |
| Android arm64 | `android-arm64` | |
| Android (unknown architecture) | `android` | Legacy |
| Linux x86_64 Clang | `linux-x86_64-clang` | |
| Linux x86_64 (other compiler) | `linux-x86_64` | |
| Linux x86 Clang | `linux-x86-clang` | |
| Linux x86 (other compiler) | `linux-x86` | |
| Linux arm32 | `linux-armv4` | |
| Linux arm64 | `linux-aarch64` | |
| Linux (unknown architecture, sizeof pointer equals 8) | `linux-generic64` | |
| Linux (unknown architecture, sizeof pointer equals 4) | `linux-generic32` | |
| Any BSD x86_64 | `BSD-x86_64` | |
| Any BSD x86 | `BSD-x86-elf` | |
| Any BSD (unknown architecture, sizeof pointer equals 8) | `BSD-generic64` | |
| Any BSD (unknown architecture, sizeof pointer equals 4) | `BSD-generic32` | |
| Others | (unknown) | Will be added when supported |
