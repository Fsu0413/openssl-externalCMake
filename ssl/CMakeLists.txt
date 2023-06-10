# SPDX-License-Identifier: Unlicense

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
if (WIN32)
    configure_file(ssl.rc.cmake.in ssl.rc @ONLY)
    set(LIBSSL_SOURCES ${LIBSSL_SOURCES} ssl.rc)
endif()
add_library(ssl
    ${LIBSSL_SOURCES}
)
if (WIN32)
    set_target_properties(ssl PROPERTIES
        RUNTIME_OUTPUT_NAME ssleay32
    )
    if (MSVC)
        set_target_properties(ssl PROPERTIES
            ARCHIVE_OUTPUT_NAME ssleay32
        )
    endif()
endif()
set_target_properties(ssl PROPERTIES
    SOVERSION 1.0.0
    VERSION ${OPENSSL_VERSION_REAL}
)

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

configure_file(libssl.pc.cmake.in libssl.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libssl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

#if (BUILD_TESTING)
#    if (WIN32 AND BUILD_SHARED_LIBS)
#        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/ssl/libeay32.dll"
#                           COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/crypto/libeay32.dll ${CMAKE_BINARY_DIR}/ssl/libeay32.dll
#                           DEPENDS crypto
#        )
#        add_custom_target(copycrypto_ssl DEPENDS "${CMAKE_BINARY_DIR}/ssl/libeay32.dll")
#        add_dependencies(check copycrypto_ssl)
#    endif()

#    add_executable(ssltest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/ssltest.c)
#    target_link_libraries(ssltest PUBLIC OpenSSLTest crypto ssl)
#    add_dependencies(check ssltest)
#    add_test(NAME ssltest COMMAND ssltest -test_cipherlist WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS) # rest of test_ssl checks are put into /test directory

#    add_executable(heartbeat_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/heartbeat_test.c)
#    target_link_libraries(heartbeat_test PUBLIC OpenSSLTest crypto ssl)
#    add_dependencies(check heartbeat_test)
#    add_test(NAME heartbeat_test COMMAND heartbeat_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

#    add_executable(clienthellotest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/clienthellotest.c)
#    target_link_libraries(clienthellotest PUBLIC OpenSSLTest crypto ssl)
#    add_dependencies(check clienthellotest)
#    add_test(NAME clienthellotest COMMAND clienthellotest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

#    add_executable(sslv2conftest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/sslv2conftest.c)
#    target_link_libraries(sslv2conftest PUBLIC OpenSSLTest crypto ssl)
#    add_dependencies(check sslv2conftest)
#    add_test(NAME sslv2conftest COMMAND sslv2conftest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

#    add_executable(dtlstest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/dtlstest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
#    target_link_libraries(dtlstest PUBLIC OpenSSLTest crypto ssl)
#    add_dependencies(check dtlstest)
#    add_test(NAME dtlstest COMMAND dtlstest ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

#    add_executable(bad_dtls_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/bad_dtls_test.c)
#    target_link_libraries(bad_dtls_test PUBLIC OpenSSLTest crypto ssl)
#    add_dependencies(check bad_dtls_test)
#    add_test(NAME bad_dtls_test COMMAND bad_dtls_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

#    add_executable(fatalerrtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/ssl/fatalerrtest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
#    target_link_libraries(fatalerrtest PUBLIC OpenSSLTest crypto ssl)
#    add_dependencies(check fatalerrtest)
#    add_test(NAME fatalerrtest COMMAND fatalerrtest ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
#endif()
