# SPDX-License-Identifier: Unlicense

set(LIBSSL_SOURCES
    ${LIBSSL_SOURCES}
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/rec_layer_s3.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/rec_layer_d1.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/record.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/record_local.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/tls_common.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/ssl3_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/tls1_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/tls13_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/tlsany_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/dtls_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/tls_multib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/tls_pad.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/recmethod_local.h
)

if (OPENSSL_KTLS)
    set(LIBSSL_SOURCES
        ${LIBSSL_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/ktls_meth.c
    )
endif()

if (OPENSSL_DEPRECATED_3_0)
    set(LIBSSL_SOURCES
        ${LIBSSL_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/ssl/record/methods/ssl3_cbc.c
    )
endif()
