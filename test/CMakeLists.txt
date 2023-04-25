
# I reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally don't like the "lib<some executable>.a" thing.
# Creating static library with -fpie seems ridiculous, but on platforms such as Android we need to do so!
# TODO: find a way to kill libtestutil.a. Maybe we can use libtestutil.so?

add_library(testutil STATIC EXCLUDE_FROM_ALL
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/basic_output.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/output_helpers.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/driver.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/tests.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/cb.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/stanza.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/format_output.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/tap_bio.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/test_cleanup.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/main.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/testutil_init.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/random.c
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil/tu_local.h
    ${CMAKE_SOURCE_DIR}/openssl/test/testutil.h
)
target_include_directories(testutil PUBLIC ${CMAKE_SOURCE_DIR}/openssl/include)
target_include_directories(testutil PUBLIC ${CMAKE_BINARY_DIR}/include)
target_link_libraries(testutil PUBLIC crypto)
add_library(OpenSSLTest ALIAS testutil) # source compatibility (for what?)

set(APPS_INIT_SRC)
if (WIN32)
    list(APPEND APPS_INIT_SRC ${CMAKE_SOURCE_DIR}/openssl/apps/win32_init.c)
endif()

# builtin "make test" is useless for us.
# it does not build the dependencies needed for our test.
# cmake_policy(PUSH)
# cmake_policy(SET CMP0037 OLD)
# add_custom_target(test DEPENDS check)
# cmake_policy(POP)

if (WIN32 AND BUILD_SHARED_LIBS)
    get_target_property(CRYPTO_RUNTIME_OUTPUT_NAME crypto RUNTIME_OUTPUT_NAME)

    add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}"
                       COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/crypto/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}
                       DEPENDS crypto
    )
    add_custom_target(copycrypto_test DEPENDS "${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${CRYPTO_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}")
    add_dependencies(check copycrypto_test)

    get_target_property(SSL_RUNTIME_OUTPUT_NAME ssl RUNTIME_OUTPUT_NAME)
    add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}"
                       COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/ssl/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}
                       DEPENDS ssl
    )
    add_custom_target(copyssl_test DEPENDS "${CMAKE_BINARY_DIR}/test/${CMAKE_SHARED_LIBRARY_PREFIX}${SSL_RUNTIME_OUTPUT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}")
    add_dependencies(check copyssl_test)
endif()


add_executable(versions EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/versions.c)
target_link_libraries(versions PUBLIC crypto)
add_dependencies(check versions)

add_executable(aborttest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/aborttest.c)
target_link_libraries(aborttest PUBLIC crypto)
add_dependencies(check aborttest)

add_executable(sanitytest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/sanitytest.c)
target_link_libraries(sanitytest PUBLIC OpenSSLTest crypto)
add_dependencies(check sanitytest)

add_executable(rsa_complex EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/rsa_complex.c)
target_include_directories(rsa_complex PUBLIC ${CMAKE_SOURCE_DIR}/openssl/include ${CMAKE_BINARY_DIR}/include)
add_dependencies(check rsa_complex)

add_executable(test_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/test_test.c)
target_link_libraries(test_test PUBLIC OpenSSLTest crypto)
add_dependencies(check test_test)

add_executable(exdatatest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/exdatatest.c)
target_link_libraries(exdatatest PUBLIC OpenSSLTest crypto)
add_dependencies(check exdatatest)

add_executable(bntest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/bntest.c)
target_link_libraries(bntest PUBLIC OpenSSLTest crypto)
add_dependencies(check bntest)

add_executable(ectest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ectest.c)
target_link_libraries(ectest PUBLIC OpenSSLTest crypto)
add_dependencies(check ectest)

add_executable(ecstresstest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ecstresstest.c)
target_link_libraries(ecstresstest PUBLIC OpenSSLTest crypto)
add_dependencies(check ecstresstest)

add_executable(ecdsatest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ecdsatest.c)
target_link_libraries(ecdsatest PUBLIC OpenSSLTest crypto)
add_dependencies(check ecdsatest)

add_executable(gmdifftest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/gmdifftest.c)
target_link_libraries(gmdifftest PUBLIC OpenSSLTest crypto)
add_dependencies(check gmdifftest)

add_executable(pbelutest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/pbelutest.c)
target_link_libraries(pbelutest PUBLIC OpenSSLTest crypto)
add_dependencies(check pbelutest)

add_executable(ideatest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ideatest.c)
target_link_libraries(ideatest PUBLIC OpenSSLTest crypto)
add_dependencies(check ideatest)

add_executable(md2test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/md2test.c)
target_link_libraries(md2test PUBLIC OpenSSLTest crypto)
add_dependencies(check md2test)

add_executable(hmactest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/hmactest.c)
target_link_libraries(hmactest PUBLIC OpenSSLTest crypto)
add_dependencies(check hmactest)

add_executable(rc2test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/rc2test.c)
target_link_libraries(rc2test PUBLIC OpenSSLTest crypto)
add_dependencies(check rc2test)

add_executable(rc4test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/rc4test.c)
target_link_libraries(rc4test PUBLIC OpenSSLTest crypto)
add_dependencies(check rc4test)

add_executable(rc5test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/rc5test.c)
target_link_libraries(rc5test PUBLIC OpenSSLTest crypto)
add_dependencies(check rc5test)

add_executable(destest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/destest.c)
target_link_libraries(destest PUBLIC OpenSSLTest crypto)
add_dependencies(check destest)

add_executable(mdc2test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/mdc2test.c)
target_link_libraries(mdc2test PUBLIC OpenSSLTest crypto)
add_dependencies(check mdc2test)

add_executable(dhtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/dhtest.c)
target_link_libraries(dhtest PUBLIC OpenSSLTest crypto)
add_dependencies(check dhtest)

add_executable(enginetest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/enginetest.c)
target_link_libraries(enginetest PUBLIC OpenSSLTest crypto)
add_dependencies(check enginetest)

add_executable(casttest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/casttest.c)
target_link_libraries(casttest PUBLIC OpenSSLTest crypto)
add_dependencies(check casttest)

add_executable(bftest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/bftest.c)
target_link_libraries(bftest PUBLIC OpenSSLTest crypto)
add_dependencies(check bftest)

add_executable(ssltest_old EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ssltest_old.c)
target_link_libraries(ssltest_old PUBLIC crypto ssl)
add_dependencies(check ssltest_old)

add_executable(dsatest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/dsatest.c)
target_link_libraries(dsatest PUBLIC OpenSSLTest crypto)
add_dependencies(check dsatest)

add_executable(dsa_no_digest_size_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/dsa_no_digest_size_test.c)
target_link_libraries(dsa_no_digest_size_test PUBLIC OpenSSLTest crypto)
add_dependencies(check dsa_no_digest_size_test)

add_executable(exptest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/exptest.c)
target_link_libraries(exptest PUBLIC OpenSSLTest crypto)
add_dependencies(check exptest)

add_executable(rsa_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/rsa_test.c)
target_link_libraries(rsa_test PUBLIC OpenSSLTest crypto)
add_dependencies(check rsa_test)

add_executable(rsa_mp_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/rsa_mp_test.c)
target_link_libraries(rsa_mp_test PUBLIC OpenSSLTest crypto)
add_dependencies(check rsa_mp_test)

add_executable(fatalerrtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/fatalerrtest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(fatalerrtest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check fatalerrtest)

add_executable(tls13ccstest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/tls13ccstest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(tls13ccstest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check tls13ccstest)

add_executable(evp_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/evp_test.c)
target_link_libraries(evp_test PUBLIC OpenSSLTest crypto)
add_dependencies(check evp_test)

add_executable(evp_extra_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/evp_extra_test.c)
target_link_libraries(evp_extra_test PUBLIC OpenSSLTest crypto)
add_dependencies(check evp_extra_test)

add_executable(igetest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/igetest.c)
target_link_libraries(igetest PUBLIC OpenSSLTest crypto)
add_dependencies(check igetest)

add_executable(v3nametest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/v3nametest.c)
target_link_libraries(v3nametest PUBLIC OpenSSLTest crypto)
add_dependencies(check v3nametest)

add_executable(crltest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/crltest.c)
target_link_libraries(crltest PUBLIC OpenSSLTest crypto)
add_dependencies(check crltest)

add_executable(v3ext EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/v3ext.c)
target_link_libraries(v3ext PUBLIC OpenSSLTest crypto)
add_dependencies(check v3ext)

add_executable(danetest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/danetest.c)
target_link_libraries(danetest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check danetest)

add_executable(constant_time_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/constant_time_test.c)
target_link_libraries(constant_time_test PUBLIC OpenSSLTest crypto)
add_dependencies(check constant_time_test)

add_executable(verify_extra_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/verify_extra_test.c)
target_link_libraries(verify_extra_test PUBLIC OpenSSLTest crypto)
add_dependencies(check verify_extra_test)

add_executable(clienthellotest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/clienthellotest.c)
target_link_libraries(clienthellotest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check clienthellotest)

add_executable(bad_dtls_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/bad_dtls_test.c)
target_link_libraries(bad_dtls_test PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check bad_dtls_test)

add_executable(packettest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/packettest.c)
target_link_libraries(packettest PUBLIC OpenSSLTest crypto)
add_dependencies(check packettest)

add_executable(asynctest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/asynctest.c)
target_link_libraries(asynctest PUBLIC crypto)
add_dependencies(check asynctest)

add_executable(secmemtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/secmemtest.c)
target_link_libraries(secmemtest PUBLIC OpenSSLTest crypto)
add_dependencies(check secmemtest)

add_executable(srptest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/srptest.c)
target_link_libraries(srptest PUBLIC OpenSSLTest crypto)
add_dependencies(check srptest)

add_executable(memleaktest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/memleaktest.c)
target_link_libraries(memleaktest PUBLIC OpenSSLTest crypto)
add_dependencies(check memleaktest)

add_executable(stack_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/stack_test.c)
target_link_libraries(stack_test PUBLIC OpenSSLTest crypto)
add_dependencies(check stack_test)

add_executable(lhash_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/lhash_test.c)
target_link_libraries(lhash_test PUBLIC OpenSSLTest crypto)
add_dependencies(check lhash_test)

add_executable(dtlsv1listentest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/dtlsv1listentest.c)
target_link_libraries(dtlsv1listentest PUBLIC OpenSSLTest ssl)
add_dependencies(check dtlsv1listentest)

add_executable(ct_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ct_test.c)
target_link_libraries(ct_test PUBLIC OpenSSLTest crypto)
add_dependencies(check ct_test)

add_executable(threadstest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/threadstest.c)
target_link_libraries(threadstest PUBLIC OpenSSLTest crypto)
add_dependencies(check threadstest)

add_executable(afalgtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/afalgtest.c)
target_link_libraries(afalgtest PUBLIC OpenSSLTest crypto)
add_dependencies(check afalgtest)

add_executable(d2i_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/d2i_test.c)
target_link_libraries(d2i_test PUBLIC OpenSSLTest crypto)
add_dependencies(check d2i_test)

add_executable(ssl_test_ctx_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ssl_test_ctx_test.c ${CMAKE_SOURCE_DIR}/openssl/test/ssl_test_ctx.c)
target_link_libraries(ssl_test_ctx_test PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check ssl_test_ctx_test)

add_executable(ssl_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ssl_test.c ${CMAKE_SOURCE_DIR}/openssl/test/ssl_test_ctx.c ${CMAKE_SOURCE_DIR}/openssl/test/handshake_helper.c)
target_link_libraries(ssl_test PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check ssl_test)

add_executable(cipherlist_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/cipherlist_test.c)
target_link_libraries(cipherlist_test PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check cipherlist_test)

add_executable(x509aux EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/x509aux.c)
target_link_libraries(x509aux PUBLIC OpenSSLTest crypto)
add_dependencies(check x509aux)

add_executable(asynciotest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/asynciotest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(asynciotest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check asynciotest)

add_executable(bio_callback_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/bio_callback_test.c)
target_link_libraries(bio_callback_test PUBLIC OpenSSLTest crypto)
add_dependencies(check bio_callback_test)

add_executable(bio_memleak_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/bio_memleak_test.c)
target_link_libraries(bio_memleak_test PUBLIC OpenSSLTest crypto)
add_dependencies(check bio_memleak_test)

add_executable(bioprinttest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/bioprinttest.c)
target_link_libraries(bioprinttest PUBLIC OpenSSLTest crypto)
add_dependencies(check bioprinttest)

add_executable(sslapitest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/sslapitest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(sslapitest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check sslapitest)

add_executable(ocspapitest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ocspapitest.c)
target_link_libraries(ocspapitest PUBLIC OpenSSLTest crypto)
add_dependencies(check ocspapitest)

add_executable(dtlstest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/dtlstest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(dtlstest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check dtlstest)

add_executable(sslcorrupttest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/sslcorrupttest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(sslcorrupttest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check sslcorrupttest)

add_executable(bio_enc_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/bio_enc_test.c)
target_link_libraries(bio_enc_test PUBLIC OpenSSLTest crypto)
add_dependencies(check bio_enc_test)

add_executable(pkey_meth_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/pkey_meth_test.c)
target_link_libraries(pkey_meth_test PUBLIC OpenSSLTest crypto)
add_dependencies(check pkey_meth_test)

add_executable(pkey_meth_kdf_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/pkey_meth_kdf_test.c)
target_link_libraries(pkey_meth_kdf_test PUBLIC OpenSSLTest crypto)
add_dependencies(check pkey_meth_kdf_test)

add_executable(x509_time_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/x509_time_test.c)
target_link_libraries(x509_time_test PUBLIC OpenSSLTest crypto)
add_dependencies(check x509_time_test)

add_executable(recordlentest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/recordlentest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(recordlentest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check recordlentest)

if (NOT BUILD_SHARED_LIBS)
    # it depends on static library but we don't build static library if shared library are built
    add_executable(drbgtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/drbgtest.c)
    target_link_libraries(drbgtest PUBLIC OpenSSLTest crypto)
    add_dependencies(check drbgtest)
endif()

add_executable(drbg_cavs_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/drbg_cavs_test.c ${CMAKE_SOURCE_DIR}/openssl/test/drbg_cavs_data.c)
target_link_libraries(drbg_cavs_test PUBLIC OpenSSLTest crypto)
add_dependencies(check drbg_cavs_test)

add_executable(x509_dup_cert_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/x509_dup_cert_test.c)
target_link_libraries(x509_dup_cert_test PUBLIC OpenSSLTest crypto)
add_dependencies(check x509_dup_cert_test)

add_executable(x509_check_cert_pkey_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/x509_check_cert_pkey_test.c)
target_link_libraries(x509_check_cert_pkey_test PUBLIC OpenSSLTest crypto)
add_dependencies(check x509_check_cert_pkey_test)

add_executable(pemtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/pemtest.c)
target_link_libraries(pemtest PUBLIC OpenSSLTest crypto)
add_dependencies(check pemtest)

add_executable(ssl_cert_table_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ssl_cert_table_internal_test.c)
target_link_libraries(ssl_cert_table_internal_test PUBLIC OpenSSLTest crypto)
add_dependencies(check ssl_cert_table_internal_test)

add_executable(ciphername_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ciphername_test.c)
target_link_libraries(ciphername_test PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check ciphername_test)

add_executable(servername_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/servername_test.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(servername_test PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check servername_test)

if (OPENSSL_CMS)
    add_executable(cmsapitest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/cmsapitest.c)
    target_link_libraries(cmsapitest PUBLIC OpenSSLTest crypto)
    add_dependencies(check cmsapitest)
endif()

if (OPENSSL_PSK)
    add_executable(dtls_mtu_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/dtls_mtu_test.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
    target_link_libraries(dtls_mtu_test PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check dtls_mtu_test)
endif()

if (BUILD_SHARED_LIBS)
    add_executable(shlibloadtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/shlibloadtest.c)
    target_include_directories(shlibloadtest PUBLIC ${CMAKE_SOURCE_DIR}/openssl/include ${CMAKE_BINARY_DIR}/include)
    add_dependencies(check shlibloadtest)

    add_executable(cipher_overhead_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/cipher_overhead_test.c)
    target_link_libraries(cipher_overhead_test PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check cipher_overhead_test)
endif()

# it uses libapps.a which I don't like using.
add_executable(uitest EXCLUDE_FROM_ALL
    ${CMAKE_SOURCE_DIR}/openssl/test/uitest.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/apps.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/opt.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_cb.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_socket.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/app_rand.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/bf_prefix.c
    ${CMAKE_SOURCE_DIR}/openssl/apps/apps.h
    ${CMAKE_SOURCE_DIR}/openssl/apps/s_apps.h
    ${APPS_INIT_SRC}
)
target_link_libraries(uitest PUBLIC OpenSSLTest crypto ssl)
target_include_directories(uitest PUBLIC ${CMAKE_SOURCE_DIR}/openssl/apps ${CMAKE_BINARY_DIR}/apps)
add_dependencies(check uitest)

add_executable(cipherbytes_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/cipherbytes_test.c)
target_link_libraries(cipherbytes_test PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check cipherbytes_test)

add_executable(asn1_encode_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/asn1_encode_test.c)
target_link_libraries(asn1_encode_test PUBLIC OpenSSLTest crypto)
add_dependencies(check asn1_encode_test)

add_executable(asn1_decode_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/asn1_decode_test.c)
target_link_libraries(asn1_decode_test PUBLIC OpenSSLTest crypto)
add_dependencies(check asn1_decode_test)

add_executable(asn1_string_table_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/asn1_string_table_test.c)
target_link_libraries(asn1_string_table_test PUBLIC OpenSSLTest crypto)
add_dependencies(check asn1_string_table_test)

add_executable(time_offset_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/time_offset_test.c)
target_link_libraries(time_offset_test PUBLIC OpenSSLTest crypto)
add_dependencies(check time_offset_test)

add_executable(conf_include_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/conf_include_test.c)
target_link_libraries(conf_include_test PUBLIC OpenSSLTest crypto)
add_dependencies(check conf_include_test)

if (NOT BUILD_SHARED_LIBS)
    if (OPENSSL_POLY1305)
        add_executable(poly1305_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/poly1305_internal_test.c)
        target_link_libraries(poly1305_internal_test PUBLIC OpenSSLTest crypto)
        add_dependencies(check poly1305_internal_test)
    endif()

    if (OPENSSL_CHACHA)
        add_executable(chacha_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/chacha_internal_test.c)
        target_link_libraries(chacha_internal_test PUBLIC OpenSSLTest crypto)
        add_dependencies(check chacha_internal_test)
    endif()

    add_executable(asn1_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/asn1_internal_test.c)
    target_link_libraries(asn1_internal_test PUBLIC OpenSSLTest crypto)
    add_dependencies(check asn1_internal_test)

    add_executable(modes_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/modes_internal_test.c)
    target_link_libraries(modes_internal_test PUBLIC OpenSSLTest crypto)
    add_dependencies(check modes_internal_test)

    add_executable(x509_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/x509_internal_test.c)
    target_link_libraries(x509_internal_test PUBLIC OpenSSLTest crypto)
    add_dependencies(check x509_internal_test)

    add_executable(tls13encryptiontest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/tls13encryptiontest.c)
    target_link_libraries(tls13encryptiontest PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check tls13encryptiontest)

    add_executable(wpackettest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/wpackettest.c)
    target_link_libraries(wpackettest PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check wpackettest)

    add_executable(ctype_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ctype_internal_test.c)
    target_link_libraries(ctype_internal_test PUBLIC OpenSSLTest crypto)
    add_dependencies(check ctype_internal_test)

    if (OPENSSL_CMAC)
        add_executable(cmactest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/cmactest.c)
        target_link_libraries(cmactest PUBLIC OpenSSLTest crypto)
        add_dependencies(check cmactest)
    endif()

    if (OPENSSL_SIPHASH)
        add_executable(siphash_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/siphash_internal_test.c)
        target_link_libraries(siphash_internal_test PUBLIC OpenSSLTest crypto)
        add_dependencies(check siphash_internal_test)
    endif()

    if (OPENSSL_SM2)
        add_executable(sm2_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/sm2_internal_test.c)
        target_link_libraries(sm2_internal_test PUBLIC OpenSSLTest crypto)
        add_dependencies(check sm2_internal_test)
    endif()

    if (OPENSSL_SM4)
        add_executable(sm4_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/sm4_internal_test.c)
        target_link_libraries(sm4_internal_test PUBLIC OpenSSLTest crypto)
        add_dependencies(check sm4_internal_test)
    endif()

    if (OPENSSL_EC)
        add_executable(ec_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ec_internal_test.c ${APPS_INIT_SRC})
        target_link_libraries(ec_internal_test PUBLIC OpenSSLTest crypto)
        add_dependencies(check ec_internal_test)

        add_executable(curve448_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/curve448_internal_test.c)
        target_link_libraries(curve448_internal_test PUBLIC OpenSSLTest crypto)
        add_dependencies(check curve448_internal_test)
    endif()

    add_executable(rdrand_sanitytest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/rdrand_sanitytest.c)
    target_link_libraries(rdrand_sanitytest PUBLIC OpenSSLTest crypto)
    add_dependencies(check rdrand_sanitytest)
endif()

if (OPENSSL_MDC2)
    add_executable(mdc2_internal_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/mdc2_internal_test.c)
    target_link_libraries(mdc2_internal_test PUBLIC OpenSSLTest crypto)
    add_dependencies(check mdc2_internal_test)
endif()

add_executable(asn1_time_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/asn1_time_test.c)
target_link_libraries(asn1_time_test PUBLIC OpenSSLTest crypto)
add_dependencies(check asn1_time_test)

if (BUILD_SHARED_LIBS)
    add_executable(tls13secretstest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/tls13secretstest.c ${CMAKE_SOURCE_DIR}/openssl/test/ ${CMAKE_SOURCE_DIR}/openssl/ssl/tls13_enc.c ${CMAKE_SOURCE_DIR}/openssl/ssl/packet.c)
    target_link_libraries(tls13secretstest PUBLIC OpenSSLTest crypto ssl)
    add_dependencies(check tls13secretstest)
endif()

add_executable(sslbuffertest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/sslbuffertest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(sslbuffertest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check sslbuffertest)

add_executable(sysdefaulttest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/sysdefaulttest.c)
target_link_libraries(sysdefaulttest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check sysdefaulttest)

add_executable(errtest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/errtest.c)
target_link_libraries(errtest PUBLIC OpenSSLTest crypto)
add_dependencies(check errtest)

add_executable(gosttest EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/gosttest.c ${CMAKE_SOURCE_DIR}/openssl/test/ssltestlib.c)
target_link_libraries(gosttest PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check gosttest)

add_executable(ssl_ctx_test EXCLUDE_FROM_ALL ${CMAKE_SOURCE_DIR}/openssl/test/ssl_ctx_test.c)
target_link_libraries(ssl_ctx_test PUBLIC OpenSSLTest crypto ssl)
add_dependencies(check ssl_ctx_test)

add_test(NAME test_abort COMMAND aborttest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_sanity COMMAND sanitytest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
# test_symbol_presence - can't be run. No configdata.pm
add_test(NAME test_test COMMAND test_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
# test_errstr - depends on the error string Perl defined. `use Errno qw(:POSIX); use POSIX qw(strerror);' Maybe our own program can be built to judging errors?
if (NOT BUILD_SHARED_LIBS)
    add_test(NAME test_internal_ctype COMMAND ctype_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
add_test(NAME test_lhash COMMAND lhash_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
# test_ordinals - testing of *.num? not library or executable?
add_test(NAME test_stack COMMAND stack_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_exdata COMMAND exdatatest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
if (NOT BUILD_SHARED_LIBS)
    add_test(NAME test_internal_asn1 COMMAND asn1_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    if (OPENSSL_CHACHA)
        add_test(NAME test_internal_chacha COMMAND chacha_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    endif()
    if (OPENSSL_EC)
        add_test(NAME test_internal_curve448 COMMAND curve448_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
        add_test(NAME test_internal_ec COMMAND ec_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    endif()
endif()
if (OPENSSL_MDC2)
    add_test(NAME test_internal_mdc2 COMMAND mdc2_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (NOT BUILD_SHARED_LIBS)
    add_test(NAME test_internal_modes COMMAND modes_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    if (OPENSSL_POLY1305)
        add_test(NAME test_internal_poly1305 COMMAND poly1305_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    endif()
    if (OPENSSL_SIPHASH)
        add_test(NAME test_internal_siphash COMMAND siphash_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    endif()
    if (OPENSSL_SM2)
        add_test(NAME test_internal_sm2 COMMAND sm2_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    endif()
    if (OPENSSL_SM4)
        add_test(NAME test_internal_sm4 COMMAND sm4_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    endif()
endif()
add_test(NAME test_internal_ssl_cert_table COMMAND ssl_cert_table_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
if (NOT BUILD_SHARED_LIBS)
    add_test(NAME test_internal_x509 COMMAND x509_internal_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
# `simple_test("test_ui", "uitest", "ui");' but no-ui is deprecated in flavor of 'ui-console'
add_test(NAME test_ui COMMAND uitest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_asn1_decode COMMAND asn1_decode_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_asn1_encode COMMAND asn1_encode_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_asn1_string_table COMMAND asn1_string_table_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_bio_callback COMMAND bio_callback_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_bioprint COMMAND bioprinttest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_err COMMAND errtest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
# test_pem not simple
if (OPENSSL_BF)
    add_test(NAME test_bf COMMAND bftest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (OPENSSL_CAST)
    add_test(NAME test_cast COMMAND casttest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (NOT BUILD_SHARED_LIBS)
    if (OPENSSL_CMAC)
        add_test(NAME test_cmac COMMAND cmactest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
    endif()
endif()
if (OPENSSL_DES)
    add_test(NAME test_des COMMAND destest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
add_test(NAME test_hmac COMMAND hmactest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
if (OPENSSL_IDEA)
    add_test(NAME test_idea COMMAND ideatest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (OPENSSL_MD2)
    add_test(NAME test_md2 COMMAND md2test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (OPENSSL_MDC2)
    add_test(NAME test_mdc2 COMMAND mdc2test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (NOT BUILD_SHARED_LIBS)
    add_test(NAME test_rand_1 COMMAND drbgtest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
add_test(NAME test_rand_2 COMMAND drbg_cavs_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
if (OPENSSL_RC2)
    add_test(NAME test_rc2 COMMAND rc2test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (OPENSSL_RC4)
    add_test(NAME test_rc4 COMMAND rc4test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (OPENSSL_RC5)
    add_test(NAME test_rc5 COMMAND rc5test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (NOT BUILD_SHARED_LIBS)
    add_test(NAME test_rdrand_sanity COMMAND rdrand_sanitytest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
# test_bn not simple
add_test(NAME test_exp COMMAND exptest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
if (OPENSSL_DH)
    add_test(NAME test_dh COMMAND dhtest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
# test_dsa tconvension.pl
# test_ec tconvension.pl
if (OPENSSL_EC)
    add_test(NAME test_ecdsa COMMAND ecdsatest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
# test_ecparam not simple
# test_genec not simple
# test_mp_rsa not simple
# test_out_option not simple
# test_rsa not simple
# test_rsapss not simple
# test_dgst not simple
# test_enc not simple
# test_enc_more not simple
# test_passwd not simple
# test_crl tconvension.pl
# test_d2i not simple
# test_pkcs7 tconvension.pl
# test_req tconvension.pl
# test_sid tconvension.pl
# test_verify not simple
# test_x509 not simple
if (OPENSSL_AFALGENG)
    # need to set this in runner
    # set(ENV{OPENSSL_ENGINES} ${CMAKE_BINARY_DIR}/engines)
    # ... and then run following program
    # add_test(NAME test_afalg COMMAND afalgtest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
add_test(NAME test_engine COMMAND enginetest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
# test_evp not simple
add_test(NAME test_evp_extra COMMAND evp_extra_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_pbelu COMMAND pbelutest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_pkey_meth COMMAND pkey_meth_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
add_test(NAME test_pkey_meth_kdf COMMAND pkey_meth_kdf_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
# test_rehash not simple
# test_x509_check_cert_pkey not simple
add_test(NAME test_x509_dup_cert COMMAND x509_dup_cert_test ${CMAKE_SOURCE_DIR}/openssl/test/certs/leaf.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
# test_x509_store not simple
add_test(NAME test_x509_time COMMAND x509_time_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
if (OPENSSL_SSL3 OR OPENSSL_TLS1 OR OPENSSL_TLS1_1 OR OPENSSL_TLS1_2 OR OPENSSL_TLS1_3)
    add_test(NAME test_asyncio COMMAND asynciotest ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (OPENSSL_DTLS1)
    add_test(NAME test_bad_dtls COMMAND bad_dtls_test WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
if (OPENSSL_SSL3 OR OPENSSL_TLS1 OR OPENSSL_TLS1_1 OR OPENSSL_TLS1_2 OR OPENSSL_TLS1_3)
    add_test(NAME test_clienthello COMMAND clienthellotest ${CMAKE_SOURCE_DIR}/openssl/test/session.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
# test_comp not simple
# test_key_share not simple
add_test(NAME test_packet COMMAND test_packet WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
if (OPENSSL_SSL3 OR OPENSSL_TLS1 OR OPENSSL_TLS1_1 OR OPENSSL_TLS1_2 OR OPENSSL_TLS1_3)
    add_test(NAME test_recordlen COMMAND recordlentest ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
# test_renegotiation not simple
if (OPENSSL_SSL3 OR OPENSSL_TLS1 OR OPENSSL_TLS1_1 OR OPENSSL_TLS1_2 OR OPENSSL_TLS1_3)
    add_test(NAME test_servername COMMAND servername_test ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem ${CMAKE_SOURCE_DIR}/openssl/apps/server.pem WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
# test_sslcbcpadding not simple
# test_sslcertstatus not simple
# test_sslextension not simple
# test_sslmessages not simple
# test_sslrecords not simple
# 70-test_* are not simple
add_test(NAME test_verify_extra COMMAND verify_extra_test ${CMAKE_SOURCE_DIR}/openssl/test/certs WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
if (NOT WIN32 AND NOT BUILD_SHARED_LIBS)
    add_test(NAME test_wpacket COMMAND wpackettest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
endif()
# test_ca not simple

# add_test(NAME test_pbelu COMMAND pbelutest WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} COMMAND_EXPAND_LISTS)
