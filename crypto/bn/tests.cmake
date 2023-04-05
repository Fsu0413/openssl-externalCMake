add_executable(bntest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bntest.c)
target_link_libraries(bntest PUBLIC OpenSSLTest crypto)
add_dependencies(check bntest)
# add_test(NAME bntest COMMAND bntest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS) # so complicated...

add_executable(exptest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/exptest.c)
target_link_libraries(exptest PUBLIC OpenSSLTest crypto)
add_dependencies(check exptest)
add_test(NAME exptest COMMAND exptest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
