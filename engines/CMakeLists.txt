# SPDX-License-Identifier: Unlicense

if (OPENSSL_HW AND OPENSSL_ENGINE AND BUILD_SHARED_LIBS AND OPENSSL_DYNAMIC_ENGINE)
    # workaround, there is no OPENSSL_HW_OSSLTEST / OPENSSL_HW_DASYNC but they should be always built
    # DO NOT SET THEM AS CACHE!
    set(OPENSSL_OSSLTESTENG ON)
    # set(OPENSSL_DASYNCENG ON) # build failed currently
    foreach (_OPTION IN ITEMS padlock capi afalg devcrypto loader ossltest dasync)
        set(_ENGINE ${_OPTION})
        if (_OPTION STREQUAL "loader")
            set(_ENGINE "loader_attic")
        endif()
        string(TOUPPER ${_OPTION} _OPTION_UPPER)
        string(REPLACE "-" "_" _OPTION_SYMBOL ${_OPTION_UPPER})
        if (OPENSSL_${_OPTION_SYMBOL}ENG)
            set(ENGINE_SOURCES)
            include(${_OPTION}.cmake)
            if (WIN32)
                add_custom_command(
                    OUTPUT ${_ENGINE}.def
                    COMMAND "${CMAKE_COMMAND}" -DNUMFILE="${CMAKE_SOURCE_DIR}/openssl/util/engines.num" -DLIBRARY_FILE="${_ENGINE}" -DBINARY_DIR="${CMAKE_BINARY_DIR}" -DOUTPUT_FILE="${CMAKE_CURRENT_BINARY_DIR}/${_ENGINE}.def" -DPLATFORM=_WIN32 -P "${CMAKE_CURRENT_SOURCE_DIR}/../crypto/mkdef.cmake"
                    MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/util/engines.num"
                    DEPENDS ../crypto/mkdef.cmake
                )
                set(ENGINE_SOURCES ${ENGINE_SOURCES} ${_ENGINE}.def)
            endif()

            add_library(${_ENGINE} MODULE
                ${ENGINE_SOURCES}
            )
            target_link_libraries(${_ENGINE}
                PUBLIC crypto
            )
            if ( NOT WIN32 AND ( CMAKE_C_COMPILER_ID MATCHES "GNU" OR CMAKE_C_COMPILER_ID MATCHES "[Cc]lang" ) AND NOT APPLE AND NOT ( CMAKE_SYSTEM_NAME MATCHES "SunOS") )
                add_custom_command(
                    OUTPUT ${_ENGINE}.ld
                    COMMAND "${CMAKE_COMMAND}" -DNUMFILE="${CMAKE_SOURCE_DIR}/openssl/util/engines.num" -DLIBRARY_FILE="${_ENGINE}" -DBINARY_DIR="${CMAKE_BINARY_DIR}" -DOUTPUT_FILE="${CMAKE_CURRENT_BINARY_DIR}/${_ENGINE}.ld" -DPLATFORM=ELF -P "${CMAKE_CURRENT_SOURCE_DIR}/../crypto/mkdef.cmake"
                    MAIN_DEPENDENCY "${CMAKE_SOURCE_DIR}/openssl/util/engines.num"
                    DEPENDS ../crypto/mkdef.cmake
                )
                add_custom_target(${_ENGINE}_map SOURCES ${_ENGINE}.ld)
                add_dependencies(${_ENGINE} ${_ENGINE}_map)
                target_link_options(${_ENGINE} PRIVATE "LINKER:--version-script=${CMAKE_CURRENT_BINARY_DIR}/${_ENGINE}.ld")
            endif()
            if (_OPTION STREQUAL "loader")
                target_compile_definitions(${_ENGINE} PRIVATE OPENSSL_NO_PROVIDER_CODE)
            endif()
            if (DEFINED CACHE{OPENSSL_${_OPTION_SYMBOL}ENG})
                install(TARGETS ${_ENGINE}
                    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}/engines-3
                    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/engines-3
                )
            endif()
            unset(ENGINE_SOURCES)
        endif()
        unset(_OPTION_SYMBOL)
        unset(_OPTION_UPPER)
    endforeach()
    unset(OPENSSL_OSSLTESTENG)
    unset(OPENSSL_DASYNCENG)
endif()
