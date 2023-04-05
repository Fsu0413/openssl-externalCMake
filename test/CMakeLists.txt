add_executable(igetest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/igetest.c)
target_link_libraries(igetest PUBLIC OpenSSLTest crypto)
add_dependencies(check igetest)
add_test(NAME igetest COMMAND igetest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
