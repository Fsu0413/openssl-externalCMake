add_executable(hmactest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/hmac/hmactest.c)
target_link_libraries(hmactest PUBLIC OpenSSLTest crypto)
add_dependencies(check hmactest)
add_test(NAME hmactest COMMAND hmactest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
