
# -DSOURCE_DIR = ${CMAKE_SOURCE_DIR}

set(START_ARGN)
foreach (I RANGE ${CMAKE_ARGC})
    if (CMAKE_ARGV${I} STREQUAL "-P")
        math(EXPR START_ARGN "${I} + 2")
        break()
    endif()
endforeach()

math(EXPR START_ARGN1 "${START_ARGN} + 1")
set(OUTPUT_FILE_NAME "${CMAKE_ARGV${START_ARGN1}}")

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

set(OUTPUT_CONTENTS)
foreach (I IN LISTS FILECONTENTSASCII)
    string(STRIP "${I}" INPUTLINE)
    set(OUTPUTLINE "${I}")

    string(SUBSTRING "${INPUTLINE}" 0 9 INPUTLINE9)
    if (INPUTLINE9 STREQUAL [[$output =]])
        string(CONCAT OUTPUTLINE "${INPUTLINE}" [[
$flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.| ? shift : undef;]])
    elseif (INPUTLINE9 STREQUAL [[open OUT,]])
        get_filename_component(OUTPUT_DIR "${OUTPUT_FILE_NAME}" DIRECTORY)
        file(RELATIVE_PATH OUTPUT_FILE_RELATIVE_TO_XLATE_PL "${OUTPUT_DIR}" "${SOURCE_DIR}/openssl/crypto/perlasm/x86_64-xlate.pl")
        string(CONCAT OUTPUTLINE [[open OUT,"| \"$^X\" \"${dir}]] "${OUTPUT_FILE_RELATIVE_TO_XLATE_PL}" [[\" $flavour \"$output\""]])
    endif()

    if (OUTPUTLINE STREQUAL I)
        # Here is the end of workaround - replace end-of-string CR back to backslash if the output is not modified.
        string(REGEX REPLACE "\r$" "\\\\" OUTPUTLINE_UNESCAPE_1 "${OUTPUTLINE}")
        set(OUTPUTLINE "${OUTPUTLINE_UNESCAPE_1}")
    endif()

    string(APPEND OUTPUT_CONTENTS "${OUTPUTLINE}" "\n")
endforeach()

string(REPLACE "\;" ";" OUTPUT_FILE_CONTENTS "${OUTPUT_CONTENTS}")
file(WRITE ${OUTPUT_FILE_NAME} "${OUTPUT_FILE_CONTENTS}")
