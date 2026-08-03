# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/thread/api.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/thread/arch/thread_win.c
)

if (OPENSSL_THREAD_POOL)
    set(LIBCRYPTO_CURRENTDIR_SOURCES
        ${LIBCRYPTO_CURRENTDIR_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/crypto/thread/arch.c
        ${CMAKE_SOURCE_DIR}/openssl/crypto/thread/arch/thread_none.c
        ${CMAKE_SOURCE_DIR}/openssl/crypto/thread/arch/thread_posix.c
        ${CMAKE_SOURCE_DIR}/openssl/crypto/thread/internal.c
    )
endif()
