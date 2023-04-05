add_executable(md2test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/md2/md2test.c)
target_link_libraries(md2test PUBLIC OpenSSLTest crypto)
add_dependencies(check md2test)
add_test(NAME md2test COMMAND md2test COMMAND_EXPEND_LISTS)
