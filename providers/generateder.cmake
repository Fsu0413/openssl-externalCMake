# SPDX-License-Identifier: Unlicense

# read a file, generate DER source files, and output it
# This file uses CMake 3.14 grammar. Since my main CMake file requires CMake 3.22 this should not be a problem on my project.
# Will be tested on CMake 3.25 / 3.26.

# usage:
#   cmake -DOUTPUT_FILE_NAME=<output.c> -DOUTPUT_FORMAT="c" -P generateder.cmake <input.c.in or input.h.in>
# -DOUTPUT_FILE_NAME:string=<output.h> - the output file in absolute path, if format is 'd' this is the '.d' file
# -DOUTPUT_FORMAT:string=c, h or d - the format
# -DDEP_OUTPUT_FILE:string=<output.h> - the dep target, if format is 'd' this is the expected OUTPUT_FILE_NAME

if (NOT DEFINED OUTPUT_FORMAT)
    message(FATAL_ERROR "please define OUTPUT_FORMAT")
elseif(OUTPUT_FORMAT STREQUAL "c")
elseif(OUTPUT_FORMAT STREQUAL "h")
elseif(OUTPUT_FORMAT STREQUAL "d")
else()
    message(FATAL_ERROR "please define OUTPUT_FORMAT to 'c', 'h' or 'd'.")
endif()

if (OUTPUT_FORMAT STREQUAL "d" AND NOT DEFINED DEP_OUTPUT_FILE)
    message(FATAL_ERROR "please specify DEP_OUTPUT_FILE for OUTPUT_FORMAT 'd'")
endif()

# The definition
set(GENERATEDER_LINEREGEX "([a-z][a-zA-Z0-9_-]*)[ \r\n\t]+OBJECT[ \r\n\t]+IDENTIFIER[ \r\n\t]*::=[ \r\n\t]*\\{([^\\}]+)\\}")

# known identifiers parsed so far
set(GENERATEDER_KNOWN_IDENTIFIER)

# string(REPLACE " " ";" ARGUMENTS_LIST "${ARGUMENTS}")
macro(register_identifier identifier arguments originalstring)
    string(MAKE_C_IDENTIFIER "${identifier}" IDENTIFIER_C)
    list(APPEND GENERATEDER_KNOWN_IDENTIFIER "${IDENTIFIER_C}")
    set("${IDENTIFIER_C}")

    # well-format the comments during parsing
    set(IDENTIFIER_C_COMMENTS "/*\n * ${identifier} OBJECT IDENTIFIER ::= {")

    # workaround id-dsa-with-sha1
    string(REPLACE " (" "(" ARGUMENTS_WITH_WORKAROUND "${arguments}") # ))

    # start
    string(REPLACE " " ";" ARGUMENTS_LIST "${ARGUMENTS_WITH_WORKAROUND}")
    foreach (J IN LISTS ARGUMENTS_LIST)
        string(STRIP "${J}" ARGUMENT_STRIPPED)
        string(LENGTH "${ARGUMENT_STRIPPED}" ARGUMENT_LENGTH)
        if (NOT ARGUMENT_LENGTH EQUAL 0)
            set(ARGUMENT "${ARGUMENT_STRIPPED}")
            string(APPEND IDENTIFIER_C_COMMENTS "\n *     ${ARGUMENT_STRIPPED}")
            # check if it is in form "xxx(123)" where only "123" is used as argument
            string(FIND "${ARGUMENT_STRIPPED}" "(" ARGUMENT_LEFT_BRACKET) # )
            if (NOT ARGUMENT_LEFT_BRACKET EQUAL -1)
                string(REGEX REPLACE "[^\\(]+\\(([0-9]+)\\)" "\\1" ARGUMENT "${ARGUMENT_STRIPPED}") # )
            endif()
            list(LENGTH "${IDENTIFIER_C}" IDENTIFIER_C_LENGTH)
            if (IDENTIFIER_C_LENGTH EQUAL 0)
                # the first argument may be a reference to previously defined identifier
                # directly replace the value of identifier as argument
                # the identifier must begins with a lowercase letter according to the above regex
                unset(ARGUMENT_IS_IDENTIFIER_MATCH)
                string(REGEX MATCH "^[a-z]" ARGUMENT_IS_IDENTIFIER_MATCH "${ARGUMENT}")
                # DO NOT USE "if (ARGUMENT_IS_IDENTIFIER_MATCH)" since it will be treated as false when ARGUMENT begins with the character "n"
                # AFFECTS nistAlgorithms (defined in NIST.asn1)
                string(LENGTH "${ARGUMENT_IS_IDENTIFIER_MATCH}" ARGUMENT_IS_IDENTIFIER)
                if (ARGUMENT_IS_IDENTIFIER) # or if (NOT ARGUMENT_IS_IDENTIFIER EQUAL 0) since it can only be 0 or 1
                    string(MAKE_C_IDENTIFIER "${ARGUMENT}" ARGUMENT_C_IDENTIFIER)
                    if (DEFINED ${ARGUMENT_C_IDENTIFIER})
                        set("${ARGUMENT_C_IDENTIFIER}_IS_ARC" true)
                        set(ARGUMENT "${${ARGUMENT_C_IDENTIFIER}}")
                    else()
                        message(FATAL_ERROR "Identifier ${ARGUMENT_C_IDENTIFIER} referenced by ${IDENTIFIER_C} is not defined.")
                    endif()
                endif()
            endif()
            # now the value is extracted as ARGUMENT. Push it into the variable.
            list(APPEND "${IDENTIFIER_C}" "${ARGUMENT}")
        endif()
    endforeach()

    string(APPEND IDENTIFIER_C_COMMENTS "\n * }\n */")
    set("${IDENTIFIER_C}_COMMENTS" "${IDENTIFIER_C_COMMENTS}")
endmacro()

function(calculate_byte_for_integer input_int output_list)
    if (input_int LESS 128)
        # 6 -> 0x6
        math(EXPR OUTPUT_INTERMEDIATE "${input_int}" OUTPUT_FORMAT HEXADECIMAL)
    else()
        # 113549 -> 887, 887 -> 6
        math(EXPR RECUR_INT "${input_int} >> 7")
        calculate_byte_for_integer("${RECUR_INT}" OUTPUT_INTERMEDIATE)

        # 0x6 -> 0x86, 0x77 -> 0xF7
        list(POP_BACK OUTPUT_INTERMEDIATE OUTPUT_INTERMEDIATE_LAST_ELEM)
        math(EXPR OUTPUT_INTERMEDIATE_LAST_ELEM_OR_80 "${OUTPUT_INTERMEDIATE_LAST_ELEM} | 0x80" OUTPUT_FORMAT HEXADECIMAL)
        list(APPEND OUTPUT_INTERMEDIATE "${OUTPUT_INTERMEDIATE_LAST_ELEM_OR_80}")

        # 0x1BB8D -> 0x0D, 0x377 -> 0x77
        math(EXPR INPUT_HEX "${input_int} & 0x7F" OUTPUT_FORMAT HEXADECIMAL)
        list(APPEND OUTPUT_INTERMEDIATE "${INPUT_HEX}")
    endif()
    set("${output_list}" "${OUTPUT_INTERMEDIATE}" PARENT_SCOPE)
endfunction()

function(generate_c_hdr C_name output_var)
    set(C_comment "${${C_name}_COMMENTS}")

    list(LENGTH "${C_name}" C_LENGTH)
    if (C_LENGTH LESS 3)
        message(FATAL_ERROR "???")
    endif()
    math(EXPR C_LENGTH_MINUS_1 "${C_LENGTH} - 1")

    # bytes[0] = id[0] * 40 + id[1]
    list(GET "${C_name}" 0 C_0)
    list(GET "${C_name}" 1 C_1)
    math(EXPR O_0 "${C_0} * 40 + ${C_1}" OUTPUT_FORMAT HEXADECIMAL)
    set(C_LIST "${O_0}")

    foreach (I RANGE 2 "${C_LENGTH_MINUS_1}")
        set(O_I)
        list(GET "${C_name}" "${I}" C_I)
        calculate_byte_for_integer("${C_I}" O_I)
        list(APPEND C_LIST "${O_I}")
    endforeach()

    list(LENGTH C_LIST oid_size)
    list(JOIN C_LIST ", " C_bytes)
    math(EXPR C_bytes_size "${oid_size} + 2")

    set(output "
${C_comment}
#define DER_OID_V_${C_name} DER_P_OBJECT, ${oid_size}, ${C_bytes}
#define DER_OID_SZ_${C_name} ${C_bytes_size}
extern const unsigned char ossl_der_oid_${C_name}[DER_OID_SZ_${C_name}];
")
    set("${output_var}" "${output}" PARENT_SCOPE)
endfunction()

function(generate_c_src C_name output_var)
    set(C_comment "${${C_name}_COMMENTS}")
    set(output "
${C_comment}
const unsigned char ossl_der_oid_${C_name}[DER_OID_SZ_${C_name}] = {
    DER_OID_V_${C_name}
};
")
    set("${output_var}" "${output}" PARENT_SCOPE)
endfunction()

macro(readasn1 _filename)
    # do not use file(STRINGS ... REGEX) since the regular expression should be matched cross lines
    file(READ "${_filename}" FILECONTENTS)
    string(REGEX MATCHALL "${GENERATEDER_LINEREGEX}" FILECONTENTS_MATCHED "${FILECONTENTS}")
    foreach (I IN LISTS FILECONTENTS_MATCHED)
        unset(MATCHONE)
        string(REGEX MATCH "${GENERATEDER_LINEREGEX}" MATCHONE "${I}")
        if (MATCHONE)
            register_identifier("${CMAKE_MATCH_1}" "${CMAKE_MATCH_2}" "${MATCHONE}")
        else()
            # What? It should be guaranteed to match!
            # it must be ending with "}" which is guaranteed not to match any of the false constant
            message(FATAL_ERROR "???")
        endif()
    endforeach()
endmacro()

set(START_ARGN)
foreach (I RANGE ${CMAKE_ARGC})
    if (CMAKE_ARGV${I} STREQUAL "-P")
        math(EXPR START_ARGN "${I} + 2")
        break()
    endif()
endforeach()

# This is my original thought
# file(STRINGS ${CMAKE_ARGV${START_ARGN}} FILECONTENTS)
# but it fails to parse the file with backslash appears just before end-of-line, it removes the end-of-line completely

# start of a HUGE workaround about CMake `file(STRINGS)` kills backslash before end-of-line with end-of-line
# the backslash - end-of-line combination is what we should preserve!

# warning: following workaround does not support CR-only EOL.

# Read the whole file as hexadecimal
file(READ ${CMAKE_ARGV${START_ARGN}} FILECONTENTSHEX HEX)

# Searching for "\n" (0x0a) byte by byte for line breaks
#
# I didn't found a string split function in current CMake so implement following on our own.
#
# Normally one byte is two hexadecimal number, so the place of "0a" should always be an even number.
# Place of "0a" being an even number is guaranteed for pure-ASCII since ASCII only use 01~7f where the higher bit is always less than 8. Nothing like "b0a1" exists.
# This case is the lucky case.
#
# But things will go wrong if multibyte character is playing a part, resulting something like "b0a1" exists in the HEX, causing the result is an odd number.
# This is the unlucky case where we must find the next "0a" starts on end of this "0a" and is an odd number, and concatenate the strings altogether for this line.
# Temporarily treat this as an error (implemention is complex). It seems like no multibyte character is in the header file of OpenSSL.
#
# Also we remove trailing CR since some OSes (especially Windows) use CRLF EOL for text files
# This is necessary since trailing CR will be used as escape character in logic below this part

set(FILECONTENTS)
set(FILEFOUND)
string(FIND ${FILECONTENTSHEX} "0a" FILEFOUND)
while (NOT FILEFOUND EQUAL -1)
    set(SINGLELINE)
    math(EXPR FILEFOUNDMOD2 "${FILEFOUND} % 2")
    if (FILEFOUNDMOD2 EQUAL 0)
        # the lucky case
        # kill "\r"
        set(SUBSTRINGEND "${FILEFOUND}")
        if (NOT FILEFOUND EQUAL 0)
            math(EXPR FILEFOUNDMINUS2 "${FILEFOUND} - 2")
            string(SUBSTRING "${FILECONTENTSHEX}" "${FILEFOUNDMINUS2}" 2 SINGLELINELAST2)
            if (SINGLELINELAST2 STREQUAL "0d")
                set(SUBSTRINGEND "${FILEFOUNDMINUS2}")
            endif()
        endif()
        string(SUBSTRING "${FILECONTENTSHEX}" 0 "${SUBSTRINGEND}" SINGLELINE)
        list(APPEND FILECONTENTS "${SINGLELINE}")
        math(EXPR FILEFOUNDPLUS2 "${FILEFOUND} + 2")
        string(SUBSTRING "${FILECONTENTSHEX}" "${FILEFOUNDPLUS2}" -1 REMAINDER)
        set(FILECONTENTSHEX "${REMAINDER}")
    else()
        # TODO: the unlucky case
        message(FATAL_ERROR "not implemented for now")
    endif()
    string(FIND "${FILECONTENTSHEX}" "0a" FILEFOUND)
endwhile()
# also deal with file without EOL on EOF
string(LENGTH "${FILECONTENTSHEX}" FILEFOUND)
if (NOT FILEFOUND EQUAL 0)
    set(SUBSTRINGEND "${FILEFOUND}")
    math(EXPR FILEFOUNDMINUS2 "${FILEFOUND} - 2")
    string(SUBSTRING "${FILECONTENTSHEX}" "${FILEFOUNDMINUS2}" 2 SINGLELINELAST2)
    if (SINGLELINELAST2 STREQUAL "0d")
        set(SUBSTRINGEND "${FILEFOUNDMINUS2}")
    endif()
    string(SUBSTRING "${FILECONTENTSHEX}" 0 "${SUBSTRINGEND}" SINGLELINE)
    list(APPEND FILECONTENTS "${SINGLELINE}")
endif()

# Convert back hexadecimal ASCII to original string, but...
# string(ASCII) receives decimal parameter. If the number is not converted the result is a wrong.
# e.g. "e" becomes "A" without conversion. ASCII of "e" is 65 in hexadecimal, which is "A" in decimal
#
# After the string is converted to original string we can list them up, but...
# The original header file may contain backslash before any arbitrary end-of-line, where the backslash is placed in end-of-string by above logic.
# list(JOIN) joins the end-of-string backslash and CMake list separator ";" WHICH MAKES THE LIST SEPARATOR ESCAPED!!!
# To workaround this, we should escape the end-of-string backslash. Since we removed end-of-string CR in above logic we can use CR as escape character for end-of-string backslash.

set(FILECONTENTSASCII)
foreach (I IN LISTS FILECONTENTS)
    set(I_SPLITTED)
    # Convert the hexadecimal I to decimal and make a list for it, to satisfy string(ASCII)
    string(LENGTH "${I}" I_LENGTH)
    set(I_SUBSTRING_REMAINDER "${I}")
    while(NOT I_LENGTH EQUAL 0)
        string(SUBSTRING "${I_SUBSTRING_REMAINDER}" 0 2 I_SUBSTRING_2)
        math(EXPR I_SUBSTRING_2_DEC "0x${I_SUBSTRING_2}" OUTPUT_FORMAT DECIMAL)
        list(APPEND I_SPLITTED "${I_SUBSTRING_2_DEC}")
        string(SUBSTRING "${I_SUBSTRING_REMAINDER}" 2 -1 I_SUBSTRING_REMAINDER_2)
        set(I_SUBSTRING_REMAINDER "${I_SUBSTRING_REMAINDER_2}")
        string(LENGTH "${I_SUBSTRING_REMAINDER}" I_LENGTH)
    endwhile()
    set(I_ASCII)
    list(LENGTH I_SPLITTED I_SPLITTED_LEN)
    if (NOT I_SPLITTED_LEN EQUAL 0)
        string(ASCII ${I_SPLITTED} I_ASCII)
    endif()
    # escape end-of-string backslash by replacing it with CR. End-of-string backslash will escape the CMake list separator when used alongwith list(APPEND)
    string(REGEX REPLACE "\\\\$" "\r" I_ASCII_ESCAPED_1 "${I_ASCII}")
    # escape ";", satisify CMake list
    string(REPLACE ";" "\;" I_ASCII_ESCAPED_2 "${I_ASCII_ESCAPED_1}")
    list(APPEND FILECONTENTSASCII "${I_ASCII_ESCAPED_2}")
endforeach()

# Here is the middle of the workaround - the file is loaded as FILECONTENTSASCII with end-of-string backslash replaced by CR

function(kill_code_quote inputstr outvar)
    set(result "${inputstr}")
    string(LENGTH "${inputstr}" inputlen)
    if (inputlen LESS 2)
        message(FATAL_ERROR "Length of ${inputstr} is less than 2")
    endif()
    math(EXPR inputlenminus1 "${inputlen} - 1")
    math(EXPR inputlenminus2 "${inputlen} - 2")
    string(SUBSTRING "${inputstr}" 0 1 inputstrhead)
    string(SUBSTRING "${inputstr}" ${inputlenminus1} 1 inputstrtail)
    if (inputstrhead STREQUAL "\"" AND inputstrtail STREQUAL "\"")
        string(SUBSTRING "${inputstr}" 1 ${inputlenminus2} result)
    endif()
    set(${outvar} "${result}" PARENT_SCOPE)
endfunction()

set(OUTPUT_CONTENTS)

if (OUTPUT_FORMAT STREQUAL "d")
    set(OUTPUT_DEPENDENCIES)
endif()

set(FUNCPROCESSING false)
foreach (I IN LISTS FILECONTENTSASCII)
    string(STRIP "${I}" INPUTLINE)
    set(OUTPUTLINE)
    if (NOT FUNCPROCESSING)
        if (INPUTLINE STREQUAL "{-")
            set(FUNCPROCESSING true)
        else()
            set(OUTPUTLINE "${I}")
        endif()
    else()
        if (INPUTLINE STREQUAL "-}")
            set(FUNCPROCESSING false)
            foreach (K IN LISTS GENERATEDER_KNOWN_IDENTIFIER)
                if ( NOT ( DEFINED ${K}_IS_ARC AND ${K}_IS_ARC ) )
                    if (OUTPUT_FORMAT STREQUAL "c")
                        generate_c_src(${K} OUTPUTITEM)
                    elseif (OUTPUT_FORMAT STREQUAL "h")
                        generate_c_hdr(${K} OUTPUTITEM)
                    endif()
                    string(APPEND OUTPUTLINE "${OUTPUTITEM}")
                endif()
                unset(${K})
                unset(${K}_IS_ARC)
            endforeach()
            set(GENERATEDER_KNOWN_IDENTIFIER)
        else()
            # We do a regex match / search in the code line.
            # There should only be 6 function calls.
            string(LENGTH "${INPUTLINE}" INPUTLINELEN)
            if (INPUTLINELEN EQUAL 0)
                # empty line
            elseif (INPUTLINE MATCHES "'([^']+)'")
                if (NOT OUTPUT_FORMAT STREQUAL "d")
                    readasn1("${CMAKE_CURRENT_LIST_DIR}/../openssl/${CMAKE_MATCH_1}")
                else()
                    get_filename_component(FILEREALPATH "${CMAKE_CURRENT_LIST_DIR}/../openssl/${CMAKE_MATCH_1}" REALPATH)
                    list(APPEND OUTPUT_DEPENDENCIES "${FILEREALPATH}")
                endif()
            else()
                # message(WARNING "unmatched line in Perl code part: \"${INPUTLINE}\". ignored.")
            endif()
        endif()
    endif()

    if (OUTPUTLINE STREQUAL I)
        # Here is the end of workaround - replace end-of-string CR back to backslash if the output is not modified.
        string(REGEX REPLACE "\r$" "\\\\" OUTPUTLINE_UNESCAPE_1 "${OUTPUTLINE}")
        set(OUTPUTLINE "${OUTPUTLINE_UNESCAPE_1}")
    endif()

    if (NOT OUTPUT_FORMAT STREQUAL "d")
        string(APPEND OUTPUT_CONTENTS "${OUTPUTLINE}" "\n")
    endif()
endforeach()

if (OUTPUT_FORMAT STREQUAL "d")
    list(JOIN OUTPUT_DEPENDENCIES " " OUTPUT_DEPENDENCIES_JOIN)
    set(OUTPUT_CONTENTS "${DEP_OUTPUT_FILE} : ${OUTPUT_DEPENDENCIES_JOIN}")
endif()

if (DEFINED OUTPUT_FILE_NAME)
    string(REPLACE "\;" ";" OUTPUT_FILE_CONTENTS "${OUTPUT_CONTENTS}")
    file(WRITE ${OUTPUT_FILE_NAME} "${OUTPUT_FILE_CONTENTS}")
else()
    message(NOTICE "${OUTPUT_CONTENTS}")
endif()
