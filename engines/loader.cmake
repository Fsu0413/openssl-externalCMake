# SPDX-License-Identifier: Unlicense

set(ENGINE_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/engines/e_loader_attic.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/e_loader_attic_err.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/pem/pvkfmt.c
)

set(ENGINE_SOURCES ${ENGINE_SOURCES} ${ENGINE_CURRENTDIR_SOURCES})

unset(ENGINE_CURRENTDIR_SOURCES)
