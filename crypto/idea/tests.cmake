add_executable(ideatest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/idea/ideatest.c)
target_link_libraries(ideatest PUBLIC OpenSSLTest crypto)
add_dependencies(check ideatest)
add_test(NAME ideatest COMMAND ideatest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
