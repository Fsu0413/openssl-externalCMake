add_executable(rmdtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/ripemd/rmdtest.c)
target_link_libraries(rmdtest PUBLIC OpenSSLTest crypto)
add_dependencies(check rmdtest)
add_test(NAME rmdtest COMMAND rmdtest COMMAND_EXPEND_LISTS)
