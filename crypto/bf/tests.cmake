add_executable(bftest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/bf/bftest.c)
target_link_libraries(bftest PUBLIC OpenSSLTest crypto)
add_dependencies(check bftest)
add_test(NAME bftest COMMAND bftest COMMAND_EXPEND_LISTS)
