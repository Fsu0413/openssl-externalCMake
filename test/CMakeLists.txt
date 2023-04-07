
if (WIN32 AND BUILD_SHARED_LIBS)
    add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/test/libeay32.dll"
                       COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/crypto/libeay32.dll ${CMAKE_BINARY_DIR}/test/libeay32.dll
                       DEPENDS crypto
    )
    add_custom_target(copycrypto_test DEPENDS "${CMAKE_BINARY_DIR}/test/libeay32.dll")
    add_dependencies(check copycrypto_test)
endif()

if (WIN32 AND BUILD_SHARED_LIBS)
    add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/test/ssleay32.dll"
                       COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/ssl/ssleay32.dll ${CMAKE_BINARY_DIR}/test/ssleay32.dll
                       DEPENDS ssl
    )
    add_custom_target(copyssl_test DEPENDS "${CMAKE_BINARY_DIR}/test/ssleay32.dll")
    add_dependencies(check copyssl_test)
endif()

add_executable(igetest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/igetest.c)
target_link_libraries(igetest PUBLIC OpenSSLTest crypto)
add_dependencies(check igetest)
add_test(NAME igetest COMMAND igetest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

add_executable(x509_time_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/x509_time_test.c)
target_link_libraries(x509_time_test PUBLIC OpenSSLTest crypto)
add_dependencies(check x509_time_test)
add_test(NAME x509_time_test COMMAND x509_time_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

configure_file(trsa.cmake.in trsa.cmake @ONLY)
add_test(NAME trsa COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/trsa.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

configure_file(testenc.cmake.in testenc.cmake @ONLY)
add_test(NAME testenc COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/testenc.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

configure_file(tx509.cmake.in tx509.cmake @ONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/test/certs/pss1.pem certs/pss1.pem COPYONLY)
add_test(NAME tx509 COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/tx509.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

configure_file(tcrl.cmake.in tcrl.cmake @ONLY)
add_test(NAME tcrl COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/tcrl.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

configure_file(tsid.cmake.in tsid.cmake @ONLY)
add_test(NAME tsid COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/tsid.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

# !!!! treq depends on testgen
configure_file(${CMAKE_SOURCE_DIR}/openssl/test/test.cnf test.cnf COPYONLY)
configure_file(testgen.cmake.in testgen.cmake @ONLY)
add_test(NAME testgen COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/testgen.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

configure_file(treq.cmake.in treq.cmake @ONLY)
add_test(NAME treq COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/treq.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

configure_file(tpkcs7.cmake.in tpkcs7.cmake @ONLY)
add_test(NAME tpkcs7 COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/tpkcs7.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

if (NOT WIN32)
    # fails on Windows.
    # "ms/testpem.bat" doesn't test pkcs7-1.pem
    # Manually add the test cases to "ms/testpem.bat" results in test error.
    configure_file(tpkcs7d.cmake.in tpkcs7d.cmake @ONLY)
    add_test(NAME tpkcs7d COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/tpkcs7d.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
