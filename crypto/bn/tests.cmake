# SPDX-License-Identifier: Unlicense

add_executable(bntest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/bntest.c)
target_link_libraries(bntest PUBLIC OpenSSLTest crypto)
add_dependencies(check bntest)

# we need to find bc for testing bntest
# GNU bc, Unix bc, yzena bc, busybox bc, toybox bc should all work since they implement same set of algorighms
# OpenSSL provides a utility script called "bctest". Simulate the process to find bc.
# there is a validator option of CMake >= 3.25 or later. Use it when possible, else we check it after find_program returns.

set(BC_VALIDATOR_3_25)

set(BC_NEED_PRINT_WRAPPER)
function(bc_validator)
    set(${ARGV0} false PARENT_SCOPE)
    execute_process(COMMAND ${ARGV1}
                    OUTPUT_VARIABLE SUNOS_BCBUG_CHECKER
                    INPUT_FILE ${CMAKE_SOURCE_DIR}/crypto/bn/sunos-bcbug.bc
                    OUTPUT_STRIP_TRAILING_WHITESPACE
                    RESULT_VARIABLE BCBUG_CHECKER_RESULT
    )
    if ( ( NOT BCBUG_CHECKER_RESULT EQUAL 0 ) OR ( NOT SUNOS_BCBUG_CHECKER STREQUAL "0" ) )
        return()
    endif()
    execute_process(COMMAND ${ARGV1}
                    OUTPUT_VARIABLE SCO_BCBUG_CHECKER
                    INPUT_FILE ${CMAKE_SOURCE_DIR}/crypto/bn/sco-bcbug.bc
                    OUTPUT_STRIP_TRAILING_WHITESPACE
                    RESULT_VARIABLE BCBUG_CHECKER_RESULT
    )
    if ( ( NOT BCBUG_CHECKER_RESULT EQUAL 0 ) OR ( NOT SCO_BCBUG_CHECKER STREQUAL "0\n0" ) )
        return()
    endif()
    set(${ARGV0} true PARENT_SCOPE)
    execute_process(COMMAND ${ARGV1}
                    OUTPUT_VARIABLE PRINT_CHECKER
                    INPUT_FILE ${CMAKE_SOURCE_DIR}/crypto/bn/print.bc
                    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (NOT PRINT_CHECKER STREQUAL "OK")
        set(BC_NEED_PRINT_WRAPPER true PARENT_SCOPE)
    else()
        set(BC_NEED_PRINT_WRAPPER false PARENT_SCOPE)
    endif()
endfunction()
if (CMAKE_VERSION VERSION_GREATER_EQUAL 3.25)
    set(BC_VALIDATOR_3_25 VALIDATOR bc_validator)
else()
    message(AUTHOR_WARNING "Using CMake version < 3.25 disables validation of bc utility. bc won't work if the first found one is buggy or incorrect.")
endif()

find_program(BC bc
             DOC "bc program, used for testing bntest"
             ${BC_VALIDATOR_3_25}
             CMAKE_FIND_ROOT_PATH_BOTH
)

# need to call bc_validator again to fill vairable BC_NEED_PRINT_WRAPPER since if variable bc is cached find_program will be no-op.
set(BC_VALIDATOR_PRE_3_25)
bc_validator(BC_VALIDATOR_PRE_3_25 "${BC}")
if (NOT BC_VALIDATOR_PRE_3_25)
    unset(BC CACHE)
endif()

# check if there is busybox and toybox. bc of them may also work
if (NOT DEFINED CACHE{BC})
    find_program(BUSYBOX busybox
                 DOC "busybox, extract bc from it"
                 CMAKE_FIND_ROOT_PATH_BOTH
    )
    if (BUSYBOX)
        execute_process(COMMAND ${BUSYBOX}
                        OUTPUT_VARIABLE BUSYBOX_CHECKER
        )
        if (BUSYBOX_CHECKER MATCHES "[ \t\r\n]bc[ \t\r\n]")
            set(BC_VALIDATOR_BUSYBOX)
            bc_validator(BC_VALIDATOR_BUSYBOX "${BUSYBOX} bc")
            if (BC_VALIDATOR_BUSYBOX)
                set(BC "${BUSYBOX} bc" CACHE STRING "bc program, used for testing bntest" FORCE)
            endif()
        endif()

        unset(BUSYBOX CACHE)
    endif()
endif()

if (NOT DEFINED CACHE{BC})
    find_program(TOYBOX toybox
                 DOC "toybox, extract bc from it"
                 CMAKE_FIND_ROOT_PATH_BOTH
    )
    if (TOYBOX)
        execute_process(COMMAND ${TOYBOX}
                        OUTPUT_VARIABLE TOYBOX_CHECKER
        )
        if (TOYBOX_CHECKER MATCHES "[ \t\r\n]bc[ \t\r\n]")
            set(BC_VALIDATOR_TOYBOX)
            bc_validator(BC_VALIDATOR_TOYBOX "${TOYBOX} bc")
            if (BC_VALIDATOR_TOYBOX)
                set(BC "${TOYBOX} bc" CACHE STRING "bc program, used for testing bntest" FORCE)
            endif()
        endif()

        unset(TOYBOX CACHE)
    endif()
endif()

if (DEFINED CACHE{BC})
    configure_file(${CMAKE_SOURCE_DIR}/crypto/bn/bntest.cmake.in bntest.cmake @ONLY)
    add_test(NAME bntest COMMAND ${CMAKE_COMMAND} -P bntest.cmake WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()

add_executable(exptest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/crypto/bn/exptest.c)
target_link_libraries(exptest PUBLIC OpenSSLTest crypto)
add_dependencies(check exptest)
add_test(NAME exptest COMMAND exptest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
