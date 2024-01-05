# SPDX-License-Identifier: Unlicense

if (OPENSSL_HW AND OPENSSL_ENGINE AND BUILD_SHARED_LIBS AND OPENSSL_DYNAMIC_ENGINE)
    # workaround, there is no OPENSSL_HW_OSSLTEST / OPENSSL_HW_DASYNC but they should be always built
    # DO NOT SET THEM AS CACHE!
    set(OPENSSL_HW_OSSLTEST ON)
    set(OPENSSL_HW_DASYNC ON)
    foreach (_OPTION IN ITEMS padlock capi afalg ossltest dasync)
        set(_ENGINE ${_OPTION})
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
            if (DEFINED CACHE{OPENSSL_HW_${_OPTION_SYMBOL}})
                install(TARGETS ${_ENGINE}
                    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}/engines-1.1
                    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/engines-1.1
                )
            endif()
            unset(ENGINE_SOURCES)
        endif()
        unset(_OPTION_SYMBOL)
        unset(_OPTION_UPPER)
    endforeach()
    unset(OPENSSL_HW_OSSLTEST)
    unset(OPENSSL_HW_DASYNC)
endif()
