

# issue: can't specify zlib path, especially for the condition that zlib is found by CMake but can't be found by pkgconfig
configure_file(pkg-config/libcrypto.pc.cmake.in libcrypto.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libcrypto.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

configure_file(pkg-config/libssl.pc.cmake.in libssl.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libssl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

configure_file(pkg-config/openssl.pc.cmake.in openssl.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/openssl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

get_target_property(OPENSSL_EXTERNALCMAKE_CRYPTO_ARCHIVE_OUTPUT_NAME crypto ARCHIVE_OUTPUT_NAME)
if (NOT OPENSSL_EXTERNALCMAKE_CRYPTO_ARCHIVE_OUTPUT_NAME)
    set(OPENSSL_EXTERNALCMAKE_CRYPTO_ARCHIVE_OUTPUT_NAME crypto)
endif()

get_target_property(OPENSSL_EXTERNALCMAKE_CRYPTO_LIBRARY_OUTPUT_NAME crypto LIBRARY_OUTPUT_NAME)
if (NOT OPENSSL_EXTERNALCMAKE_CRYPTO_LIBRARY_OUTPUT_NAME)
    set(OPENSSL_EXTERNALCMAKE_CRYPTO_LIBRARY_OUTPUT_NAME crypto)
endif()

get_target_property(OPENSSL_EXTERNALCMAKE_SSL_ARCHIVE_OUTPUT_NAME ssl ARCHIVE_OUTPUT_NAME)
if (NOT OPENSSL_EXTERNALCMAKE_SSL_ARCHIVE_OUTPUT_NAME)
    set(OPENSSL_EXTERNALCMAKE_SSL_ARCHIVE_OUTPUT_NAME ssl)
endif()

get_target_property(OPENSSL_EXTERNALCMAKE_SSL_LIBRARY_OUTPUT_NAME ssl LIBRARY_OUTPUT_NAME)
if (NOT OPENSSL_EXTERNALCMAKE_SSL_LIBRARY_OUTPUT_NAME)
    set(OPENSSL_EXTERNALCMAKE_SSL_LIBRARY_OUTPUT_NAME ssl)
endif()

configure_file(cmake/OpenSSLConfig.cmake.in OpenSSLConfig.cmake @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/OpenSSLConfig.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/OpenSSL
)

configure_file(cmake/OpenSSLConfigVersion.cmake.in OpenSSLConfigVersion.cmake @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/OpenSSLConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/OpenSSL
)
