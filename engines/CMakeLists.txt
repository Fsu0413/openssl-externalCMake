# SPDX-License-Identifier: Unlicense

if (OPENSSL_HW AND OPENSSL_ENGINE AND BUILD_SHARED_LIBS AND OPENSSL_DYNAMIC_ENGINE)
    # workaround, there is no OPENSSL_HW_OSSLTEST / OPENSSL_HW_DASYNC but they should be always built
    # DO NOT SET THEM AS CACHE!
    set(OPENSSL_OSSLTESTENG ON)
    set(OPENSSL_DASYNCENG ON)
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
            add_library(${_ENGINE} MODULE
                ${ENGINE_SOURCES}
            )
            target_link_libraries(${_ENGINE}
                PUBLIC crypto
            )
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
