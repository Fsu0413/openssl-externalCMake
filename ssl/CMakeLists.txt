# SPDX-License-Identifier: Unlicense

set(LIBSSL_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/ssl/pqueue.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/extensions.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/extensions_srvr.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/extensions_clnt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/extensions_cust.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/s3_msg.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/methods.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/tls13_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_msg.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_dtls.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/d1_srtp.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_cert.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_sess.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_ciph.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_stat.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_rsa.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_txt.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_init.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_conf.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_mcnf.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/bio_ssl.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_err_legacy.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/tls_srp.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/t1_trce.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_utst.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_cert_comp.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/tls_depr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/packet.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/quic_vlint.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/time.c
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_cert_table.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_local.h
    ${CMAKE_SOURCE_DIR}/openssl/ssl/statem/statem_local.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/bio.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/constant_time.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/cryptlib.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/err.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/ktls.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/nelem.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/o_dir.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/packet.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/refcount.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sizes.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/sslconf.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/thread_once.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/tlsgroups.h
    ${CMAKE_SOURCE_DIR}/openssl/include/internal/statem.h
)

if (OPENSSL_DEPRECATED_3_0)
    set(LIBSSL_SOURCES
        ${LIBSSL_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/ssl/ssl_rsa_legacy.c
    )
endif()

include(record.cmake)

if (OPENSSL_QUIC)
    set(LIBSSL_SOURCES
        ${LIBSSL_SOURCES}
        ${CMAKE_SOURCE_DIR}/openssl/ssl/priority_queue.c
    )
    include(quic.cmake)
endif()

include(rio.cmake)

if (WIN32)
    configure_file(ssl.rc.cmake.in ssl.rc @ONLY)
    set(LIBSSL_SOURCES ${LIBSSL_SOURCES} ssl.rc)
    if (OPENSSL_TARGET_ARCH STREQUAL x64)
        set(LIBSSL_RUNTIME_OUTPUT_NAME libssl-3-x64)
    else()
        set(LIBSSL_RUNTIME_OUTPUT_NAME libssl-3)
    endif()

    if (BUILD_SHARED_LIBS)
        add_custom_command(
            OUTPUT ssl.def
            COMMAND "${CMAKE_COMMAND}" -DNUMFILE="${CMAKE_SOURCE_DIR}/openssl/util/libssl.num" -DLIBRARY_FILE="${LIBSSL_RUNTIME_OUTPUT_NAME}" -DBINARY_DIR="${CMAKE_BINARY_DIR}" -DOUTPUT_FILE="${CMAKE_CURRENT_BINARY_DIR}/ssl.def" -DPLATFORM=_WIN32 -P "${CMAKE_CURRENT_SOURCE_DIR}/../crypto/mkdef.cmake"
            MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/util/libssl.num"
            DEPENDS ../crypto/mkdef.cmake
        )
        set(LIBSSL_SOURCES ${LIBSSL_SOURCES} ssl.def)
    endif()
endif()
add_library(ssl
    ${LIBSSL_SOURCES}
)
if (OPENSSL_ASM)
    if ( ( OPENSSL_TARGET_ARCH STREQUAL "x64" ) OR ( OPENSSL_TARGET_ARCH STREQUAL "x86" ) )
        target_compile_definitions(ssl
            PRIVATE -DAES_ASM
        )
    endif()
endif()

if (WIN32)
    set_target_properties(ssl PROPERTIES
        RUNTIME_OUTPUT_NAME "${LIBSSL_RUNTIME_OUTPUT_NAME}"
    )
    if (MSVC)
        set_target_properties(ssl PROPERTIES
            ARCHIVE_OUTPUT_NAME libssl
        )
    endif()
elseif ( ( CMAKE_C_COMPILER_ID MATCHES "GNU" OR CMAKE_C_COMPILER_ID MATCHES "[Cc]lang" ) AND NOT APPLE AND NOT ( CMAKE_SYSTEM_NAME MATCHES "SunOS") )
    if (BUILD_SHARED_LIBS)
        add_custom_command(
            OUTPUT ssl.ld
            COMMAND "${CMAKE_COMMAND}" -DNUMFILE="${CMAKE_SOURCE_DIR}/openssl/util/libssl.num" -DLIBRARY_FILE="${LIBCRYPTO_RUNTIME_OUTPUT_NAME}" -DBINARY_DIR="${CMAKE_BINARY_DIR}" -DOUTPUT_FILE="${CMAKE_CURRENT_BINARY_DIR}/ssl.ld" -DPLATFORM=ELF -P "${CMAKE_CURRENT_SOURCE_DIR}/../crypto/mkdef.cmake"
            MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/util/libssl.num"
            DEPENDS ../crypto/mkdef.cmake
        )
        add_custom_target(ssl_map SOURCES ssl.ld)
        add_dependencies(ssl ssl_map)
        target_link_options(ssl PRIVATE "LINKER:--version-script=${CMAKE_CURRENT_BINARY_DIR}/ssl.ld")
    endif()
endif()
set_target_properties(ssl PROPERTIES
    SOVERSION 3
    VERSION ${OPENSSL_VERSION_REAL}
)

target_include_directories(ssl
    PUBLIC ${CMAKE_BINARY_DIR}/include
           ${CMAKE_CURRENT_BINARY_DIR}
           ${CMAKE_SOURCE_DIR}/openssl
           ${CMAKE_SOURCE_DIR}/openssl/ssl
           ${CMAKE_SOURCE_DIR}/openssl/crypto
           ${CMAKE_SOURCE_DIR}/openssl/include
)

target_link_libraries(ssl
    PUBLIC crypto
)

get_target_property(LIBCRYPTO_CFLAGS crypto COMPILE_DEFINITIONS)

target_compile_definitions(ssl
    PRIVATE ${LIBCRYPTO_CFLAGS}
)

install(TARGETS ssl
    RUNTIME
    LIBRARY
    ARCHIVE
)
