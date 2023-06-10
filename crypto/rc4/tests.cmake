# SPDX-License-Identifier: Unlicense

add_executable(rc4test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/rc4/rc4test.c)
target_link_libraries(rc4test PUBLIC OpenSSLTest crypto)
add_dependencies(check rc4test)
add_test(NAME rc4test COMMAND rc4test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
