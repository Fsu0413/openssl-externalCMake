
# Help:
# cmake
# -DNUMFILE=xxx.num
# -DLIBRARY_FILE=LIBEAY32 / SSLEAY32
# -DBINARY_DIR=<output-directory>
# -DOUTPUT_FILE=output.def
# -DPLATFORM=<platform> - currently only WIN32 is recognized, other possible value maybe "VMS" / "VOS" / "__FreeBSD__"...
# -P <this cmake>

# Depends on CMake 3.17 which is the version CMake supports load_cache in CMake -P mode

# There are duplicates in either the symbol name and the number so neither of them can be the key of our kv-pair
# So the key can be only line number
# Fortrunately there is no semicolon ";" in the .num file so we can use file(STRINGS) function!

cmake_policy(VERSION ${CMAKE_VERSION})

file(STRINGS "${NUMFILE}" NUMFILE_CONTENT)

# Read content from content to variables
set(I 0)
foreach(CONTENT_ITEM IN LISTS NUMFILE_CONTENT)
    if (CONTENT_ITEM MATCHES "^([A-Za-z_][A-Za-z0-9_]*)[ \t\r\n]+([1-9][0-9]*)[ \t\r\n]+(EXIST|NOEXIST):([^:]*):(FUNCTION|VARIABLE):([^:]*)$")
        # directly strip nonexist symbol!
        if (CMAKE_MATCH_3 STREQUAL "EXIST")
            set("CONTENT_ITEM_${I}_SYMBOL" "${CMAKE_MATCH_1}")
            set("CONTENT_ITEM_${I}_PLACE" "${CMAKE_MATCH_2}")
            set("CONTENT_ITEM_${I}_PLATFORM" "${CMAKE_MATCH_4}")
            # set("CONTENT_ITEM_${I}_TYPE" "${CMAKE_MATCH_5}") # Useless on Windows
            set("CONTENT_ITEM_${I}_CONDITION" "${CMAKE_MATCH_6}")

            math(EXPR I "${I} + 1")
        endif()
    endif()
endforeach()
set(CONTENT_LENGTH "${I}")

# Convert CONTENT_ITEM_${I}_PLATFORM and CONTENT_ITEM_${I}_CONDITION to list (by converting comma "," to semicolon ";"), and calculate their length
set(I 0)
while (I LESS CONTENT_LENGTH)
    string(REPLACE "," ";" CONTENT_ITEM_${I}_PLATFORM "${CONTENT_ITEM_${I}_PLATFORM}")
    list(LENGTH CONTENT_ITEM_${I}_PLATFORM CONTENT_ITEM_${I}_PLATFORM_LENGTH)
    string(REPLACE "," ";" CONTENT_ITEM_${I}_CONDITION "${CONTENT_ITEM_${I}_CONDITION}")
    list(LENGTH CONTENT_ITEM_${I}_CONDITION CONTENT_ITEM_${I}_CONDITION_LENGTH)
    math(EXPR I "${I} + 1")
endwhile()

# Merge all condition into one, then load the cached values
set(I 0)
# Some conditions act as platform options instead of a condition
set(ALL_CONDITIONS OPENSSL_ZLIB OPENSSL_FIPS)
while (I LESS CONTENT_LENGTH)
    foreach (C IN LISTS CONTENT_ITEM_${I}_CONDITION)
        list(APPEND ALL_CONDITIONS "OPENSSL_${C}")
    endforeach()
    math(EXPR I "${I} + 1")
endwhile()
list(REMOVE_DUPLICATES ALL_CONDITIONS)
load_cache("${BINARY_DIR}" READ_WITH_PREFIX "" ${ALL_CONDITIONS})

# Now that OPENSSL_* is available here!
if (PLATFORM STREQUAL "WIN32")
    set(OPENSSL_EXPORT_VAR_AS_FUNCTION 1)
endif()
if (OPENSSL_FIPS)
    set(OPENSSL_OPENSSL_FIPS 1)
endif()
set(OPENSSL_${PLATFORM} 1)

# Judge platform options and condition, set(CONTENT_ITEM_${I}_SUPPRESS 1) if not fit
set(I 0)
while (I LESS CONTENT_LENGTH)
    if (CONTENT_ITEM_${I}_PLATFORM_LENGTH GREATER 0)
        # P: platform option
        # RJ: judgement is reversed
        # PJ: word to be judged
        # PR: word matches
        foreach (P IN LISTS CONTENT_ITEM_${I}_PLATFORM)
            set(RJ no)
            string(SUBSTRING "${P}" 0 1 P1)
            set(PJ "${P}")
            if (P1 STREQUAL "!")
                string(SUBSTRING "${P}" 1 -1 PJ)
                set(RJ yes)
            endif()
            if (OPENSSL_${PJ})
                set(PR yes)
            else()
                set(PR no)
            endif()
            if (RJ STREQUAL PR)
                set(CONTENT_ITEM_${I}_SUPPRESS 1)
            endif()
            unset(RJ)
            unset(PR)
            unset(PJ)
            unset(P1)
        endforeach()
    endif()

    if (CONTENT_ITEM_${I}_CONDITION_LENGTH GREATER 0)
        foreach (C IN LISTS CONTENT_ITEM_${I}_CONDITION)
            if (NOT OPENSSL_${C})
                set(CONTENT_ITEM_${I}_SUPPRESS 1)
            endif()
        endforeach()
    endif()
    math(EXPR I "${I} + 1")
endwhile()

# Sort the needed symbols
# The needed symbols should be unique now!
set(I 0)
set(SYMBOLS)
while (I LESS CONTENT_LENGTH)
    if (NOT DEFINED CONTENT_ITEM_${I}_SUPPRESS)
        if (NOT "${CONTENT_ITEM_${I}_SYMBOL}" IN_LIST SYMBOLS)
            set("PLACE_FOR_${CONTENT_ITEM_${I}_SYMBOL}" "${CONTENT_ITEM_${I}_PLACE}")
            list(APPEND SYMBOLS "${CONTENT_ITEM_${I}_SYMBOL}")
        else()
            message(WARNING "Duplicated symbol: ${CONTENT_ITEM_${I}_SYMBOL}. The one with place ${CONTENT_ITEM_${I}_PLACE} is ignored.")
        endif()
    endif()
    math(EXPR I "${I} + 1")
endwhile()
list(SORT SYMBOLS)
# Make sure "SSLeay" is the first in symbol list
if ("SSLeay" IN_LIST SYMBOLS)
    list(REMOVE_ITEM SYMBOLS "SSLeay")
    list(PREPEND SYMBOLS "SSLeay")
endif()

# Finally generate the output file
# S: symbol
# SL: length of the symbol
# WL: length of the whitespaces
# W: whitespaces
set(EXPORT_TABLE)
foreach (S IN LISTS SYMBOLS)
    string(LENGTH "${S}" SL)
    math(EXPR WL "40 - ${SL}")
    if (WL LESS 1)
        set(WL 1)
    endif()
    string(REPEAT " " "${WL}" W)
    string(APPEND EXPORT_TABLE "    ${S}${W}@${PLACE_FOR_${S}}
")
    unset(SL)
    unset(WL)
    unset(W)
endforeach()

if (NOT DEFINED OUTPUT_FILE)
    message(NOTICE "${EXPORT_TABLE}")
else()
    file(WRITE "${OUTPUT_FILE}" "; Generated by mkdef.cmake
; Definition file for the DLL version of the ${LIBRARY_FILE} library from OpenSSL
;
LIBRARY         ${LIBRARY_FILE}

EXPORTS
${EXPORT_TABLE}

")
endif()
