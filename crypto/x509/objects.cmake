
set(LIBCRYPTO_CURRENTDIR_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_def.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_d2.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_r2x.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_cmp.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_obj.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_req.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509spki.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_vfy.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_set.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509cset.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509rset.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509name.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_v3.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_ext.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_att.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509type.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_meth.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_lu.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_all.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_txt.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_trs.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/by_file.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/by_dir.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_vpm.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_crl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/t_crl.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_req.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/t_req.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_x509.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/t_x509.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_pubkey.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_x509a.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_attrib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_exten.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x_name.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/x509/x509_local.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_CURRENTDIR_SOURCES})

unset(LIBCRYPTO_CURRENTDIR_SOURCES)
