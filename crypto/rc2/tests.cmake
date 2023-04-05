add_executable(rc2test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/rc2/rc2test.c)
target_link_libraries(rc2test PUBLIC OpenSSLTest crypto)
add_dependencies(check rc2test)
add_test(NAME rc2test COMMAND rc2test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
