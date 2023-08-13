# SPDX-License-Identifier: Unlicense

set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_bcons.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_bitst.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_conf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_extku.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_ia5.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_prn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_utl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_genn.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_alt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_skey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_akey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_pku.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_int.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_enum.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_sxnet.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_cpols.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_crld.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_purp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_info.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_akeya.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_pmaps.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_pcons.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_ncons.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_pcia.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_pci.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/pcy_cache.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/pcy_node.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/pcy_data.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/pcy_map.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/pcy_tree.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/pcy_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_asid.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_addr.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/v3_tlsf.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/ext_dat.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509v3/pcy_int.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
