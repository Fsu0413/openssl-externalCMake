add_executable(destest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/des/destest.c)
target_link_libraries(destest PUBLIC OpenSSLTest crypto)
add_dependencies(check destest)
add_test(NAME destest COMMAND destest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
