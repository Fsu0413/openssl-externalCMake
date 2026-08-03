# SPDX-License-Identifier: Unlicense

set(LIBSSL_SOURCES
    ${LIBSSL_SOURCES}
    ${CMAKE_SOURCE_DIR}/openssl/ssl/rio/poll_immediate.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/rio/poll_builder.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/rio/rio_notifier.c
)
