
set(OPENSSL_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/apps/apps.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/opt.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_cb.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_socket.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/app_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/bf_prefix.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/asn1pars.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ca.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ciphers.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/cms.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/crl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/crl2p7.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/enc.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/errstr.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/genpkey.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/nseq.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/passwd.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs7.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs8.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyutl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/prime.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rand.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/req.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_client.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_server.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_time.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/sess_id.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/smime.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/speed.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/spkac.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/verify.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/version.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/x509.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rehash.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/storeutl.c
)

# convert progs.pl to cmake

add_custom_command(
    OUTPUT progs.h
    COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME=${CMAKE_CURRENT_BINARY_DIR}/progs.h -P ${CMAKE_CURRENT_SOURCE_DIR}/progs.cmake ${OPENSSL_SOURCES}
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs12.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/ec.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/ecparam.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/ocsp.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/srp.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/ts.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/dhparam.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/dsa.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/dsaparam.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/gendsa.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/engine.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/rsa.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/rsautl.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/genrsa.c
                                                                                                                               ${CMAKE_SOURCE_DIR}/openssl/apps/win32_init.c
    MAIN_DEPENDENCY progs.cmake
    DEPENDS ${OPENSSL_SOURCES}
            ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs12.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/ec.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/ecparam.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/ocsp.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/srp.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/ts.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/dhparam.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/dsa.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/dsaparam.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/gendsa.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/engine.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/rsa.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/rsautl.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/genrsa.c
            ${CMAKE_SOURCE_DIR}/openssl/apps/win32_init.c
    USES_TERMINAL
)

set(OPENSSL_HEADERS
    ${CMAKE_SOURCE_DIR}/openssl/apps/apps.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_apps.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/vms_term_sock.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/timeouts.h
    progs.h
)

set(OPENSSL_OPTIONAL_SOURCES)

if (OPENSSL_DES)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs12.c
    )
endif()
if (OPENSSL_EC)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/ec.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ecparam.c
    )
endif()
if (OPENSSL_OCSP)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/ocsp.c
    )
endif()
if (OPENSSL_SRP)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/srp.c
    )
endif()
if (OPENSSL_TS)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/ts.c
    )
endif()
if (OPENSSL_DH)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/dhparam.c
    )
endif()
if (OPENSSL_DSA)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/dsa.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dsaparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/gendsa.c
    )
endif()
if (OPENSSL_ENGINE)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/engine.c
    )
endif()
if (OPENSSL_RSA)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/rsa.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/rsautl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/genrsa.c
    )
endif()
if (WIN32)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/win32_init.c
    )
endif()

add_executable(openssl
    ${OPENSSL_SOURCES}
    ${OPENSSL_OPTIONAL_SOURCES}
    ${OPENSSL_HEADERS}
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

configure_file(tsget.cmake.in tsget @ONLY)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/tsget
    DESTINATION ${OPENSSL_OPENSSLDIR}/misc
)

install(FILES ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.cnf
    DESTINATION ${OPENSSL_OPENSSLDIR}
)

configure_file(openssl.pc.cmake.in openssl.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/openssl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)
