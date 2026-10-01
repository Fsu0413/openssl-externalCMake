# OpenSSL requires the static jitterentropy library for its JITTER seed source.
if (OPENSSL_JITTER)
    find_path(OPENSSL_JITTER_INCLUDE_DIR NAMES jitterentropy.h)
    find_file(OPENSSL_JITTER_LIBRARY NAMES libjitterentropy.a jitterentropy.lib
        PATHS ${CMAKE_PREFIX_PATH}
        PATH_SUFFIXES lib lib64)
    if (NOT OPENSSL_JITTER_INCLUDE_DIR OR NOT OPENSSL_JITTER_LIBRARY)
        message(FATAL_ERROR "OPENSSL_JITTER requires jitterentropy.h and the static jitterentropy library. Set OPENSSL_JITTER_INCLUDE_DIR and OPENSSL_JITTER_LIBRARY.")
    endif()
    add_library(OpenSSLJitter STATIC IMPORTED GLOBAL)
    set_target_properties(OpenSSLJitter PROPERTIES
        IMPORTED_LOCATION "${OPENSSL_JITTER_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_JITTER_INCLUDE_DIR}")
endif()
