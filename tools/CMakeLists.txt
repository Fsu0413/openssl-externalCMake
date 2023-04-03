
configure_file(c_rehash.cmake.in c_rehash @ONLY)

install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/c_rehash
    TYPE BIN
)
