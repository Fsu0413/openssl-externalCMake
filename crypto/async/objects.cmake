# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/async.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/async_wait.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/async_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/arch/async_posix.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/arch/async_win.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/arch/async_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/arch/async_null.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/arch/async_posix.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/arch/async_win.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/async/async_local.h
)
