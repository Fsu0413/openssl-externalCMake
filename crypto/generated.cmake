# SPDX-License-Identifier: Unlicense

# OpenSSL 4.1 no longer ships the error tables, the object tables and a few
# lookup tables pre-generated; they are produced at build time.
# Every output keeps its path relative to the OpenSSL source tree, below
# ${CMAKE_BINARY_DIR}.  Outputs are collected in OPENSSL_GENERATED_SOURCES.

set(OPENSSL_GENERATED_SOURCES)

# Error headers and sources: the L lines of crypto/err/openssl.ec name the
# files util/mkerr.pl emits for each error library (NONE: nothing to emit).
file(STRINGS "${CMAKE_SOURCE_DIR}/openssl/crypto/err/openssl.ec" _ERR_LIB_LINES REGEX "^L[ \t]")
set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/openssl/crypto/err/openssl.ec")
foreach (_ERR_LIB_LINE IN LISTS _ERR_LIB_LINES)
    string(REGEX REPLACE "[ \t]+" ";" _ERR_LIB_FIELDS "${_ERR_LIB_LINE}")
    list(SUBLIST _ERR_LIB_FIELDS 2 -1 _ERR_FILES)
    foreach (_ERR_FILE IN LISTS _ERR_FILES)
        if (_ERR_FILE STREQUAL "NONE" OR _ERR_FILE STREQUAL "")
            continue()
        endif()
        add_custom_command(
            OUTPUT "${CMAKE_BINARY_DIR}/${_ERR_FILE}"
            COMMAND ${PERL_EXECUTABLE} "${CMAKE_SOURCE_DIR}/cmake/mkerr_emit.pl"
                    "${CMAKE_SOURCE_DIR}/openssl" "${_ERR_FILE}" "${CMAKE_BINARY_DIR}/${_ERR_FILE}"
            DEPENDS "${CMAKE_SOURCE_DIR}/cmake/mkerr_emit.pl"
                    "${CMAKE_SOURCE_DIR}/openssl/util/mkerr.pl"
                    "${CMAKE_SOURCE_DIR}/openssl/crypto/err/openssl.ec"
                    "${CMAKE_SOURCE_DIR}/openssl/crypto/err/openssl.txt"
            COMMENT "Generating ${_ERR_FILE}"
            VERBATIM
        )
        list(APPEND OPENSSL_GENERATED_SOURCES "${CMAKE_BINARY_DIR}/${_ERR_FILE}")
    endforeach()
endforeach()
unset(_ERR_FILE)
unset(_ERR_FILES)
unset(_ERR_LIB_FIELDS)
unset(_ERR_LIB_LINE)
unset(_ERR_LIB_LINES)

# Usage:
# openssl_generate_from_perl(<output relative to the source tree> <script relative to the source tree>
#                            [ARGS <arg1> ...] [DEPENDS <depend1> ...]
# )
# Runs the script from the OpenSSL source tree and captures its standard output.
function (openssl_generate_from_perl OUT_FILE SCRIPT)
    cmake_parse_arguments(PARSE_ARGV 2 _GEN "" "" "ARGS;DEPENDS")
    get_filename_component(_OUT_DIR "${CMAKE_BINARY_DIR}/${OUT_FILE}" DIRECTORY)
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/${OUT_FILE}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${_OUT_DIR}"
        COMMAND ${PERL_EXECUTABLE} "${CMAKE_SOURCE_DIR}/openssl/util/file-from-stdout.pl" "${CMAKE_BINARY_DIR}/${OUT_FILE}"
                ${PERL_EXECUTABLE} "${CMAKE_SOURCE_DIR}/openssl/${SCRIPT}" ${_GEN_ARGS}
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/openssl"
        DEPENDS "${CMAKE_SOURCE_DIR}/openssl/${SCRIPT}" "${CMAKE_SOURCE_DIR}/openssl/util/file-from-stdout.pl" ${_GEN_DEPENDS}
        COMMENT "Generating ${OUT_FILE}"
        VERBATIM
    )
    set(OPENSSL_GENERATED_SOURCES ${OPENSSL_GENERATED_SOURCES} "${CMAKE_BINARY_DIR}/${OUT_FILE}" PARENT_SCOPE)
endfunction()

openssl_generate_from_perl(include/openssl/obj_mac.h crypto/objects/objects.pl
    ARGS -a "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_compat.h"
         "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/objects.txt"
         "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_mac.num"
    DEPENDS "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_compat.h"
            "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/objects.txt"
            "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_mac.num"
)
openssl_generate_from_perl(crypto/objects/obj_dat.h crypto/objects/obj_dat.pl
    ARGS "${CMAKE_BINARY_DIR}/include/openssl/obj_mac.h"
    DEPENDS "${CMAKE_BINARY_DIR}/include/openssl/obj_mac.h"
)
openssl_generate_from_perl(crypto/objects/obj_xref.h crypto/objects/objxref.pl
    ARGS "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_mac.num"
         "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_xref.txt"
    DEPENDS "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_mac.num"
            "${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_xref.txt"
)
openssl_generate_from_perl(crypto/asn1/charmap.h crypto/asn1/charmap.pl)
openssl_generate_from_perl(crypto/conf/conf_def.h crypto/conf/keysets.pl)
openssl_generate_from_perl(crypto/bn/bn_prime.h crypto/bn/bn_prime.pl)

# Parameter decoders outside providers/ (providers/**/*.inc.in are handled in providers/CMakeLists.txt)
foreach (_PARAMS_HEADER IN ITEMS include/crypto/ec_params.h include/crypto/rsa_params.h)
    add_custom_command(
        OUTPUT "${CMAKE_BINARY_DIR}/${_PARAMS_HEADER}"
        COMMAND ${PERL_EXECUTABLE} "${CMAKE_SOURCE_DIR}/cmake/generate_inc.pl"
                "${CMAKE_SOURCE_DIR}/openssl"
                "${CMAKE_SOURCE_DIR}/openssl/${_PARAMS_HEADER}.in"
                "${CMAKE_BINARY_DIR}/${_PARAMS_HEADER}"
        MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/${_PARAMS_HEADER}.in"
        DEPENDS "${CMAKE_SOURCE_DIR}/cmake/generate_inc.pl"
                "${CMAKE_SOURCE_DIR}/openssl/util/perl/OpenSSL/paramnames.pm"
        COMMENT "Generating ${_PARAMS_HEADER}"
        VERBATIM
    )
    list(APPEND OPENSSL_GENERATED_SOURCES "${CMAKE_BINARY_DIR}/${_PARAMS_HEADER}")
endforeach()
unset(_PARAMS_HEADER)
