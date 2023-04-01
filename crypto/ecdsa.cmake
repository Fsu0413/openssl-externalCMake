
get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_asn1.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_ossl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_sign.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_vrf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecdsa.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/ecdsa/ecs_locl.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
