
configure_file(${CMAKE_SOURCE_DIR}/openssl/ssl/ssl.h ${CMAKE_BINARY_DIR}/include/openssl/ssl.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/ssl/ssl2.h ${CMAKE_BINARY_DIR}/include/openssl/ssl2.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/ssl/ssl3.h ${CMAKE_BINARY_DIR}/include/openssl/ssl3.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/ssl/ssl23.h ${CMAKE_BINARY_DIR}/include/openssl/ssl23.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/ssl/tls1.h ${CMAKE_BINARY_DIR}/include/openssl/tls1.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/ssl/dtls1.h ${CMAKE_BINARY_DIR}/include/openssl/dtls1.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/ssl/kssl.h ${CMAKE_BINARY_DIR}/include/openssl/kssl.h COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/ssl/srtp.h ${CMAKE_BINARY_DIR}/include/openssl/srtp.h COPYONLY)

set(LIBSSL_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s2_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s2_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s2_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s2_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s2_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s2_pkt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_pkt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_both.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_cbc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s23_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s23_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s23_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s23_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s23_pkt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_ext.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_pkt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_both.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_srtp.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_err2.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_cert.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_sess.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_ciph.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_stat.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_rsa.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_txt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_algs.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_conf.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/bio_ssl.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_err.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/kssl.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_reneg.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/tls_srp.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_trce.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_utst.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl2.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl3.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl23.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/tls1.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/dtls1.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/kssl.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/srtp.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/kssl_lcl.h
)

add_library(ssl
    ${LIBSSL_SOURCES})

if (WIN32)
    set_target_properties(ssl
        PROPERTIES OUTPUT_NAME ssleay32
    )
endif()

target_include_directories(ssl
    PUBLIC ${CMAKE_BINARY_DIR}/include
           ${CMAKE_CURRENT_BINARY_DIR}
           ${CMAKE_SOURCE_DIR}/openssl
           ${CMAKE_SOURCE_DIR}/openssl/ssl
           ${CMAKE_SOURCE_DIR}/openssl/crypto
)

target_link_libraries(ssl
    PUBLIC crypto
)

install(TARGETS ssl
    RUNTIME
    LIBRARY
    ARCHIVE
)
