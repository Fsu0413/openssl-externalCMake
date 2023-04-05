configure_file(${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evptests.txt evptests.txt COPYONLY)

add_executable(evp_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_test.c)
target_link_libraries(evp_test PUBLIC OpenSSLTest crypto)
add_dependencies(check evp_test)
add_test(NAME evp_test COMMAND evp_test evptests.txt WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)

add_executable(evp_extra_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/evp/evp_extra_test.c)
target_link_libraries(evp_extra_test PUBLIC OpenSSLTest crypto)
add_dependencies(check evp_extra_test)
add_test(NAME evp_extra_test COMMAND evp_extra_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
