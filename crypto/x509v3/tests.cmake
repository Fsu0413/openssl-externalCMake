add_executable(v3nametest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3nametest.c)
target_link_libraries(v3nametest PUBLIC OpenSSLTest crypto)
add_dependencies(check v3nametest)
add_test(NAME v3nametest COMMAND v3nametest COMMAND_EXPEND_LISTS)
