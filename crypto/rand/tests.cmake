add_executable(randtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/rand/randtest.c)
target_link_libraries(randtest PUBLIC OpenSSLTest crypto)
add_dependencies(check randtest)
add_test(NAME randtest COMMAND randtest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
