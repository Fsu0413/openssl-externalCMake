

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
