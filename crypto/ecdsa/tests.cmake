add_executable(ecdsatest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecdsatest.c)
target_link_libraries(ecdsatest PUBLIC OpenSSLTest crypto)
add_dependencies(check ecdsatest)
add_test(NAME ecdsatest COMMAND ecdsatest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
