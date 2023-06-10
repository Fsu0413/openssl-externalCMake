# SPDX-License-Identifier: Unlicense

add_executable(wp_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/whrlpool/wp_test.c)
target_link_libraries(wp_test PUBLIC OpenSSLTest crypto)
add_dependencies(check wp_test)
add_test(NAME wp_test COMMAND wp_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
