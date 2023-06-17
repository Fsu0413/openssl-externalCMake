# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_cb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_print.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_dump.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_addr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_sock.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_sock2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/ossl_core_bio.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_mem.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_bio.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_fd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_file.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_sock.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_conn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_acpt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_dgram.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_log.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_core.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_buff.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_lbuf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_nbio.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_prefix.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_readbuff.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
