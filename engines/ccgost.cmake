
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(ENGINE_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/e_gost_err.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost2001.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost2001_keyx.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost89.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost94_keyx.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_ameth.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_crypt.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_ctl.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_eng.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gosthash.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_keywrap.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_md.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_params.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_pmeth.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/e_gost_err.h
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost89.h
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_lcl.h
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_params.h
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost_keywrap.h
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gosthash.h
    ${CMAKE_SOURCE_DIR}/openssl/engines/ccgost/gost2001_keyx.h
)

set(ENGINE_SOURCES ${ENGINE_SOURCES} ${ENGINE_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
