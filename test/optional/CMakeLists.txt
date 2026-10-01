# Optional upstream test programs, built against the CMake libraries.
if (OPENSSL_HQINTEROP)
    # The upstream Docker client writes to /downloads. Make the local tool
    # honor FILEPREFIX (as the server does), defaulting to the working directory.
    set(_hq_dir "${CMAKE_SOURCE_DIR}/openssl/test/quic-openssl-docker/hq-interop")
    file(READ "${_hq_dir}/quic-hq-interop.c" _hq_client)
    string(REPLACE [["/downloads/%s", req]] [["%s/%s", (getenv("FILEPREFIX") != NULL ? getenv("FILEPREFIX") : "."), req]]
        _hq_client "${_hq_client}")
    string(REPLACE "reqnames[read_offset + 1]" "reqnames[read_offset]" _hq_client "${_hq_client}")
    file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/quic-hq-interop.c" "${_hq_client}")
    foreach (_program quic-hq-interop quic-hq-interop-server)
        if (_program STREQUAL "quic-hq-interop")
            add_executable(${_program} "${CMAKE_CURRENT_BINARY_DIR}/quic-hq-interop.c")
        else()
            add_executable(${_program} "${_hq_dir}/${_program}.c")
        endif()
        target_link_libraries(${_program} PRIVATE ssl crypto)
    endforeach()
endif()

if (OPENSSL_ALLOCFAIL_TESTS)
    set(_testutil_sources
        basic_output output driver tests cb stanza format_output load fake_random
        test_cleanup main testutil_init options test_options provider apps_shims
        random helper compare)
    list(TRANSFORM _testutil_sources PREPEND "${CMAKE_SOURCE_DIR}/openssl/test/testutil/")
    list(TRANSFORM _testutil_sources APPEND ".c")
    add_library(allocfail_testutil STATIC ${_testutil_sources}
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/opt.c)
    target_include_directories(allocfail_testutil PUBLIC
        ${CMAKE_SOURCE_DIR}/openssl/test
        ${CMAKE_SOURCE_DIR}/openssl/apps/include
        ${CMAKE_BINARY_DIR}
        ${CMAKE_SOURCE_DIR}/openssl)
    target_link_libraries(allocfail_testutil PUBLIC crypto)
    if (WIN32)
        target_sources(allocfail_testutil PRIVATE ${CMAKE_SOURCE_DIR}/openssl/apps/lib/win32_init.c)
    endif()
    add_executable(handshake-memfail
        ${CMAKE_SOURCE_DIR}/openssl/test/handshake-memfail.c
        ${CMAKE_SOURCE_DIR}/openssl/test/helpers/ssltestlib.c)
    add_executable(x509-memfail ${CMAKE_SOURCE_DIR}/openssl/test/x509_memfail.c)
    add_executable(load_key_certs_crls_memfail
        ${CMAKE_SOURCE_DIR}/openssl/test/load_key_certs_crls_memfail.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/apps.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_rand.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_provider.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_libctx.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/fmt.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/apps_ui.c
        ${CMAKE_SOURCE_DIR}/openssl/apps/lib/app_x509.c
        ${CMAKE_SOURCE_DIR}/openssl/crypto/asn1/a_time.c
        ${CMAKE_SOURCE_DIR}/openssl/crypto/ctype.c)
    foreach (_program handshake-memfail x509-memfail load_key_certs_crls_memfail)
        target_link_libraries(${_program} PRIVATE allocfail_testutil ssl crypto)
    endforeach()
    foreach (_program handshake-memfail x509-memfail load_key_certs_crls_memfail)
        if (_program STREQUAL "handshake-memfail")
            set(_fixture "${CMAKE_SOURCE_DIR}/openssl/test/certs")
        elseif (_program STREQUAL "x509-memfail")
            # This workload verifies a certificate using its own public key.
            set(_fixture "${CMAKE_SOURCE_DIR}/openssl/test/certs/rootcert.pem")
        else()
            set(_fixture "${CMAKE_SOURCE_DIR}/openssl/test/certs/servercert.pem")
        endif()
        add_test(NAME allocfail-${_program}
            COMMAND "${PERL_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/cmake/run_memfail_test.pl"
                $<TARGET_FILE:${_program}> "${_fixture}")
    endforeach()
endif()
