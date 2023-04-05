
if (WIN32 AND BUILD_SHARED_LIBS)
    add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/test/libeay32.dll"
                       COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/crypto/libeay32.dll ${CMAKE_BINARY_DIR}/test/libeay32.dll
                       DEPENDS crypto
    )
    add_custom_target(copycrypto_test DEPENDS "${CMAKE_BINARY_DIR}/test/libeay32.dll")
    add_dependencies(check copycrypto_test)
endif()

if (WIN32 AND BUILD_SHARED_LIBS)
    add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/test/ssleay32.dll"
                       COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/ssl/ssleay32.dll ${CMAKE_BINARY_DIR}/test/ssleay32.dll
                       DEPENDS ssl
    )
    add_custom_target(copyssl_test DEPENDS "${CMAKE_BINARY_DIR}/test/ssleay32.dll")
    add_dependencies(check copyssl_test)
endif()

add_executable(igetest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/igetest.c)
target_link_libraries(igetest PUBLIC OpenSSLTest crypto)
add_dependencies(check igetest)
add_test(NAME igetest COMMAND igetest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
