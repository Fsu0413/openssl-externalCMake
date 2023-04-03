
configure_file(c_rehash.cmake.in c_rehash @ONLY)

install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/c_rehash
    TYPE BIN
)

install(PROGRAMS ${CMAKE_SOURCE_DIR}/openssl/tools/c_hash
                 ${CMAKE_SOURCE_DIR}/openssl/tools/c_info
                 ${CMAKE_SOURCE_DIR}/openssl/tools/c_issuer
                 ${CMAKE_SOURCE_DIR}/openssl/tools/c_name
    DESTINATION ${OPENSSL_OPENSSLDIR}/misc
)
