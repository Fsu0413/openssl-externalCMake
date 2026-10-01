# Exercise the public APIs affected by provider seeding and name registration.
add_executable(openssl_init_smoke default_init.c)
target_link_libraries(openssl_init_smoke PRIVATE ssl crypto)
add_test(NAME openssl-default-init COMMAND openssl_init_smoke
    "${CMAKE_SOURCE_DIR}/openssl/test/certs/rootcert.pem"
    "${CMAKE_SOURCE_DIR}/openssl/test/certs/servercert.pem")
