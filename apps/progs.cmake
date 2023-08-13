# SPDX-License-Identifier: Unlicense

# TODO: license?
# Can we use public domain for the generated file? Does it violate the original OpenSSL license?

set(OUTPUT_CONTENTS "/*
 * WARNING: do not edit!
 * Generated by apps/progs.cmake
 *
 * Copyright 1995-2023 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the \"License\").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#include \"function.h\"

")

set(OUTPUT_CONTENTS_C "/*
 * WARNING: do not edit!
 * Generated by apps/progs.cmake
 *
 * Copyright 1995-2023 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the \"License\").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#include \"progs.h\"

")

set(CMDRE "[ \t]*int[ \t]+([a-z_][a-z0-9_]*)_main\\([ \t]*int[ \t]+argc[ \t]*,")

set(INCLUDE_MACRO_NAME_IN_HASHENDIF true)

macro(write_endif)
    string(APPEND OUTPUT_CONTENTS_C "#endif")
    if (INCLUDE_MACRO_NAME_IN_HASHENDIF)
        string(APPEND OUTPUT_CONTENTS_C " /* ${ARGV0} */")
    endif()
    string(APPEND OUTPUT_CONTENTS_C "\n")
endmacro()

set(COMMANDS)

set(START_ARGN)
math(EXPR STOP_ARGN "${CMAKE_ARGC} - 1")

foreach (I RANGE ${CMAKE_ARGC})
    if (CMAKE_ARGV${I} STREQUAL "-P")
        math(EXPR START_ARGN "${I} + 2")
        break()
    endif()
endforeach()

foreach (I RANGE ${START_ARGN} ${STOP_ARGN})
    set(C_FILE ${CMAKE_ARGV${I}})
    file(STRINGS ${C_FILE} FILECONTENTS
        REGEX ${CMDRE}
    )
    foreach (FILELINE IN LISTS FILECONTENTS)
        if (FILELINE MATCHES ${CMDRE})
            list(APPEND COMMANDS "${CMAKE_MATCH_1}")
        endif()
    endforeach()
endforeach()

list(SORT COMMANDS)
list(REMOVE_DUPLICATES COMMANDS)

foreach (RUNCOMMAND IN LISTS COMMANDS)
    string(APPEND OUTPUT_CONTENTS "extern int ${RUNCOMMAND}_main(int argc, char *argv[])\;\n")
endforeach()

string(APPEND OUTPUT_CONTENTS "\n")

foreach (RUNCOMMAND IN LISTS COMMANDS)
    string(APPEND OUTPUT_CONTENTS "extern const OPTIONS ${RUNCOMMAND}_options[]\;\n")
endforeach()

string(APPEND OUTPUT_CONTENTS "\n")

string(APPEND OUTPUT_CONTENTS "extern FUNCTION functions[]\;\n")

string(APPEND OUTPUT_CONTENTS_C "FUNCTION functions[] = {\n")

function(cmd_disabler ARG OUTVAR)
    if (ARG MATCHES "^s_")
        set(${OUTVAR} "sock" PARENT_SCOPE)
    elseif (ARG STREQUAL "ciphers")
        set(${OUTVAR} "sock" PARENT_SCOPE)
    elseif (ARG STREQUAL "genrsa")
        set(${OUTVAR} "rsa" PARENT_SCOPE)
    elseif (ARG STREQUAL "gendsa")
        set(${OUTVAR} "dsa" PARENT_SCOPE)
    elseif (ARG STREQUAL "dsaparam")
        set(${OUTVAR} "dsa" PARENT_SCOPE)
    elseif (ARG STREQUAL "gendh")
        set(${OUTVAR} "dh" PARENT_SCOPE)
    elseif (ARG STREQUAL "dhparam")
        set(${OUTVAR} "dh" PARENT_SCOPE)
    elseif (ARG STREQUAL "ecparam")
        set(${OUTVAR} "ec" PARENT_SCOPE)
    else()
        set(${OUTVAR} "${ARG}" PARENT_SCOPE)
    endif()
endfunction()

function(cmd_deprecated ARG daltarg dver dsys)
    if (ARG STREQUAL "rsautl")
        set("${daltarg}" "pkeyutl" PARENT_SCOPE)
        set("${dver}" "3_0" PARENT_SCOPE)
        set("${dsys}" "rsa" PARENT_SCOPE)
    endif()
endfunction()

set(DISABLEABLES # "rsa" # original disableables have no RSA??
    "acvp-tests" "afalgeng" "aria" "asan" "asm" "async" "autoalginit" "autoerrinit" "autoload-config" "bf" "blake2" "buildtest-c++" "bulk" "cached-fetch" "camellia" "capieng"
    "cast" "chacha" "cmac" "cmp" "cms" "comp" "crypto-mdebug" "ct" "deprecated" "des" "devcryptoeng" "dgram" "dh" "dsa" "dso" "dtls" "dynamic-engine" "ec" "ec2m"
    "ec_nistp_64_gcc_128" "ecdh" "ecdsa" "egd" "engine" "err" "external-tests" "filenames" "fips" "fips-securitychecks" "fuzz-afl" "fuzz-libfuzzer" "gost" "idea" "ktls" "legacy"
    "loadereng" "makedepend" "md2" "md4" "mdc2" "module" "msan" "multiblock" "nextprotoneg" "ocb" "ocsp" "padlockeng" "pic" "pinshared" "poly1305" "posix-io" "psk" "rc2" "rc4"
    "rc5" "rdrand" "rfc3779" "rmd160" "scrypt" "sctp" "secure-memory" "seed" "shared" "siphash" "siv" "sm2" "sm3" "sm4" "sock" "srp" "srtp" "sse2" "ssl" "ssl-trace" "static-engine"
    "stdio" "tests" "threads" "tls" "trace" "ts" "ubsan" "ui-console" "unit-test" "uplink" "weak-ssl-ciphers" "whirlpool" "zlib" "zlib-dynamic"
)

foreach (RUNCOMMAND IN LISTS COMMANDS)
    unset(DNAMMOCNUR)
    cmd_disabler("${RUNCOMMAND}" DNAMMOCNUR)
    unset(daltarg)
    unset(dver)
    unset(dsys)
    cmd_deprecated("${RUNCOMMAND}" daltarg dver dsys)
    string(TOUPPER "${DNAMMOCNUR}" DNAMMOCNUR_UPPER)
    list(FIND DISABLEABLES ${DNAMMOCNUR} I)
    if (daltarg)
        set(MACRONAME "!OPENSSL_NO_DEPRECATED_${dver}")
        set(MACROSET "!defined(OPENSSL_NO_DEPRECATED_${dver})")
        if (dsys)
            string(TOUPPER "${dsys}" DSYS_UPPER)
            string(APPEND MACRONAME " && !OPENSSL_NO_${DSYS_UPPER}")
            string(APPEND MACROSET " && !defined(OPENSSL_NO_${DSYS_UPPER})")
        endif()
        string(APPEND OUTPUT_CONTENTS_C "#if ${MACROSET}\n")
        unset(MACROSET)
    elseif ( ( NOT I EQUAL -1 ) OR ( ( DNAMMOCNUR STREQUAL "rsa" ) AND NOT ( RUNCOMMAND STREQUAL "rsa" ) ) )
        set(MACRONAME "OPENSSL_NO_${DNAMMOCNUR_UPPER}")
        string(APPEND OUTPUT_CONTENTS_C "#ifndef ${MACRONAME}\n")
    endif()
    string(APPEND OUTPUT_CONTENTS_C "    {FT_general, \"${RUNCOMMAND}\", ${RUNCOMMAND}_main, ${RUNCOMMAND}_options")
    if (daltarg)
        string(REPLACE "_" "." DVER_DOT "${dver}")
        string(APPEND OUTPUT_CONTENTS_C ", \"${daltarg}\", \"${DVER_DOT}\"},\n")
    else()
        string(APPEND OUTPUT_CONTENTS_C ", NULL, NULL},\n")
    endif()
    if (DEFINED MACRONAME)
        write_endif("${MACRONAME}")
    endif()
    unset(MACRONAME)
endforeach()

function(md_disabler ARG OUTVAR)
    if (ARG STREQUAL "blake2b512")
        set(${OUTVAR} "blake2" PARENT_SCOPE)
    elseif (ARG STREQUAL "blake2s256")
        set(${OUTVAR} "blake2" PARENT_SCOPE)
    else()
        set(${OUTVAR} "${ARG}" PARENT_SCOPE)
    endif()
endfunction()

foreach (RUNCOMMAND IN ITEMS "md2" "md4" "md5" "sha1" "sha224" "sha256" "sha384" "sha512" "sha512-224" "sha512-256" "sha3-224" "sha3-256" "sha3-384" "sha3-512" "shake128"
                             "shake256" "mdc2" "rmd160" "blake2b512" "blake2s256" "sm3"
)
    md_disabler("${RUNCOMMAND}" DNAMMOCNUR)
    string(TOUPPER "${DNAMMOCNUR}" DNAMMOCNUR_UPPER)
    list(FIND DISABLEABLES ${DNAMMOCNUR} I)
    if (NOT I EQUAL -1)
        set(MACRONAME "OPENSSL_NO_${DNAMMOCNUR_UPPER}")
        string(APPEND OUTPUT_CONTENTS_C "#ifndef ${MACRONAME}\n")
    endif()
    string(APPEND OUTPUT_CONTENTS_C "    {FT_md, \"${RUNCOMMAND}\", dgst_main, NULL, NULL},\n")
    if (DEFINED MACRONAME)
        write_endif("${MACRONAME}")
    endif()
    unset(MACRONAME)
endforeach()

function(cipher_disabler ARG OUTVAR)
    if (ARG STREQUAL "des3")
        set(${OUTVAR} "des" PARENT_SCOPE)
    elseif (ARG STREQUAL "desx")
        set(${OUTVAR} "des" PARENT_SCOPE)
    elseif (ARG STREQUAL "cast5")
        set(${OUTVAR} "cast" PARENT_SCOPE)
    else()
        set(${OUTVAR} "${ARG}" PARENT_SCOPE)
    endif()
endfunction()

foreach (FULLCOMMAND IN ITEMS "aes-128-cbc" "aes-128-ecb" "aes-192-cbc" "aes-192-ecb" "aes-256-cbc" "aes-256-ecb" "aria-128-cbc" "aria-128-cfb" "aria-128-ctr" "aria-128-ecb"
                              "aria-128-ofb" "aria-128-cfb1" "aria-128-cfb8" "aria-192-cbc" "aria-192-cfb" "aria-192-ctr" "aria-192-ecb" "aria-192-ofb" "aria-192-cfb1"
                              "aria-192-cfb8" "aria-256-cbc" "aria-256-cfb" "aria-256-ctr" "aria-256-ecb" "aria-256-ofb" "aria-256-cfb1" "aria-256-cfb8" "camellia-128-cbc"
                              "camellia-128-ecb" "camellia-192-cbc" "camellia-192-ecb" "camellia-256-cbc" "camellia-256-ecb" "base64" "zlib" "des" "des3" "desx" "idea" "seed" "rc4"
                              "rc4-40" "rc2" "bf" "cast" "rc5" "des-ecb" "des-ede" "des-ede3" "des-cbc" "des-ede-cbc" "des-ede3-cbc" "des-cfb" "des-ede-cfb" "des-ede3-cfb"
                              "des-ofb" "des-ede-ofb" "des-ede3-ofb" "idea-cbc" "idea-ecb" "idea-cfb" "idea-ofb" "seed-cbc" "seed-ecb" "seed-cfb" "seed-ofb" "rc2-cbc" "rc2-ecb"
                              "rc2-cfb" "rc2-ofb" "rc2-64-cbc" "rc2-40-cbc" "bf-cbc" "bf-ecb" "bf-cfb" "bf-ofb" "cast5-cbc" "cast5-ecb" "cast5-cfb" "cast5-ofb" "cast-cbc" "rc5-cbc"
                              "rc5-ecb" "rc5-cfb" "rc5-ofb" "sm4-cbc" "sm4-ecb" "sm4-cfb" "sm4-ofb" "sm4-ctr"
)
    set(RUNCOMMAND ${FULLCOMMAND})
    if (FULLCOMMAND MATCHES "-")
        string(REGEX REPLACE "^([^\\-]+)-.+" "\\1" RUNCOMMAND ${FULLCOMMAND})
    endif()
    cipher_disabler("${RUNCOMMAND}" DNAMMOCNUR)
    string(TOUPPER "${DNAMMOCNUR}" DNAMMOCNUR_UPPER)
    list(FIND DISABLEABLES ${DNAMMOCNUR} I)
    if (NOT I EQUAL -1)
        if (RUNCOMMAND STREQUAL "zlib")
            set(MACRONAME "ZLIB")
            string(APPEND OUTPUT_CONTENTS_C "#ifdef ${MACRONAME}\n")
        else()
            set(MACRONAME "OPENSSL_NO_${DNAMMOCNUR_UPPER}")
            string(APPEND OUTPUT_CONTENTS_C "#ifndef ${MACRONAME}\n")
        endif()
    endif()
    string(APPEND OUTPUT_CONTENTS_C "    {FT_cipher, \"${FULLCOMMAND}\", enc_main, enc_options, NULL},\n")
    if (DEFINED MACRONAME)
        write_endif("${MACRONAME}")
    endif()
    unset(MACRONAME)
endforeach()

string(APPEND OUTPUT_CONTENTS_C "    {0, NULL, NULL, NULL, NULL}\n}\;\n")

if (DEFINED OUTPUT_FILE_NAME)
    string(REPLACE "\;" ";" OUTPUT_FILE_CONTENTS "${OUTPUT_CONTENTS}")
    file(WRITE ${OUTPUT_FILE_NAME}.h "${OUTPUT_FILE_CONTENTS}")
    string(REPLACE "\;" ";" OUTPUT_FILE_CONTENTS_C "${OUTPUT_CONTENTS_C}")
    file(WRITE ${OUTPUT_FILE_NAME}.c "${OUTPUT_FILE_CONTENTS_C}")
else()
    message(NOTICE "${OUTPUT_CONTENTS}")
    message(NOTICE "${OUTPUT_CONTENTS_C}")
endif()