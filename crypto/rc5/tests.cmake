add_executable(rc5test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/rc5/rc5test.c)
target_link_libraries(rc5test PUBLIC OpenSSLTest crypto)
add_dependencies(check rc5test)
add_test(NAME rc5test COMMAND rc5test COMMAND_EXPEND_LISTS)
