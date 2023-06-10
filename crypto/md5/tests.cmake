# SPDX-License-Identifier: Unlicense

add_executable(md5test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/md5/md5test.c)
target_link_libraries(md5test PUBLIC OpenSSLTest crypto)
add_dependencies(check md5test)
add_test(NAME md5test COMMAND md5test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
