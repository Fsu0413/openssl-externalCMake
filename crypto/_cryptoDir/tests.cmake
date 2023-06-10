# SPDX-License-Identifier: Unlicense

add_executable(constant_time_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/constant_time_test.c)
target_link_libraries(constant_time_test PUBLIC OpenSSLTest crypto)
add_dependencies(check constant_time_test)
add_test(NAME constant_time_test COMMAND constant_time_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
