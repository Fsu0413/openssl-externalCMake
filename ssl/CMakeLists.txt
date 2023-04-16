
set(LIBSSL_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/ssl/pqueue.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/packet.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/rec_layer_s3.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/extensions.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/extensions_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/extensions_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/extensions_cust.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_cbc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_msg.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/methods.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/tls13_enc.c
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
    ${CMAKE_SOURCE_DIR}/openssl/ssl/tls_srp.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_trce.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_utst.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/ssl3_buffer.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/ssl3_record.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/dtls1_bitmap.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/ssl3_record_tls13.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/packet_local.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_cert_table.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_local.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/record/record_local.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_local.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/asn1t.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/async.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/bn.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/buffer.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/comp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/conf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/crypto.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ct.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dh.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/dsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/e_os2.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/engine.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/evp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/hmac.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/kdf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/md5.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ocsp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/pem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rand.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rand_drbg.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/rsa.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sha.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/srp.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/ssl.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/sslerr.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/symhacks.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509.h
    ${CMAKE_SOURCE_DIR}/openssl/include/openssl/x509v3.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/cryptlib.h
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

install(TARGETS ssl
    RUNTIME
    LIBRARY
    ARCHIVE
)

#configure_file(libssl.pc.cmake.in libssl.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libssl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

if (false) #(BUILD_TESTING)
    if (WIN32 AND BUILD_SHARED_LIBS)
        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/ssl/libeay32.dll"
                           COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/crypto/libeay32.dll ${CMAKE_BINARY_DIR}/ssl/libeay32.dll
                           DEPENDS crypto
        )
        add_custom_target(copycrypto_ssl DEPENDS "${CMAKE_BINARY_DIR}/ssl/libeay32.dll")
        add_dependencies(check copycrypto_ssl)
    endif()

    add_executable(ssltest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/ssltest.c)
    target_link_libraries(ssltest PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check ssltest)
    add_test(NAME ssltest COMMAND ssltest -test_cipherlist WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS) # rest of test_ssl checks are put into /test directory

    add_executable(heartbeat_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/heartbeat_test.c)
    target_link_libraries(heartbeat_test PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check heartbeat_test)
    add_test(NAME heartbeat_test COMMAND heartbeat_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

    add_executable(clienthellotest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/clienthellotest.c)
    target_link_libraries(clienthellotest PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check clienthellotest)
    add_test(NAME clienthellotest COMMAND clienthellotest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

    add_executable(sslv2conftest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/sslv2conftest.c)
    target_link_libraries(sslv2conftest PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check sslv2conftest)
    add_test(NAME sslv2conftest COMMAND sslv2conftest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

    add_executable(dtlstest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/dtlstest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
    target_link_libraries(dtlstest PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check dtlstest)
    add_test(NAME dtlstest COMMAND dtlstest ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

    add_executable(bad_dtls_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/bad_dtls_test.c)
    target_link_libraries(bad_dtls_test PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check bad_dtls_test)
    add_test(NAME bad_dtls_test COMMAND bad_dtls_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

    add_executable(fatalerrtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/fatalerrtest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
    target_link_libraries(fatalerrtest PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check fatalerrtest)
    add_test(NAME fatalerrtest COMMAND fatalerrtest ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
