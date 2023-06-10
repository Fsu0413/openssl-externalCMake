# SPDX-License-Identifier: Unlicense

add_executable(enginetest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/engine/enginetest.c)
target_link_libraries(enginetest PUBLIC OpenSSLTest crypto)
add_dependencies(check enginetest)
add_test(NAME enginetest COMMAND enginetest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
