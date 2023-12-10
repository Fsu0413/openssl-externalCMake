# SPDX-License-Identifier: Unlicense

# 0xf4, 0x55, 0x66, 0x50, 0xac, 0x31, 0xd3, 0x54, 0x61, 0x61, 0x0b, 0xac, 0x4e, 0xd8, 0x1b, 0x1a, 0x18, 0x1b, 0x2d, 0x8a, 0x43, 0xea, 0x28, 0x54, 0xcb, 0xae, 0x22, 0xca, 0x74, 0x56, 0x08, 0x13

# OPENSSL_FIPS_KEY_EXTRACTED

set(OPENSSL_FIPS_KEY_EXTRACTED_LIST)
set(OPENSSL_FIPS_KEY_REMAINDER "${OPENSSL_FIPS_KEY}")
string(LENGTH "${OPENSSL_FIPS_KEY}" OPENSSL_FIPS_KEY_LENGTH)
while (OPENSSL_FIPS_KEY_LENGTH GREATER 0)
    string(SUBSTRING "${OPENSSL_FIPS_KEY_REMAINDER}" 0 2 OPENSSL_FIPS_KEY_2)
    string(SUBSTRING "${OPENSSL_FIPS_KEY_REMAINDER}" 2 -1 OPENSSL_FIPS_KEY_REMAINDER_2)
    set(OPENSSL_FIPS_KEY_REMAINDER "${OPENSSL_FIPS_KEY_REMAINDER_2}")
    list(APPEND OPENSSL_FIPS_KEY_EXTRACTED_LIST "0x${OPENSSL_FIPS_KEY_2}")
    string(LENGTH "${OPENSSL_FIPS_KEY_REMAINDER}" OPENSSL_FIPS_KEY_LENGTH)
endwhile()
list(JOIN OPENSSL_FIPS_KEY_EXTRACTED_LIST ", " OPENSSL_FIPS_KEY_EXTRACTED)
configure_file(fipskey.h.cmake.in ${CMAKE_BINARY_DIR}/include/openssl/fipskey.h @ONLY)

# convert progs.pl to cmake

add_custom_command(
    OUTPUT progs.h progs.c
    COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME=${CMAKE_CURRENT_BINARY_DIR}/progs -P ${CMAKE_CURRENT_SOURCE_DIR}/progs.cmake
        ${CMAKE_SOURCE_DIR}/openssl/apps/asn1parse.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ca.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ciphers.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/cmp.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/cms.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/crl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/crl2pkcs7.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dgst.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dhparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dsa.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dsaparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ec.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ecparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/enc.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/engine.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/errstr.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/fipsinstall.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/gendsa.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/genpkey.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/genrsa.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/info.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/kdf.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/list.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/mac.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/nseq.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ocsp.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/passwd.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs12.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs7.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs8.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkey.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyutl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/prime.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/rand.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/rehash.c
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
        ${CMAKE_SOURCE_DIR}/openssl/apps/storeutl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ts.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/verify.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/version.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/x509.c
    MAIN_DEPENDENCY progs.cmake
    DEPENDS
        ${CMAKE_SOURCE_DIR}/openssl/apps/asn1parse.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ca.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ciphers.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/cmp.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/cms.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/crl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/crl2pkcs7.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dgst.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dhparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dsa.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/dsaparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ec.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ecparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/enc.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/engine.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/errstr.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/fipsinstall.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/gendsa.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/genpkey.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/genrsa.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/info.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/kdf.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/list.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/mac.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/nseq.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ocsp.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/passwd.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs12.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs7.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs8.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkey.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyparam.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/pkeyutl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/prime.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/rand.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/rehash.c
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
        ${CMAKE_SOURCE_DIR}/openssl/apps/storeutl.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/ts.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/verify.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/version.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/x509.c
    USES_TERMINAL
)

set(OPENSSL_HEADERS
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/app_libctx.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/app_params.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/apps.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/apps_ui.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/fmt.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/function.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/http_server.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/names.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/opt.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/s_apps.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/include/log.h

    progs.h
)

set(OPENSSL_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/apps.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/apps_ui.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/opt.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/fmt.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/s_cb.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/s_socket.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/columns.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_params.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/names.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_provider.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_x509.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/http_server.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/engine.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/engine_loader.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_libctx.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/log.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/lib/apps_opt_printf.c

    ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/asn1parse.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ca.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/ciphers.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/crl.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/crl2pkcs7.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/dgst.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/enc.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/errstr.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/genpkey.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/kdf.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/mac.c
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
    ${CMAKE_SOURCE_DIR}/openssl/apps/list.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/info.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/fipsinstall.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/pkcs12.c

    progs.c
)

set(OPENSSL_OPTIONAL_SOURCES)

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
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/tlssrp_depr.c
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
        ${CMAKE_SOURCE_DIR}/openssl/apps/genrsa.c
    )
    if (OPENSSL_DEPRECATED_3_0)
        list(APPEND OPENSSL_OPTIONAL_SOURCES
            ${CMAKE_SOURCE_DIR}/openssl/apps/rsautl.c
        )
    endif()
endif()
if (OPENSSL_CMS)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/cms.c
    )
endif()
if (OPENSSL_CMP)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/cmp.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/cmp_mock_srv.c
    )
endif()

if (WIN32)
    list(APPEND OPENSSL_OPTIONAL_SOURCES
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/win32_init.c
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
           ${CMAKE_SOURCE_DIR}/openssl/apps/include
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

configure_file(tsget.cmake.in tsget.pl @ONLY)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/tsget.pl
    DESTINATION ${OPENSSL_OPENSSLDIR}/misc
)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/tsget.pl
    DESTINATION ${OPENSSL_OPENSSLDIR}/misc
    RENAME tsget
)

install(FILES ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.cnf
    DESTINATION ${OPENSSL_OPENSSLDIR}
)
install(FILES ${CMAKE_SOURCE_DIR}/openssl/apps/openssl.cnf
    DESTINATION ${OPENSSL_OPENSSLDIR}
    RENAME openssl.cnf.dist
)
install(FILES ${CMAKE_SOURCE_DIR}/openssl/apps/ct_log_list.cnf
    DESTINATION ${OPENSSL_OPENSSLDIR}
)
install(FILES ${CMAKE_SOURCE_DIR}/openssl/apps/ct_log_list.cnf
    DESTINATION ${OPENSSL_OPENSSLDIR}
    RENAME ct_log_list.cnf.dist
)

configure_file(openssl.pc.cmake.in openssl.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/openssl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

#if (BUILD_TESTING)
#    if ( ( WIN32 OR CYGWIN ) AND BUILD_SHARED_LIBS )
#        get_target_property(CRYPTO_RUNTIME_OUTPUT_NAME crypto RUNTIME_OUTPUT_NAME)
#        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}"
#                           COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/crypto/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}
#                           DEPENDS crypto
#        )
#        add_custom_target(copycrypto_apps DEPENDS "${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}")
#        add_dependencies(check copycrypto_apps)
#        get_target_property(SSL_RUNTIME_OUTPUT_NAME ssl RUNTIME_OUTPUT_NAME)
#        add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}"
#                           COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}
#                           DEPENDS ssl
#        )
#        add_custom_target(copyssl_apps DEPENDS "${CMAKE_BINARY_DIR}/apps/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}")
#        add_dependencies(check copyssl_apps)
#    endif()
#    add_dependencies(check openssl)
#endif()
