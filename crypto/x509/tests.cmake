# SPDX-License-Identifier: Unlicense

configure_file(${CMAKE_SOURCE_DIR}/openssl/test/certs/roots.pem certs/roots.pem COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/test/certs/untrusted.pem certs/untrusted.pem COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/openssl/test/certs/bad.pem certs/bad.pem COPYONLY)

add_executable(verify_extra_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/verify_extra_test.c)
target_link_libraries(verify_extra_test PUBLIC OpenSSLTest crypto)
add_dependencies(check verify_extra_test)
add_test(NAME verify_extra_test COMMAND verify_extra_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
