add_executable(md4test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/md4/md4test.c)
target_link_libraries(md4test PUBLIC OpenSSLTest crypto)
add_dependencies(check md4test)
add_test(NAME md4test COMMAND md4test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
