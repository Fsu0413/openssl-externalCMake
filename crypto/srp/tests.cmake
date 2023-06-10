# SPDX-License-Identifier: Unlicense

add_executable(srptest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/srp/srptest.c)
target_link_libraries(srptest PUBLIC OpenSSLTest crypto)
add_dependencies(check srptest)
add_test(NAME srptest COMMAND srptest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
