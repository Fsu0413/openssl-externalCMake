
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
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_ec_gen.c.in
    )
    set(_GENERATEDER_HEADER_FILES_PATH
        ${_GENERATEDER_HEADER_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_ec.h.in
    )
    if (OPENSSL_ECX)
        set(_GENERATEDER_SOURCE_FILES_PATH
            ${_GENERATEDER_SOURCE_FILES_PATH}
            ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_ecx_gen.c.in
        )
        set(_GENERATEDER_HEADER_FILES_PATH
            ${_GENERATEDER_HEADER_FILES_PATH}
            ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_ecx.h.in
        )
    endif()
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

if (OPENSSL_ML_DSA)
    set(_GENERATEDER_SOURCE_FILES_PATH
        ${_GENERATEDER_SOURCE_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_ml_dsa_gen.c.in
    )
    set(_GENERATEDER_HEADER_FILES_PATH
        ${_GENERATEDER_HEADER_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_ml_dsa.h.in
    )
endif()

if (OPENSSL_SLH_DSA)
    set(_GENERATEDER_SOURCE_FILES_PATH
        ${_GENERATEDER_SOURCE_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_slh_dsa_gen.c.in
    )
    set(_GENERATEDER_HEADER_FILES_PATH
        ${_GENERATEDER_HEADER_FILES_PATH}
        ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_slh_dsa.h.in
    )
endif()

# HKDF DER (used by ML-KEM hybrid)
set(_GENERATEDER_SOURCE_FILES_PATH
    ${_GENERATEDER_SOURCE_FILES_PATH}
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/der/der_hkdf_gen.c.in
)
set(_GENERATEDER_HEADER_FILES_PATH
    ${_GENERATEDER_HEADER_FILES_PATH}
    ${CMAKE_SOURCE_DIR}/openssl/providers/common/include/prov/der_hkdf.h.in
)

set(FILES_GENERATED)

foreach (_GENERATEDER_SOURCE_FILE_PATH IN LISTS _GENERATEDER_SOURCE_FILES_PATH)
    get_filename_component(_GENERATEDER_SOURCE_FILE_NAME "${_GENERATEDER_SOURCE_FILE_PATH}" NAME_WLE)
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}.d"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}.d" -DOUTPUT_FORMAT="d" -DDEP_OUTPUT_FILE="${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}" -P "${CMAKE_CURRENT_SOURCE_DIR}/generateder.cmake" "${_GENERATEDER_SOURCE_FILE_PATH}"
        MAIN_DEPENDENCY ${_GENERATEDER_SOURCE_FILE_PATH}
        DEPENDS generateder.cmake
        USES_TERMINAL
    )
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}" -DOUTPUT_FORMAT="c" -P "${CMAKE_CURRENT_SOURCE_DIR}/generateder.cmake" "${_GENERATEDER_SOURCE_FILE_PATH}"
        MAIN_DEPENDENCY ${_GENERATEDER_SOURCE_FILE_PATH}
        DEPENDS generateder.cmake "${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}.d"
        DEPFILE "${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}.d"
        USES_TERMINAL
    )
    list(APPEND FILES_GENERATED "${CMAKE_BINARY_DIR}/providers/common/der/${_GENERATEDER_SOURCE_FILE_NAME}")
endforeach()

foreach (_GENERATEDER_HEADER_FILE_PATH IN LISTS _GENERATEDER_HEADER_FILES_PATH)
    get_filename_component(_GENERATEDER_HEADER_FILE_NAME "${_GENERATEDER_HEADER_FILE_PATH}" NAME_WLE)
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}.d"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}.d" -DOUTPUT_FORMAT="d" -DDEP_OUTPUT_FILE="${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}" -P "${CMAKE_CURRENT_SOURCE_DIR}/generateder.cmake" "${_GENERATEDER_HEADER_FILE_PATH}"
        MAIN_DEPENDENCY ${_GENERATEDER_HEADER_FILE_PATH}
        DEPENDS generateder.cmake
        USES_TERMINAL
    )
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}"
        COMMAND ${CMAKE_COMMAND} -DOUTPUT_FILE_NAME="${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}" -DOUTPUT_FORMAT="h" -P "${CMAKE_CURRENT_SOURCE_DIR}/generateder.cmake" "${_GENERATEDER_HEADER_FILE_PATH}"
        MAIN_DEPENDENCY ${_GENERATEDER_HEADER_FILE_PATH}
        DEPENDS generateder.cmake "${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}.d"
        DEPFILE "${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}.d"
        USES_TERMINAL
    )
    list(APPEND FILES_GENERATED "${CMAKE_BINARY_DIR}/providers/common/include/prov/${_GENERATEDER_HEADER_FILE_NAME}")
endforeach()

add_custom_target(generate_der SOURCES
    ${FILES_GENERATED}
)


# Generate OpenSSL 4.x *.inc files from *.inc.in (param decoders)
set(_INC_IN_FILES)
file(GLOB_RECURSE _INC_IN_FILES CONFIGURE_DEPENDS
    "${CMAKE_SOURCE_DIR}/openssl/providers/**/*.inc.in"
)
set(_GENERATED_INC_FILES)
foreach (_INC_IN IN LISTS _INC_IN_FILES)
    file(RELATIVE_PATH _INC_REL "${CMAKE_SOURCE_DIR}/openssl" "${_INC_IN}")
    string(REGEX REPLACE "\\.in$" "" _INC_REL_OUT "${_INC_REL}")
    set(_INC_OUT "${CMAKE_BINARY_DIR}/${_INC_REL_OUT}")
    get_filename_component(_INC_OUT_DIR "${_INC_OUT}" DIRECTORY)
    add_custom_command(
        OUTPUT "${_INC_OUT}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${_INC_OUT_DIR}"
        COMMAND ${PERL_EXECUTABLE}
                "${CMAKE_SOURCE_DIR}/cmake/generate_inc.pl"
                "${CMAKE_SOURCE_DIR}/openssl"
                "${_INC_IN}"
                "${_INC_OUT}"
        MAIN_DEPENDENCY "${_INC_IN}"
        DEPENDS "${CMAKE_SOURCE_DIR}/cmake/generate_inc.pl"
                "${CMAKE_SOURCE_DIR}/openssl/util/perl/OpenSSL/paramnames.pm"
        COMMENT "Generating ${_INC_REL_OUT}"
        VERBATIM
    )
    list(APPEND _GENERATED_INC_FILES "${_INC_OUT}")
endforeach()
add_custom_target(generate_provider_inc DEPENDS ${_GENERATED_INC_FILES})
add_dependencies(generate_der generate_provider_inc)

add_subdirectory(common)
add_subdirectory(default)
if (OPENSSL_FIPS)
    add_subdirectory(fips)
endif()
if (OPENSSL_LEGACY)
    add_subdirectory(legacy)
endif()
