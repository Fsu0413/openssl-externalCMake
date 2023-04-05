add_executable(ecdhtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdh/ecdhtest.c)
target_link_libraries(ecdhtest PUBLIC OpenSSLTest crypto)
add_dependencies(check ecdhtest)
add_test(NAME ecdhtest COMMAND ecdhtest COMMAND_EXPEND_LISTS)
