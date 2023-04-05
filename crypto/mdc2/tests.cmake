add_executable(mdc2test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/mdc2/mdc2test.c)
target_link_libraries(mdc2test PUBLIC OpenSSLTest crypto)
add_dependencies(check mdc2test)
add_test(NAME mdc2test COMMAND mdc2test COMMAND_EXPEND_LISTS)
