
set(_GENERATEDER_SOURCE_FILES_PATH
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_wrap_gen.c.in
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_digests_gen.c.in
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_rsa_gen.c.in
)

set(_GENERATEDER_HEADER_FILES_PATH
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_wrap.h.in
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_digests.h.in
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_rsa.h.in
)

if (OPENSSL_DSA)
    set(_GENERATEDER_SOURCE_FILES_PATH
        ${_GENERATEDER_SOURCE_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_dsa_gen.c.in
    )
    set(_GENERATEDER_HEADER_FILES_PATH
        ${_GENERATEDER_HEADER_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_dsa.h.in
    )
endif()

if (OPENSSL_EC)
    set(_GENERATEDER_SOURCE_FILES_PATH
        ${_GENERATEDER_SOURCE_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_ecx_gen.c.in
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_ec_gen.c.in
    )
    set(_GENERATEDER_HEADER_FILES_PATH
        ${_GENERATEDER_HEADER_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_ecx.h.in
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_ec.h.in
    )
endif()

if (OPENSSL_SM2)
    set(_GENERATEDER_SOURCE_FILES_PATH
        ${_GENERATEDER_SOURCE_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_sm2_gen.c.in
    )
    set(_GENERATEDER_HEADER_FILES_PATH
        ${_GENERATEDER_HEADER_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_sm2.h.in
    )
endif()

set(FILES_GENERATED)

foreach (_GENERATEDER_SOURCE_FILE_PATH IN LISTS _GENERATEDER_SOURCE_FILES_PATH)
    get_filename_component(_GENERATEDER_SOURCE_FILE_NAME "${_GENERATEDER_SOURCE_FILE_PATH}" NAME_WLE)
    add_custom_command(
        OUTPUT "common/der/${_GENERATEDER_SOURCE_FILE_NAME}.d"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}.d" -DOUTPUT_FORMAT="d" -DDEP_OUTPUT_FILE="${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}" -P "${CMAKE_CURRENT_SOURCE_DIR}/generateder.cmake" "${_GENERATEDER_SOURCE_FILE_PATH}"
        MAIN_DEPENDENCY ${_GENERATEDER_SOURCE_FILE_PATH}
        DEPENDS generateder.cmake
        USES_TERMINAL
    )
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}" -DOUTPUT_FORMAT="c" -P "${CMAKE_CURRENT_SOURCE_DIR}/generateder.cmake" "${_GENERATEDER_SOURCE_FILE_PATH}"
        MAIN_DEPENDENCY ${_GENERATEDER_SOURCE_FILE_PATH}
        DEPENDS generateder.cmake
        DEPFILE "common/der/${_GENERATEDER_SOURCE_FILE_NAME}.d"
        USES_TERMINAL
    )
    list(APPEND FILES_GENERATED "${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}")
endforeach()

foreach (_GENERATEDER_HEADER_FILE_PATH IN LISTS _GENERATEDER_HEADER_FILES_PATH)
    get_filename_component(_GENERATEDER_HEADER_FILE_NAME "${_GENERATEDER_HEADER_FILE_PATH}" NAME_WLE)
    add_custom_command(
        OUTPUT "include/prov/${_GENERATEDER_HEADER_FILE_NAME}.d"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/providers/include/prov/${_GENERATEDER_HEADER_FILE_NAME}.d" -DOUTPUT_FORMAT="d" -DDEP_OUTPUT_FILE="${CMAKE_BINARY_DIR}/providers/include/prov/${_GENERATEDER_HEADER_FILE_NAME}" -P "${CMAKE_CURRENT_SOURCE_DIR}/generateder.cmake" "${_GENERATEDER_HEADER_FILE_PATH}"
        MAIN_DEPENDENCY ${_GENERATEDER_HEADER_FILE_PATH}
        DEPENDS generateder.cmake
        USES_TERMINAL
    )
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}" -DOUTPUT_FORMAT="h" -P "${CMAKE_CURRENT_SOURCE_DIR}/generateder.cmake" "${_GENERATEDER_HEADER_FILE_PATH}"
        MAIN_DEPENDENCY ${_GENERATEDER_HEADER_FILE_PATH}
        DEPENDS generateder.cmake
        DEPFILE "include/prov/${_GENERATEDER_HEADER_FILE_NAME}.d"
        USES_TERMINAL
    )
    list(APPEND FILES_GENERATED "${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}")
endforeach()

add_custom_target(generate_der SOURCES
    ${FILES_GENERATED}
)

add_subdirectory(common)
add_subdirectory(default)
if (OPENSSL_FIPS)
    add_subdirectory(fips)
endif()
if (OPENSSL_LEGACY)
    # add_subdirectory(legacy)
endif()
