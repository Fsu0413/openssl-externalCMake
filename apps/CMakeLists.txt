# SPDX-License-Identifier: Unlicense


set(OPENSSL_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/asn1pars.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ca.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ciphers.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/cms.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/crl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/crl2p7.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dhparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dsa.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dsaparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ec.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ecparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/enc.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/engine.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/errstr.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/gendsa.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/genpkey.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/genrsa.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/nseq.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ocsp.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/passwd.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs12.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs7.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs8.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkey.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyparam.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyutl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/prime.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rand.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/req.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rsa.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rsautl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_client.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_server.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_time.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/sess_id.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/smime.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/speed.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/spkac.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/srp.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ts.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/verify.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/version.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/x509.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/rehash.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/apps.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/opt.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_cb.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_socket.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/app_rand.c
)

# convert progs.pl to cmake

add_custom_command(
    OUTPUT progs.h
    COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME=${CMAKE_CURRENT_BINARY_DIR}/progs.h -P ${CMAKE_CURRENT_SOURCE_DIR}/progs.cmake ${OPENSSL_SOURCES}
    MAIN_DEPENDENCY progs.cmake
    DEPENDS ${OPENSSL_SOURCES}
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

if (WIN32)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/win32_init.c
    )
endif()

if (OPENSSL_UPLINK)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/ms/applink.c
    )
endif()

if (WIN32)
    configure_file(apps.rc.cmake.in apps.rc @ONLY)
    set(OPENSSL_SOURCES ${OPENSSL_SOURCES} apps.rc)
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

get_target_property(LIBCRYPTO_CFLAGS crypto COMPILE_DEFINITIONS)

target_compile_definitions(openssl
    PRIVATE -DMONOLITH
            ${LIBCRYPTO_CFLAGS}
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
    BUNDLE DESTINATION "${CMAKE_BINARY_DIR}"
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

if (BUILD_TESTING)
    if ( ( WIN32 OR CYGWIN ) AND BUILD_SHARED_LIBS )
        get_target_property(CRYPTO_RUNTIME_OUTPUT_NAME crypto RUNTIME_OUTPUT_NAME)
        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}"
                           COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/crypto/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}
                           DEPENDS crypto
        )
        add_custom_target(copycrypto_apps DEPENDS "${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}")
        add_dependencies(check copycrypto_apps)
        get_target_property(SSL_RUNTIME_OUTPUT_NAME ssl RUNTIME_OUTPUT_NAME)
        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}"
                           COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}
                           DEPENDS ssl
        )
        add_custom_target(copyssl_apps DEPENDS "${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}")
        add_dependencies(check copyssl_apps)
    endif()
    add_dependencies(check openssl)
endif()
