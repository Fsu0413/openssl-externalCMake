
if (OPENSSL_HW AND BUILD_SHARED_LIBS AND OPENSSL_DYNAMIC_ENGINE)
    foreach (_OPTION IN ITEMS 4758-cca aep atalla cswift gmp chil nuron sureware ubsec padlock capi ccgost)
        set(_ENGINE ${_OPTION})
        if (_OPTION STREQUAL "4758-cca")
            set(_ENGINE "4758cca")
        elseif (_OPTION STREQUAL "ccgost")
            set(_ENGINE "gost")
        endif()
        string(TOUPPER ${_OPTION} _OPTION_UPPER)
        string(REPLACE "-" "_" _OPTION_SYMBOL ${_OPTION_UPPER})
        if (OPENSSL_HW_${_OPTION_SYMBOL})
            set(ENGINE_SOURCES)
            include(${_OPTION}.cmake)
            add_library(${_ENGINE} MODULE
                ${ENGINE_SOURCES}
            )
            target_link_libraries(${_ENGINE}
                PUBLIC crypto
            )
            install(TARGETS ${_ENGINE}
                RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}/engines
                LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/engines
            )
            unset(ENGINE_SOURCES)
        endif()
        unset(_OPTION_SYMBOL)
        unset(_OPTION_UPPER)
    endforeach()
endif()
