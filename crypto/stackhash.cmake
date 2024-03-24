# SPDX-License-Identifier: Unlicense

# read a file, generate stack hash macros, and output it
# This file uses CMake 3.13 grammar. Since my main CMake file requires CMake 3.22 this should not be a problem on my project.
# Will be tested on CMake 3.25 / 3.26.

# usage:
#   cmake -DOUTPUT_FILE_NAME=<output.h> -P stackhash.cmake <input.h.in>
# -DOUTPUT_FILE_NAME:string=<output.h> - the output file in absolute path

function(generate_stack_macros_int nametype realtype plaintype)
    set(MACROSRET "
SKM_DEFINE_STACK_OF_INTERNAL(${nametype}, ${realtype}, ${plaintype})
#define sk_${nametype}_num(sk) OPENSSL_sk_num(ossl_check_const_${nametype}_sk_type(sk))
#define sk_${nametype}_value(sk, idx) ((${realtype} *)OPENSSL_sk_value(ossl_check_const_${nametype}_sk_type(sk), (idx)))
#define sk_${nametype}_new(cmp) ((STACK_OF(${nametype}) *)OPENSSL_sk_new(ossl_check_${nametype}_compfunc_type(cmp)))
#define sk_${nametype}_new_null() ((STACK_OF(${nametype}) *)OPENSSL_sk_new_null())
#define sk_${nametype}_new_reserve(cmp, n) ((STACK_OF(${nametype}) *)OPENSSL_sk_new_reserve(ossl_check_${nametype}_compfunc_type(cmp), (n)))
#define sk_${nametype}_reserve(sk, n) OPENSSL_sk_reserve(ossl_check_${nametype}_sk_type(sk), (n))
#define sk_${nametype}_free(sk) OPENSSL_sk_free(ossl_check_${nametype}_sk_type(sk))
#define sk_${nametype}_zero(sk) OPENSSL_sk_zero(ossl_check_${nametype}_sk_type(sk))
#define sk_${nametype}_delete(sk, i) ((${realtype} *)OPENSSL_sk_delete(ossl_check_${nametype}_sk_type(sk), (i)))
#define sk_${nametype}_delete_ptr(sk, ptr) ((${realtype} *)OPENSSL_sk_delete_ptr(ossl_check_${nametype}_sk_type(sk), ossl_check_${nametype}_type(ptr)))
#define sk_${nametype}_push(sk, ptr) OPENSSL_sk_push(ossl_check_${nametype}_sk_type(sk), ossl_check_${nametype}_type(ptr))
#define sk_${nametype}_unshift(sk, ptr) OPENSSL_sk_unshift(ossl_check_${nametype}_sk_type(sk), ossl_check_${nametype}_type(ptr))
#define sk_${nametype}_pop(sk) ((${realtype} *)OPENSSL_sk_pop(ossl_check_${nametype}_sk_type(sk)))
#define sk_${nametype}_shift(sk) ((${realtype} *)OPENSSL_sk_shift(ossl_check_${nametype}_sk_type(sk)))
#define sk_${nametype}_pop_free(sk, freefunc) OPENSSL_sk_pop_free(ossl_check_${nametype}_sk_type(sk),ossl_check_${nametype}_freefunc_type(freefunc))
#define sk_${nametype}_insert(sk, ptr, idx) OPENSSL_sk_insert(ossl_check_${nametype}_sk_type(sk), ossl_check_${nametype}_type(ptr), (idx))
#define sk_${nametype}_set(sk, idx, ptr) ((${realtype} *)OPENSSL_sk_set(ossl_check_${nametype}_sk_type(sk), (idx), ossl_check_${nametype}_type(ptr)))
#define sk_${nametype}_find(sk, ptr) OPENSSL_sk_find(ossl_check_${nametype}_sk_type(sk), ossl_check_${nametype}_type(ptr))
#define sk_${nametype}_find_ex(sk, ptr) OPENSSL_sk_find_ex(ossl_check_${nametype}_sk_type(sk), ossl_check_${nametype}_type(ptr))
#define sk_${nametype}_find_all(sk, ptr, pnum) OPENSSL_sk_find_all(ossl_check_${nametype}_sk_type(sk), ossl_check_${nametype}_type(ptr), pnum)
#define sk_${nametype}_sort(sk) OPENSSL_sk_sort(ossl_check_${nametype}_sk_type(sk))
#define sk_${nametype}_is_sorted(sk) OPENSSL_sk_is_sorted(ossl_check_const_${nametype}_sk_type(sk))
#define sk_${nametype}_dup(sk) ((STACK_OF(${nametype}) *)OPENSSL_sk_dup(ossl_check_const_${nametype}_sk_type(sk)))
#define sk_${nametype}_deep_copy(sk, copyfunc, freefunc) ((STACK_OF(${nametype}) *)OPENSSL_sk_deep_copy(ossl_check_const_${nametype}_sk_type(sk), ossl_check_${nametype}_copyfunc_type(copyfunc), ossl_check_${nametype}_freefunc_type(freefunc)))
#define sk_${nametype}_set_cmp_func(sk, cmp) ((sk_${nametype}_compfunc)OPENSSL_sk_set_cmp_func(ossl_check_${nametype}_sk_type(sk), ossl_check_${nametype}_compfunc_type(cmp)))

" PARENT_SCOPE)
endfunction()

macro(generate_stack_macros type)
    generate_stack_macros_int("${type}" "${type}" "${type}")
endmacro()

macro(generate_const_stack_macros type)
    generate_stack_macros_int("${type}" "const ${type}" "${type}")
endmacro()

macro(generate_stack_string_macros)
    generate_stack_macros_int("OPENSSL_STRING" "char" "char")
endmacro()

macro(generate_stack_const_string_macros)
    generate_stack_macros_int("OPENSSL_CSTRING" "const char" "char")
endmacro()

macro(generate_stack_block_macros)
    generate_stack_macros_int("OPENSSL_BLOCK" "void" "void")
endmacro()

function(generate_lhash_macros type)
    set(MACROSRET "
DEFINE_LHASH_OF_INTERNAL(${type})\;
#define lh_${type}_new(hfn, cmp) ((LHASH_OF(${type}) *)OPENSSL_LH_set_thunks(OPENSSL_LH_new(ossl_check_${type}_lh_hashfunc_type(hfn), ossl_check_${type}_lh_compfunc_type(cmp)), lh_${type}_hash_thunk, lh_${type}_comp_thunk, lh_${type}_doall_thunk, lh_${type}_doall_arg_thunk))
#define lh_${type}_free(lh) OPENSSL_LH_free(ossl_check_${type}_lh_type(lh))
#define lh_${type}_flush(lh) OPENSSL_LH_flush(ossl_check_${type}_lh_type(lh))
#define lh_${type}_insert(lh, ptr) ((${type} *)OPENSSL_LH_insert(ossl_check_${type}_lh_type(lh), ossl_check_${type}_lh_plain_type(ptr)))
#define lh_${type}_delete(lh, ptr) ((${type} *)OPENSSL_LH_delete(ossl_check_${type}_lh_type(lh), ossl_check_const_${type}_lh_plain_type(ptr)))
#define lh_${type}_retrieve(lh, ptr) ((${type} *)OPENSSL_LH_retrieve(ossl_check_${type}_lh_type(lh), ossl_check_const_${type}_lh_plain_type(ptr)))
#define lh_${type}_error(lh) OPENSSL_LH_error(ossl_check_${type}_lh_type(lh))
#define lh_${type}_num_items(lh) OPENSSL_LH_num_items(ossl_check_${type}_lh_type(lh))
#define lh_${type}_node_stats_bio(lh, out) OPENSSL_LH_node_stats_bio(ossl_check_const_${type}_lh_type(lh), out)
#define lh_${type}_node_usage_stats_bio(lh, out) OPENSSL_LH_node_usage_stats_bio(ossl_check_const_${type}_lh_type(lh), out)
#define lh_${type}_stats_bio(lh, out) OPENSSL_LH_stats_bio(ossl_check_const_${type}_lh_type(lh), out)
#define lh_${type}_get_down_load(lh) OPENSSL_LH_get_down_load(ossl_check_${type}_lh_type(lh))
#define lh_${type}_set_down_load(lh, dl) OPENSSL_LH_set_down_load(ossl_check_${type}_lh_type(lh), dl)
#define lh_${type}_doall(lh, dfn) OPENSSL_LH_doall(ossl_check_${type}_lh_type(lh), ossl_check_${type}_lh_doallfunc_type(dfn))

" PARENT_SCOPE)
endfunction()

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
        else()
            set(MACROSRET)
            # We do a regex match / search in the code line.
            # There should only be 6 function calls.

            string(LENGTH "${INPUTLINE}" INPUTLINELEN)
            if (INPUTLINELEN EQUAL 0)
                # empty line
            elseif (INPUTLINE MATCHES "generate_stack_string_macros\\(\\)")
                generate_stack_string_macros()
            elseif (INPUTLINE MATCHES "generate_stack_const_string_macros\\(\\)")
                generate_stack_const_string_macros()
            elseif (INPUTLINE MATCHES "generate_stack_block_macros\\(\\)")
                generate_stack_block_macros()
            elseif (INPUTLINE MATCHES "generate_stack_macros\\((.+)\\)")
                kill_code_quote("${CMAKE_MATCH_1}" INPUTLINE_ARG)
                generate_stack_macros("${INPUTLINE_ARG}")
            elseif (INPUTLINE MATCHES "generate_const_stack_macros\\((.+)\\)")
                kill_code_quote("${CMAKE_MATCH_1}" INPUTLINE_ARG)
                generate_const_stack_macros("${INPUTLINE_ARG}")
            elseif (INPUTLINE MATCHES "generate_lhash_macros\\((.+)\\)")
                kill_code_quote("${CMAKE_MATCH_1}" INPUTLINE_ARG)
                generate_lhash_macros("${INPUTLINE_ARG}")
            elseif (INPUTLINE MATCHES "use OpenSSL::stackhash")
                # ignored
            else()
                # message(WARNING "unmatched line in Perl code part: \"${INPUTLINE}\". ignored.")
            endif()
            set(OUTPUTLINE "${MACROSRET}")
        endif()
    endif()

    if (OUTPUTLINE STREQUAL I)
        # Here is the end of workaround - replace end-of-string CR back to backslash if the output is not modified.
        string(REGEX REPLACE "\r$" "\\\\" OUTPUTLINE_UNESCAPE_1 "${OUTPUTLINE}")
        set(OUTPUTLINE "${OUTPUTLINE_UNESCAPE_1}")
    endif()

    string(APPEND OUTPUT_CONTENTS "${OUTPUTLINE}" "\n")
endforeach()

if (DEFINED OUTPUT_FILE_NAME)
    string(REPLACE "\;" ";" OUTPUT_FILE_CONTENTS "${OUTPUT_CONTENTS}")
    file(WRITE ${OUTPUT_FILE_NAME} "${OUTPUT_FILE_CONTENTS}")
else()
    message(NOTICE "${OUTPUT_CONTENTS}")
endif()
