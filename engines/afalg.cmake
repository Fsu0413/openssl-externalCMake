# SPDX-License-Identifier: Unlicense

set(ENGINE_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/engines/e_afalg.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/e_afalg.h
    ${CMAKE_SOURCE_DIR}/openssl/engines/e_afalg_err.h
)

set(ENGINE_SOURCES ${ENGINE_SOURCES} ${ENGINE_CURRENTDIR_SOURCES})

unset(ENGINE_CURRENTDIR_SOURCES)
