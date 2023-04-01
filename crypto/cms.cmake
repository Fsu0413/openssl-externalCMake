
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_att.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_io.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_smime.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_sd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_dd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_cd.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_env.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_enc.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_ess.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_pwri.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_kari.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/cms/cms_lcl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
