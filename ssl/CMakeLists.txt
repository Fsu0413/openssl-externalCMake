# SPDX-License-Identifier: Unlicense

set(LIBSSL_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/ssl/pqueue.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/rec_layer_s3.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_cbc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_msg.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/methods.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_ext.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/rec_layer_d1.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_msg.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_dtls.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_srtp.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_cert.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_sess.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_ciph.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_stat.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_rsa.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_txt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_init.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_conf.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_mcnf.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/bio_ssl.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_err.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_reneg.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/tls_srp.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_trce.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_utst.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/ssl3_buffer.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/ssl3_record.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/dtls1_bitmap.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/packet_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/record_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/aes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1t.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/async.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/blowfish.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bn.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/buffer.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/camellia.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cast.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/cms.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf_api.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/crypto.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ct.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/des.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dtls1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/e_os2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ebcdic.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ec.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecdh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ecdsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/engine.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/evp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/hmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/idea.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/kdf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/lhash.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/mdc2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/modes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/obj_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ocsp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/opensslv.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ossl_typ.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs12.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pkcs7.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rand.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc4.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rc5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ripemd.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/safestack.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/seed.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srtp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/stack.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/symhacks.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/tls1.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ts.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/txt_db.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ui.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/whrlpool.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509_vfy.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509v3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/asn1t.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/constant_time_locl.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dane.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/dso.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/numbers.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/o_dir.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/o_str.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sslconf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/thread_once.h
)
if (WIN32)
    configure_file(ssl.rc.cmake.in ssl.rc @ONLY)
    set(LIBSSL_SOURCES ${LIBSSL_SOURCES} ssl.rc)
endif()
add_library(ssl
    ${LIBSSL_SOURCES}
)
if (WIN32)
    if (OPENSSL_TARGET_ARCH STREQUAL x64)
        set_target_properties(ssl PROPERTIES
            RUNTIME_OUTPUT_NAME libssl-1_1-x64
        )
    else()
        set_target_properties(ssl PROPERTIES
            RUNTIME_OUTPUT_NAME libssl-1_1
        )
    endif()
    if (MSVC)
        set_target_properties(ssl PROPERTIES
            ARCHIVE_OUTPUT_NAME libssl
        )
    endif()
endif()
set_target_properties(ssl PROPERTIES
    SOVERSION 1.1
    VERSION ${OPENSSL_VERSION_REAL}
)

target_include_directories(ssl
    PUBLIC ${CMAKE_BINARY_DIR}/include
           ${CMAKE_CURRENT_BINARY_DIR}
           ${CMAKE_SOURCE_DIR}/openssl
           ${CMAKE_SOURCE_DIR}/openssl/ssl
           ${CMAKE_SOURCE_DIR}/openssl/crypto
           ${CMAKE_SOURCE_DIR}/openssl/include
)

target_link_libraries(ssl
    PUBLIC crypto
)

get_target_property(LIBCRYPTO_CFLAGS crypto COMPILE_DEFINITIONS)

target_compile_definitions(ssl
    PRIVATE ${LIBCRYPTO_CFLAGS}
)

install(TARGETS ssl
    RUNTIME
    LIBRARY
    ARCHIVE
)

configure_file(libssl.pc.cmake.in libssl.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libssl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)
