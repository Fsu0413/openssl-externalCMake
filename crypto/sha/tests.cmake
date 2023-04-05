add_executable(shatest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/shatest.c)
target_link_libraries(shatest PUBLIC OpenSSLTest crypto)
add_dependencies(check shatest)
add_test(NAME shatest COMMAND shatest COMMAND_EXPEND_LISTS)

add_executable(sha1test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha1test.c)
target_link_libraries(sha1test PUBLIC OpenSSLTest crypto)
add_dependencies(check sha1test)
add_test(NAME sha1test COMMAND sha1test COMMAND_EXPEND_LISTS)

add_executable(sha256t EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha256t.c)
target_link_libraries(sha256t PUBLIC OpenSSLTest crypto)
add_dependencies(check sha256t)
add_test(NAME sha256t COMMAND sha256t COMMAND_EXPEND_LISTS)

add_executable(sha512t EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/sha/sha512t.c)
target_link_libraries(sha512t PUBLIC OpenSSLTest crypto)
add_dependencies(check sha512t)
add_test(NAME sha512t COMMAND sha512t COMMAND_EXPEND_LISTS)
