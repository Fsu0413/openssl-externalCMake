
set(OPENSSL_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/apps/verify.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/asn1pars.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/req.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dh.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dhparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/enc.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/passwd.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/gendh.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/errstr.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ca.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs7.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/crl2p7.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/crl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rsa.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rsautl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dsa.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dsaparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ec.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ecparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/x509.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/genrsa.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/gendsa.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/genpkey.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_server.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_client.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/speed.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_time.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/version.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/sess_id.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ciphers.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/nseq.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs12.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs8.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyutl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/spkac.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/smime.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/cms.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rand.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/engine.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ocsp.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/prime.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ts.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/srp.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/apps.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_cb.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_socket.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/app_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/apps.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/progs.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_apps.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/testdsa.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/testrsa.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.c
)

add_executable(openssl
    ${OPENSSL_SOURCES}
)

if (WIN32)
    set_target_properties(openssl PROPERTIES
        VERSION ${OPENSSL_VERSION_REAL}
    )
endif()

target_compile_definitions(openssl
    PRIVATE -DMONOLITH
)

target_include_directories(openssl
    PUBLIC ${CMAKE_BINARY_DIR}/include
           ${CMAKE_CURRENT_BINARY_DIR}
           ${CMAKE_SOURCE_DIR}/openssl
           ${CMAKE_SOURCE_DIR}/openssl/ssl
           ${CMAKE_SOURCE_DIR}/openssl/crypto
)

target_link_libraries(openssl
    PUBLIC crypto ssl
)

install(TARGETS openssl
    RUNTIME
)

install(PROGRAMS CA.pl
    DESTINATION ${OPENSSL_OPENSSLDIR}/misc
)

install(PROGRAMS ${CMAKE_SOURCE_DIR}/openssl/apps/tsget
                 ${CMAKE_SOURCE_DIR}/openssl/apps/CA.sh
    DESTINATION ${OPENSSL_OPENSSLDIR}/misc
)

install(FILES ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.cnf
    DESTINATION ${OPENSSL_OPENSSLDIR}
)

configure_file(openssl.pc.cmake.in openssl.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/openssl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

if (NOT WIN32)
    configure_file(${CMAKE_SOURCE_DIR}/openssl/apps/CA.sh CA.sh COPYONLY)
endif()

if (BUILD_TESTING)
    add_dependencies(check openssl)

    if (WIN32 AND BUILD_SHARED_LIBS)
        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/apps/libeay32.dll"
                           COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/crypto/libeay32.dll ${CMAKE_BINARY_DIR}/apps/libeay32.dll
                           DEPENDS crypto
        )
        add_custom_target(copycrypto_apps DEPENDS "${CMAKE_BINARY_DIR}/apps/libeay32.dll")
        add_dependencies(check copycrypto_apps)
    endif()

    if (WIN32 AND BUILD_SHARED_LIBS)
        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/apps/ssleay32.dll"
                           COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/ssl/ssleay32.dll ${CMAKE_BINARY_DIR}/apps/ssleay32.dll
                           DEPENDS ssl
        )
        add_custom_target(copyssl_apps DEPENDS "${CMAKE_BINARY_DIR}/apps/ssleay32.dll")
        add_dependencies(check copyssl_apps)
    endif()

    if (NOT WIN32 AND NOT OPENSSL_NO_RSA)
        add_test(NAME testca COMMAND sh ${CMAKE_SOURCE_DIR}/openssl/test/testca WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/test COMMAND_EXPAND_LISTS)
    endif()

    configure_file(${CMAKE_SOURCE_DIR}/openssl/apps/dsa512.pem dsa512.pem COPYONLY) # needed for testgen / testss
    configure_file(${CMAKE_SOURCE_DIR}/openssl/apps/openssl.cnf openssl.cnf COPYONLY) # needed for treq
    configure_file(${CMAKE_SOURCE_DIR}/openssl/apps/server.pem server.pem COPYONLY) # needed for ssltest
    configure_file(${CMAKE_SOURCE_DIR}/openssl/apps/client.pem client.pem COPYONLY) # needed for ssltest
endif()
