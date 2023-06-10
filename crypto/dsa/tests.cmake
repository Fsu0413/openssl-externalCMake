# SPDX-License-Identifier: Unlicense

add_executable(dsatest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/dsa/dsatest.c)
target_link_libraries(dsatest PUBLIC OpenSSLTest crypto)
add_dependencies(check dsatest)
add_test(NAME dsatest COMMAND dsatest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
