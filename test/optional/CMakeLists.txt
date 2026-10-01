# Optional upstream test programs, built against the CMake libraries.
if (OPENSSL_HQINTEROP)
    # The upstream Docker client writes to /downloads. Make the local tool
    # honor FILEPREFIX (as the server does), defaulting to the working directory.
    set(_hq_dir "${CMAKE_SOURCE_DIR}/openssl/test/quic-openssl-docker/hq-interop")
    file(READ "${_hq_dir}/quic-hq-interop.c" _hq_client)
    string(REPLACE [["/downloads/%s", req]] [["%s/%s", (getenv("FILEPREFIX") != NULL ? getenv("FILEPREFIX") : "."), req]]
        _hq_client "${_hq_client}")
    string(REPLACE "reqnames[read_offset + 1]" "reqnames[read_offset]" _hq_client "${_hq_client}")
    file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/quic-hq-interop.c" "${_hq_client}")
    foreach (_program quic-hq-interop quic-hq-interop-server)
        if (_program STREQUAL "quic-hq-interop")
            add_executable(${_program} "${CMAKE_CURRENT_BINARY_DIR}/quic-hq-interop.c")
        else()
            add_executable(${_program} "${_hq_dir}/${_program}.c")
        endif()
        target_link_libraries(${_program} PRIVATE ssl crypto)
    endforeach()
endif()
