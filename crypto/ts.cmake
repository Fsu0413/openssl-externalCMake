
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_req_utils.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_req_print.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_rsp_utils.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_rsp_print.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_rsp_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_rsp_verify.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_verify_ctx.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_conf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ts/ts.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
