# SPDX-License-Identifier: Unlicense

add_executable(dhtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/dh/dhtest.c)
target_link_libraries(dhtest PUBLIC OpenSSLTest crypto)
add_dependencies(check dhtest)
add_test(NAME dhtest COMMAND dhtest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
