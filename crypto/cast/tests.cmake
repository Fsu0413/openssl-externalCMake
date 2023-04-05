add_executable(casttest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/cast/casttest.c)
target_link_libraries(casttest PUBLIC OpenSSLTest crypto)
add_dependencies(check casttest)
add_test(NAME casttest COMMAND casttest COMMAND_EXPEND_LISTS)
