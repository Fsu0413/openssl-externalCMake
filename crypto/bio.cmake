
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_cb.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_mem.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_fd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_file.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_sock.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_conn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_null.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_buff.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/b_print.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/b_dump.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/b_sock.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_acpt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bf_nbio.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_log.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_bio.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bss_dgram.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/bio/bio_lcl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
