
# Help:
# cmake
# -DNUMFILE=xxx.num
# -DLIBRARY_FILE=LIBEAY32 / SSLEAY32
# -DBINARY_DIR=<output-directory>
# -DOUTPUT_FILE=output.def
# -DPLATFORM=<platform> - currently only "_WIN32" and "ELF" are recognized, other possible value maybe "VMS" / "VOS" / "__FreeBSD__"...
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
    if (CONTENT_ITEM MATCHES "^([A-Za-z_][A-Za-z0-9_]*)[ \t\r\n]+([1-9][0-9]*|\\?)[ \t\r\n]+(\\*|[0-9]+_[0-9]+_[0-9]+[a-z]*)[ \t\r\n]+(EXIST|NOEXIST):([^:]*):(FUNCTION|VARIABLE):([^:]*)$")
        # directly strip nonexist symbol!
        if (CMAKE_MATCH_4 STREQUAL "EXIST")
            set("CONTENT_ITEM_${I}_SYMBOL" "${CMAKE_MATCH_1}")
            set("CONTENT_ITEM_${I}_PLACE" "${CMAKE_MATCH_2}")
            set("CONTENT_ITEM_${I}_VERSION" "${CMAKE_MATCH_3}")
            set("CONTENT_ITEM_${I}_PLATFORM" "${CMAKE_MATCH_5}")
            # set("CONTENT_ITEM_${I}_TYPE" "${CMAKE_MATCH_6}") # Useless on Windows
            set("CONTENT_ITEM_${I}_CONDITION" "${CMAKE_MATCH_7}")

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
set(ALL_CONDITIONS OPENSSL_MIN_API_LEVEL)
while (I LESS CONTENT_LENGTH)
    foreach (C IN LISTS CONTENT_ITEM_${I}_CONDITION)
        list(APPEND ALL_CONDITIONS "OPENSSL_${C}")
    endforeach()
    math(EXPR I "${I} + 1")
endwhile()
list(REMOVE_DUPLICATES ALL_CONDITIONS)
load_cache("${BINARY_DIR}" READ_WITH_PREFIX "" ${ALL_CONDITIONS})

# Now that OPENSSL_* is available here!
set(OPENSSL_${PLATFORM} 1)
set(OPENSSL_DEPRECATEDIN_3_1 1)
set(OPENSSL_DEPRECATEDIN_3_0 1)
set(OPENSSL_DEPRECATEDIN_1_1_0 1)
set(OPENSSL_DEPRECATEDIN_1_0_0 1)
set(OPENSSL_DEPRECATEDIN_0_9_8 1)
if (DEFINED OPENSSL_MIN_API_LEVEL)
    if (OPENSSL_MIN_API_LEVEL STREQUAL "3.2")
        set(OPENSSL_MIN_API_LEVEL "3.1")
    endif()
    if (OPENSSL_MIN_API_LEVEL STREQUAL "3.1")
        unset(OPENSSL_DEPRECATEDIN_3_1)
        set(OPENSSL_MIN_API_LEVEL "3.0")
    endif()
    if (OPENSSL_MIN_API_LEVEL STREQUAL "3.0")
        unset(OPENSSL_DEPRECATEDIN_3_0)
        set(OPENSSL_MIN_API_LEVEL "1.1.0")
    endif()
    if (OPENSSL_MIN_API_LEVEL STREQUAL "1.1.1")
        set(OPENSSL_MIN_API_LEVEL "1.1.0")
    endif()
    if (OPENSSL_MIN_API_LEVEL STREQUAL "1.1.0")
        unset(OPENSSL_DEPRECATEDIN_1_1_0)
        set(OPENSSL_MIN_API_LEVEL "1.0.0")
    endif()
    if (OPENSSL_MIN_API_LEVEL STREQUAL "1.0.2")
        set(OPENSSL_MIN_API_LEVEL "1.0.0")
    endif()
    if (OPENSSL_MIN_API_LEVEL STREQUAL "1.0.1")
        set(OPENSSL_MIN_API_LEVEL "1.0.0")
    endif()
    if (OPENSSL_MIN_API_LEVEL STREQUAL "1.0.0")
        unset(OPENSSL_DEPRECATEDIN_1_0_0)
        set(OPENSSL_MIN_API_LEVEL "0.9.8")
    endif()
    if (OPENSSL_MIN_API_LEVEL STREQUAL "0.9.8")
        unset(OPENSSL_DEPRECATEDIN_0_9_8)
    endif()
endif()

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
set(VERSIONS)
while (I LESS CONTENT_LENGTH)
    if (NOT DEFINED CONTENT_ITEM_${I}_SUPPRESS)
        if (NOT "${CONTENT_ITEM_${I}_SYMBOL}" IN_LIST SYMBOLS)
            set("PLACE_FOR_${CONTENT_ITEM_${I}_SYMBOL}" "${CONTENT_ITEM_${I}_PLACE}")
            set("VERSION_FOR_${CONTENT_ITEM_${I}_SYMBOL}" "${CONTENT_ITEM_${I}_VERSION}")
            list(APPEND SYMBOLS "${CONTENT_ITEM_${I}_SYMBOL}")
            list(APPEND VERSIONS "${CONTENT_ITEM_${I}_VERSION}")
        else()
            message(WARNING "Duplicated symbol: ${CONTENT_ITEM_${I}_SYMBOL}. The one with place ${CONTENT_ITEM_${I}_PLACE} is ignored.")
        endif()
    endif()
    math(EXPR I "${I} + 1")
endwhile()
list(SORT SYMBOLS)
list(SORT VERSIONS)
list(REMOVE_DUPLICATES VERSIONS)

# Finally generate the output file
if (PLATFORM STREQUAL "_WIN32")
    set(EXPORT_TABLE)
    foreach (S IN LISTS SYMBOLS)
        string(APPEND EXPORT_TABLE "    ${S}
")
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
elseif (PLATFORM STREQUAL "ELF")
    set(EXPORT_TABLE)
    list(LENGTH VERSIONS VERSIONS_LENGTH)
    math(EXPR VERSION_LENGTH1 "${VERSIONS_LENGTH} - 1")
    set(I 0)
    while (I LESS VERSIONS_LENGTH)
        list(GET VERSIONS "${I}" VERSION_C)
        if (NOT VERSION_C STREQUAL "*")
            string(APPEND EXPORT_TABLE "OPENSSL_${VERSION_C} ")
        endif()
        string(APPEND EXPORT_TABLE "{
    global:
")
        foreach (S IN LISTS SYMBOLS)
            if (VERSION_FOR_${S} STREQUAL VERSION_C)
                string(APPEND EXPORT_TABLE "        ${S};
")
            endif()
        endforeach()

        if (I EQUAL VERSION_LENGTH1)
            string(APPEND EXPORT_TABLE "    local: *;
")
        endif()

        string(APPEND EXPORT_TABLE "}")

        if (I GREATER 0)
            math(EXPR I1 "${I} - 1")
            list(GET VERSIONS "${I1}" VERSION_C1)
            string(APPEND EXPORT_TABLE " OPENSSL_${VERSION_C1}")
        endif()

        string(APPEND EXPORT_TABLE ";

")

        math(EXPR I "${I} + 1")
    endwhile()

    if (NOT DEFINED OUTPUT_FILE)
        message(NOTICE "${EXPORT_TABLE}")
    else()
        file(WRITE "${OUTPUT_FILE}" "${EXPORT_TABLE}")
    endif()
endif()
