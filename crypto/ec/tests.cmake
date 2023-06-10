# SPDX-License-Identifier: Unlicense

add_executable(ectest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/ec/ectest.c)
target_link_libraries(ectest PUBLIC OpenSSLTest crypto)
add_dependencies(check ectest)
add_test(NAME ectest COMMAND ectest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
