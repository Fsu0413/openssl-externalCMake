# SPDX-License-Identifier: Unlicense

add_executable(rsa_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/rsa/rsa_test.c)
target_link_libraries(rsa_test PUBLIC OpenSSLTest crypto)
add_dependencies(check rsa_test)
add_test(NAME rsa_test COMMAND rsa_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
