# SPDX-License-Identifier: Unlicense

add_executable(jpaketest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/jpake/jpaketest.c)
target_link_libraries(jpaketest PUBLIC OpenSSLTest crypto)
add_dependencies(check jpaketest)
add_test(NAME jpaketest COMMAND jpaketest COMMAND_EXPEND_LISTS)
