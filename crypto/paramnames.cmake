# SPDX-License-Identifier: Unlicense

# read a file, generate paramnames, and output it
# This file uses CMake 3.13 grammar. Since my main CMake file requires CMake 3.22 this should not be a problem on my project.
# Will be tested on CMake 3.27.

# usage:
#   cmake -DOUTPUT_FILE_NAME=<output.h> -P paramnames.cmake <input.h.in>
# -DOUTPUT_FILE_NAME:string=<output.h> - the output file in absolute path

# following are generated from the original Perl module, with 2 regular expression replaces

set(PARAM_NAMES
    "PROV_PARAM_CORE_VERSION"
    "PROV_PARAM_CORE_PROV_NAME"
    "PROV_PARAM_CORE_MODULE_FILENAME"
    "PROV_PARAM_NAME"
    "PROV_PARAM_VERSION"
    "PROV_PARAM_BUILDINFO"
    "PROV_PARAM_STATUS"
    "PROV_PARAM_SECURITY_CHECKS"
    "PROV_PARAM_TLS1_PRF_EMS_CHECK"
    "PROV_PARAM_DRBG_TRUNC_DIGEST"
    "PROV_PARAM_SELF_TEST_PHASE"
    "PROV_PARAM_SELF_TEST_TYPE"
    "PROV_PARAM_SELF_TEST_DESC"
    "OBJECT_PARAM_TYPE"
    "OBJECT_PARAM_DATA_TYPE"
    "OBJECT_PARAM_DATA_STRUCTURE"
    "OBJECT_PARAM_REFERENCE"
    "OBJECT_PARAM_DATA"
    "OBJECT_PARAM_DESC"
    "ALG_PARAM_DIGEST"
    "ALG_PARAM_CIPHER"
    "ALG_PARAM_ENGINE"
    "ALG_PARAM_MAC"
    "ALG_PARAM_PROPERTIES"
    "CIPHER_PARAM_PADDING"
    "CIPHER_PARAM_USE_BITS"
    "CIPHER_PARAM_TLS_VERSION"
    "CIPHER_PARAM_TLS_MAC"
    "CIPHER_PARAM_TLS_MAC_SIZE"
    "CIPHER_PARAM_MODE"
    "CIPHER_PARAM_BLOCK_SIZE"
    "CIPHER_PARAM_AEAD"
    "CIPHER_PARAM_CUSTOM_IV"
    "CIPHER_PARAM_CTS"
    "CIPHER_PARAM_TLS1_MULTIBLOCK"
    "CIPHER_PARAM_HAS_RAND_KEY"
    "CIPHER_PARAM_KEYLEN"
    "CIPHER_PARAM_IVLEN"
    "CIPHER_PARAM_IV"
    "CIPHER_PARAM_UPDATED_IV"
    "CIPHER_PARAM_NUM"
    "CIPHER_PARAM_ROUNDS"
    "CIPHER_PARAM_AEAD_TAG"
    "CIPHER_PARAM_AEAD_TLS1_AAD"
    "CIPHER_PARAM_AEAD_TLS1_AAD_PAD"
    "CIPHER_PARAM_AEAD_TLS1_IV_FIXED"
    "CIPHER_PARAM_AEAD_TLS1_GET_IV_GEN"
    "CIPHER_PARAM_AEAD_TLS1_SET_IV_INV"
    "CIPHER_PARAM_AEAD_IVLEN"
    "CIPHER_PARAM_AEAD_TAGLEN"
    "CIPHER_PARAM_AEAD_MAC_KEY"
    "CIPHER_PARAM_RANDOM_KEY"
    "CIPHER_PARAM_RC2_KEYBITS"
    "CIPHER_PARAM_SPEED"
    "CIPHER_PARAM_CTS_MODE"
    "CIPHER_PARAM_ALGORITHM_ID_PARAMS"
    "CIPHER_PARAM_XTS_STANDARD"
    "CIPHER_PARAM_TLS1_MULTIBLOCK_MAX_SEND_FRAGMENT"
    "CIPHER_PARAM_TLS1_MULTIBLOCK_MAX_BUFSIZE"
    "CIPHER_PARAM_TLS1_MULTIBLOCK_INTERLEAVE"
    "CIPHER_PARAM_TLS1_MULTIBLOCK_AAD"
    "CIPHER_PARAM_TLS1_MULTIBLOCK_AAD_PACKLEN"
    "CIPHER_PARAM_TLS1_MULTIBLOCK_ENC"
    "CIPHER_PARAM_TLS1_MULTIBLOCK_ENC_IN"
    "CIPHER_PARAM_TLS1_MULTIBLOCK_ENC_LEN"
    "DIGEST_PARAM_XOFLEN"
    "DIGEST_PARAM_SSL3_MS"
    "DIGEST_PARAM_PAD_TYPE"
    "DIGEST_PARAM_MICALG"
    "DIGEST_PARAM_BLOCK_SIZE"
    "DIGEST_PARAM_SIZE"
    "DIGEST_PARAM_XOF"
    "DIGEST_PARAM_ALGID_ABSENT"
    "MAC_PARAM_KEY"
    "MAC_PARAM_IV"
    "MAC_PARAM_CUSTOM"
    "MAC_PARAM_SALT"
    "MAC_PARAM_XOF"
    "MAC_PARAM_DIGEST_NOINIT"
    "MAC_PARAM_DIGEST_ONESHOT"
    "MAC_PARAM_C_ROUNDS"
    "MAC_PARAM_D_ROUNDS"
    "MAC_PARAM_CIPHER"
    "MAC_PARAM_DIGEST"
    "MAC_PARAM_PROPERTIES"
    "MAC_PARAM_SIZE"
    "MAC_PARAM_BLOCK_SIZE"
    "MAC_PARAM_TLS_DATA_SIZE"
    "KDF_PARAM_SECRET"
    "KDF_PARAM_KEY"
    "KDF_PARAM_SALT"
    "KDF_PARAM_PASSWORD"
    "KDF_PARAM_PREFIX"
    "KDF_PARAM_LABEL"
    "KDF_PARAM_DATA"
    "KDF_PARAM_DIGEST"
    "KDF_PARAM_CIPHER"
    "KDF_PARAM_MAC"
    "KDF_PARAM_MAC_SIZE"
    "KDF_PARAM_PROPERTIES"
    "KDF_PARAM_ITER"
    "KDF_PARAM_MODE"
    "KDF_PARAM_PKCS5"
    "KDF_PARAM_UKM"
    "KDF_PARAM_CEK_ALG"
    "KDF_PARAM_SCRYPT_N"
    "KDF_PARAM_SCRYPT_R"
    "KDF_PARAM_SCRYPT_P"
    "KDF_PARAM_SCRYPT_MAXMEM"
    "KDF_PARAM_INFO"
    "KDF_PARAM_SEED"
    "KDF_PARAM_SSHKDF_XCGHASH"
    "KDF_PARAM_SSHKDF_SESSION_ID"
    "KDF_PARAM_SSHKDF_TYPE"
    "KDF_PARAM_SIZE"
    "KDF_PARAM_CONSTANT"
    "KDF_PARAM_PKCS12_ID"
    "KDF_PARAM_KBKDF_USE_L"
    "KDF_PARAM_KBKDF_USE_SEPARATOR"
    "KDF_PARAM_KBKDF_R"
    "KDF_PARAM_X942_ACVPINFO"
    "KDF_PARAM_X942_PARTYUINFO"
    "KDF_PARAM_X942_PARTYVINFO"
    "KDF_PARAM_X942_SUPP_PUBINFO"
    "KDF_PARAM_X942_SUPP_PRIVINFO"
    "KDF_PARAM_X942_USE_KEYBITS"
    "KDF_PARAM_HMACDRBG_ENTROPY"
    "KDF_PARAM_HMACDRBG_NONCE"
    "KDF_PARAM_THREADS"
    "KDF_PARAM_EARLY_CLEAN"
    "KDF_PARAM_ARGON2_AD"
    "KDF_PARAM_ARGON2_LANES"
    "KDF_PARAM_ARGON2_MEMCOST"
    "KDF_PARAM_ARGON2_VERSION"
    "RAND_PARAM_STATE"
    "RAND_PARAM_STRENGTH"
    "RAND_PARAM_MAX_REQUEST"
    "RAND_PARAM_TEST_ENTROPY"
    "RAND_PARAM_TEST_NONCE"
    "RAND_PARAM_GENERATE"
    "DRBG_PARAM_RESEED_REQUESTS"
    "DRBG_PARAM_RESEED_TIME_INTERVAL"
    "DRBG_PARAM_MIN_ENTROPYLEN"
    "DRBG_PARAM_MAX_ENTROPYLEN"
    "DRBG_PARAM_MIN_NONCELEN"
    "DRBG_PARAM_MAX_NONCELEN"
    "DRBG_PARAM_MAX_PERSLEN"
    "DRBG_PARAM_MAX_ADINLEN"
    "DRBG_PARAM_RESEED_COUNTER"
    "DRBG_PARAM_RESEED_TIME"
    "DRBG_PARAM_PROPERTIES"
    "DRBG_PARAM_DIGEST"
    "DRBG_PARAM_CIPHER"
    "DRBG_PARAM_MAC"
    "DRBG_PARAM_USE_DF"
    "DRBG_PARAM_ENTROPY_REQUIRED"
    "DRBG_PARAM_PREDICTION_RESISTANCE"
    "DRBG_PARAM_MIN_LENGTH"
    "DRBG_PARAM_MAX_LENGTH"
    "DRBG_PARAM_RANDOM_DATA"
    "DRBG_PARAM_SIZE"
    "PKEY_PARAM_BITS"
    "PKEY_PARAM_MAX_SIZE"
    "PKEY_PARAM_SECURITY_BITS"
    "PKEY_PARAM_DIGEST"
    "PKEY_PARAM_CIPHER"
    "PKEY_PARAM_ENGINE"
    "PKEY_PARAM_PROPERTIES"
    "PKEY_PARAM_DEFAULT_DIGEST"
    "PKEY_PARAM_MANDATORY_DIGEST"
    "PKEY_PARAM_PAD_MODE"
    "PKEY_PARAM_DIGEST_SIZE"
    "PKEY_PARAM_MASKGENFUNC"
    "PKEY_PARAM_MGF1_DIGEST"
    "PKEY_PARAM_MGF1_PROPERTIES"
    "PKEY_PARAM_ENCODED_PUBLIC_KEY"
    "PKEY_PARAM_GROUP_NAME"
    "PKEY_PARAM_DIST_ID"
    "PKEY_PARAM_PUB_KEY"
    "PKEY_PARAM_PRIV_KEY"
    "PKEY_PARAM_IMPLICIT_REJECTION"
    "PKEY_PARAM_FFC_P"
    "PKEY_PARAM_FFC_G"
    "PKEY_PARAM_FFC_Q"
    "PKEY_PARAM_FFC_GINDEX"
    "PKEY_PARAM_FFC_PCOUNTER"
    "PKEY_PARAM_FFC_SEED"
    "PKEY_PARAM_FFC_COFACTOR"
    "PKEY_PARAM_FFC_H"
    "PKEY_PARAM_FFC_VALIDATE_PQ"
    "PKEY_PARAM_FFC_VALIDATE_G"
    "PKEY_PARAM_FFC_VALIDATE_LEGACY"
    "PKEY_PARAM_DH_GENERATOR"
    "PKEY_PARAM_DH_PRIV_LEN"
    "PKEY_PARAM_EC_PUB_X"
    "PKEY_PARAM_EC_PUB_Y"
    "PKEY_PARAM_EC_FIELD_TYPE"
    "PKEY_PARAM_EC_P"
    "PKEY_PARAM_EC_A"
    "PKEY_PARAM_EC_B"
    "PKEY_PARAM_EC_GENERATOR"
    "PKEY_PARAM_EC_ORDER"
    "PKEY_PARAM_EC_COFACTOR"
    "PKEY_PARAM_EC_SEED"
    "PKEY_PARAM_EC_CHAR2_M"
    "PKEY_PARAM_EC_CHAR2_TYPE"
    "PKEY_PARAM_EC_CHAR2_TP_BASIS"
    "PKEY_PARAM_EC_CHAR2_PP_K1"
    "PKEY_PARAM_EC_CHAR2_PP_K2"
    "PKEY_PARAM_EC_CHAR2_PP_K3"
    "PKEY_PARAM_EC_DECODED_FROM_EXPLICIT_PARAMS"
    "PKEY_PARAM_USE_COFACTOR_FLAG"
    "PKEY_PARAM_USE_COFACTOR_ECDH"
    "PKEY_PARAM_RSA_N"
    "PKEY_PARAM_RSA_E"
    "PKEY_PARAM_RSA_D"
    "PKEY_PARAM_RSA_FACTOR"
    "PKEY_PARAM_RSA_EXPONENT"
    "PKEY_PARAM_RSA_COEFFICIENT"
    "PKEY_PARAM_RSA_FACTOR1"
    "PKEY_PARAM_RSA_FACTOR2"
    "PKEY_PARAM_RSA_FACTOR3"
    "PKEY_PARAM_RSA_FACTOR4"
    "PKEY_PARAM_RSA_FACTOR5"
    "PKEY_PARAM_RSA_FACTOR6"
    "PKEY_PARAM_RSA_FACTOR7"
    "PKEY_PARAM_RSA_FACTOR8"
    "PKEY_PARAM_RSA_FACTOR9"
    "PKEY_PARAM_RSA_FACTOR10"
    "PKEY_PARAM_RSA_EXPONENT1"
    "PKEY_PARAM_RSA_EXPONENT2"
    "PKEY_PARAM_RSA_EXPONENT3"
    "PKEY_PARAM_RSA_EXPONENT4"
    "PKEY_PARAM_RSA_EXPONENT5"
    "PKEY_PARAM_RSA_EXPONENT6"
    "PKEY_PARAM_RSA_EXPONENT7"
    "PKEY_PARAM_RSA_EXPONENT8"
    "PKEY_PARAM_RSA_EXPONENT9"
    "PKEY_PARAM_RSA_EXPONENT10"
    "PKEY_PARAM_RSA_COEFFICIENT1"
    "PKEY_PARAM_RSA_COEFFICIENT2"
    "PKEY_PARAM_RSA_COEFFICIENT3"
    "PKEY_PARAM_RSA_COEFFICIENT4"
    "PKEY_PARAM_RSA_COEFFICIENT5"
    "PKEY_PARAM_RSA_COEFFICIENT6"
    "PKEY_PARAM_RSA_COEFFICIENT7"
    "PKEY_PARAM_RSA_COEFFICIENT8"
    "PKEY_PARAM_RSA_COEFFICIENT9"
    "PKEY_PARAM_RSA_BITS"
    "PKEY_PARAM_RSA_PRIMES"
    "PKEY_PARAM_RSA_DIGEST"
    "PKEY_PARAM_RSA_DIGEST_PROPS"
    "PKEY_PARAM_RSA_MASKGENFUNC"
    "PKEY_PARAM_RSA_MGF1_DIGEST"
    "PKEY_PARAM_RSA_PSS_SALTLEN"
    "PKEY_PARAM_DHKEM_IKM"
    "PKEY_PARAM_FFC_TYPE"
    "PKEY_PARAM_FFC_PBITS"
    "PKEY_PARAM_FFC_QBITS"
    "PKEY_PARAM_FFC_DIGEST"
    "PKEY_PARAM_FFC_DIGEST_PROPS"
    "PKEY_PARAM_EC_ENCODING"
    "PKEY_PARAM_EC_POINT_CONVERSION_FORMAT"
    "PKEY_PARAM_EC_GROUP_CHECK_TYPE"
    "PKEY_PARAM_EC_INCLUDE_PUBLIC"
    "EXCHANGE_PARAM_PAD"
    "EXCHANGE_PARAM_EC_ECDH_COFACTOR_MODE"
    "EXCHANGE_PARAM_KDF_TYPE"
    "EXCHANGE_PARAM_KDF_DIGEST"
    "EXCHANGE_PARAM_KDF_DIGEST_PROPS"
    "EXCHANGE_PARAM_KDF_OUTLEN"
    "EXCHANGE_PARAM_KDF_UKM"
    "SIGNATURE_PARAM_ALGORITHM_ID"
    "SIGNATURE_PARAM_PAD_MODE"
    "SIGNATURE_PARAM_DIGEST"
    "SIGNATURE_PARAM_PROPERTIES"
    "SIGNATURE_PARAM_PSS_SALTLEN"
    "SIGNATURE_PARAM_MGF1_DIGEST"
    "SIGNATURE_PARAM_MGF1_PROPERTIES"
    "SIGNATURE_PARAM_DIGEST_SIZE"
    "SIGNATURE_PARAM_NONCE_TYPE"
    "SIGNATURE_PARAM_INSTANCE"
    "SIGNATURE_PARAM_CONTEXT_STRING"
    "ASYM_CIPHER_PARAM_DIGEST"
    "ASYM_CIPHER_PARAM_PROPERTIES"
    "ASYM_CIPHER_PARAM_ENGINE"
    "ASYM_CIPHER_PARAM_PAD_MODE"
    "ASYM_CIPHER_PARAM_MGF1_DIGEST"
    "ASYM_CIPHER_PARAM_MGF1_DIGEST_PROPS"
    "ASYM_CIPHER_PARAM_OAEP_DIGEST"
    "ASYM_CIPHER_PARAM_OAEP_DIGEST_PROPS"
    "ASYM_CIPHER_PARAM_OAEP_LABEL"
    "ASYM_CIPHER_PARAM_TLS_CLIENT_VERSION"
    "ASYM_CIPHER_PARAM_TLS_NEGOTIATED_VERSION"
    "ASYM_CIPHER_PARAM_IMPLICIT_REJECTION"
    "ENCODER_PARAM_CIPHER"
    "ENCODER_PARAM_PROPERTIES"
    "ENCODER_PARAM_ENCRYPT_LEVEL"
    "ENCODER_PARAM_SAVE_PARAMETERS"
    "DECODER_PARAM_PROPERTIES"
    "PASSPHRASE_PARAM_INFO"
    "GEN_PARAM_POTENTIAL"
    "GEN_PARAM_ITERATION"
    "PKEY_PARAM_RSA_TEST_XP1"
    "PKEY_PARAM_RSA_TEST_XP2"
    "PKEY_PARAM_RSA_TEST_XP"
    "PKEY_PARAM_RSA_TEST_XQ1"
    "PKEY_PARAM_RSA_TEST_XQ2"
    "PKEY_PARAM_RSA_TEST_XQ"
    "PKEY_PARAM_RSA_TEST_P1"
    "PKEY_PARAM_RSA_TEST_P2"
    "PKEY_PARAM_RSA_TEST_Q1"
    "PKEY_PARAM_RSA_TEST_Q2"
    "SIGNATURE_PARAM_KAT"
    "KEM_PARAM_OPERATION"
    "KEM_PARAM_IKME"
    "CAPABILITY_TLS_GROUP_NAME"
    "CAPABILITY_TLS_GROUP_NAME_INTERNAL"
    "CAPABILITY_TLS_GROUP_ID"
    "CAPABILITY_TLS_GROUP_ALG"
    "CAPABILITY_TLS_GROUP_SECURITY_BITS"
    "CAPABILITY_TLS_GROUP_IS_KEM"
    "CAPABILITY_TLS_GROUP_MIN_TLS"
    "CAPABILITY_TLS_GROUP_MAX_TLS"
    "CAPABILITY_TLS_GROUP_MIN_DTLS"
    "CAPABILITY_TLS_GROUP_MAX_DTLS"
    "CAPABILITY_TLS_SIGALG_IANA_NAME"
    "CAPABILITY_TLS_SIGALG_CODE_POINT"
    "CAPABILITY_TLS_SIGALG_NAME"
    "CAPABILITY_TLS_SIGALG_OID"
    "CAPABILITY_TLS_SIGALG_SIG_NAME"
    "CAPABILITY_TLS_SIGALG_SIG_OID"
    "CAPABILITY_TLS_SIGALG_HASH_NAME"
    "CAPABILITY_TLS_SIGALG_HASH_OID"
    "CAPABILITY_TLS_SIGALG_KEYTYPE"
    "CAPABILITY_TLS_SIGALG_KEYTYPE_OID"
    "CAPABILITY_TLS_SIGALG_SECURITY_BITS"
    "CAPABILITY_TLS_SIGALG_MIN_TLS"
    "CAPABILITY_TLS_SIGALG_MAX_TLS"
    "STORE_PARAM_EXPECT"
    "STORE_PARAM_SUBJECT"
    "STORE_PARAM_ISSUER"
    "STORE_PARAM_SERIAL"
    "STORE_PARAM_DIGEST"
    "STORE_PARAM_FINGERPRINT"
    "STORE_PARAM_ALIAS"
    "STORE_PARAM_PROPERTIES"
    "STORE_PARAM_INPUT_TYPE"
    "LIBSSL_RECORD_LAYER_PARAM_OPTIONS"
    "LIBSSL_RECORD_LAYER_PARAM_MODE"
    "LIBSSL_RECORD_LAYER_PARAM_READ_AHEAD"
    "LIBSSL_RECORD_LAYER_READ_BUFFER_LEN"
    "LIBSSL_RECORD_LAYER_PARAM_USE_ETM"
    "LIBSSL_RECORD_LAYER_PARAM_STREAM_MAC"
    "LIBSSL_RECORD_LAYER_PARAM_TLSTREE"
    "LIBSSL_RECORD_LAYER_PARAM_MAX_FRAG_LEN"
    "LIBSSL_RECORD_LAYER_PARAM_MAX_EARLY_DATA"
    "LIBSSL_RECORD_LAYER_PARAM_BLOCK_PADDING"
)

# Well known parameter names that core passes to providers
set("PROV_PARAM_CORE_VERSION" "openssl-version")# utf8_ptr
set("PROV_PARAM_CORE_PROV_NAME" "provider-name")  # utf8_ptr
set("PROV_PARAM_CORE_MODULE_FILENAME" "module-filename")# utf8_ptr

# Well known parameter names that Providers can define
set("PROV_PARAM_NAME" "name")               # utf8_ptr
set("PROV_PARAM_VERSION" "version")            # utf8_ptr
set("PROV_PARAM_BUILDINFO" "buildinfo")          # utf8_ptr
set("PROV_PARAM_STATUS" "status")             # uint
set("PROV_PARAM_SECURITY_CHECKS" "security-checks")    # uint
set("PROV_PARAM_TLS1_PRF_EMS_CHECK" "tls1-prf-ems-check") # uint
set("PROV_PARAM_DRBG_TRUNC_DIGEST" "drbg-no-trunc-md")   # uint

# Self test callback parameters
set("PROV_PARAM_SELF_TEST_PHASE" "st-phase")# utf8_string
set("PROV_PARAM_SELF_TEST_TYPE" "st-type") # utf8_string
set("PROV_PARAM_SELF_TEST_DESC" "st-desc") # utf8_string

# Provider-native object abstractions
#
# These are used when a provider wants to pass object data or an object
# reference back to libcrypto.  This is only useful for provider functions
# that take a callback to which an PARAM array with these parameters
# can be passed.
#
# This set of parameter names is explained in detail in provider-object(7)
# (doc/man7/provider-object.pod)

set("OBJECT_PARAM_TYPE" "type")     # INTEGER
set("OBJECT_PARAM_DATA_TYPE" "data-type")# UTF8_STRING
set("OBJECT_PARAM_DATA_STRUCTURE" "data-structure")# UTF8_STRING
set("OBJECT_PARAM_REFERENCE" "reference")# OCTET_STRING
set("OBJECT_PARAM_DATA" "data")# OCTET_STRING or UTF8_STRING
set("OBJECT_PARAM_DESC" "desc")     # UTF8_STRING

# Algorithm parameters
# If "engine",or "properties",are specified, they should always be paired
# with the algorithm type.
# Note these are common names that are shared by many types (such as kdf, mac,
# and pkey) e.g: see MAC_PARAM_DIGEST below.

set("ALG_PARAM_DIGEST" "digest")       # utf8_string
set("ALG_PARAM_CIPHER" "cipher")       # utf8_string
set("ALG_PARAM_ENGINE" "engine")       # utf8_string
set("ALG_PARAM_MAC" "mac")          # utf8_string
set("ALG_PARAM_PROPERTIES" "properties")   # utf8_string

# cipher parameters
set("CIPHER_PARAM_PADDING" "padding")     # uint
set("CIPHER_PARAM_USE_BITS" "use-bits")    # uint
set("CIPHER_PARAM_TLS_VERSION" "tls-version") # uint
set("CIPHER_PARAM_TLS_MAC" "tls-mac")     # octet_ptr
set("CIPHER_PARAM_TLS_MAC_SIZE" "tls-mac-size")# size_t
set("CIPHER_PARAM_MODE" "mode")        # uint
set("CIPHER_PARAM_BLOCK_SIZE" "blocksize")   # size_t
set("CIPHER_PARAM_AEAD" "aead")        # int, 0 or 1
set("CIPHER_PARAM_CUSTOM_IV" "custom-iv")   # int, 0 or 1
set("CIPHER_PARAM_CTS" "cts")         # int, 0 or 1
set("CIPHER_PARAM_TLS1_MULTIBLOCK" "tls-multi")   # int, 0 or 1
set("CIPHER_PARAM_HAS_RAND_KEY" "has-randkey") # int, 0 or 1
set("CIPHER_PARAM_KEYLEN" "keylen")      # size_t
set("CIPHER_PARAM_IVLEN" "ivlen")       # size_t
set("CIPHER_PARAM_IV" "iv")          # octet_string OR octet_ptr
set("CIPHER_PARAM_UPDATED_IV" "updated-iv")  # octet_string OR octet_ptr
set("CIPHER_PARAM_NUM" "num")         # uint
set("CIPHER_PARAM_ROUNDS" "rounds")      # uint
set("CIPHER_PARAM_AEAD_TAG" "tag")         # octet_string
set("CIPHER_PARAM_AEAD_TLS1_AAD" "tlsaad")      # octet_string
set("CIPHER_PARAM_AEAD_TLS1_AAD_PAD" "tlsaadpad")   # size_t
set("CIPHER_PARAM_AEAD_TLS1_IV_FIXED" "tlsivfixed")  # octet_string
set("CIPHER_PARAM_AEAD_TLS1_GET_IV_GEN" "tlsivgen")    # octet_string
set("CIPHER_PARAM_AEAD_TLS1_SET_IV_INV" "tlsivinv")    # octet_string
set("CIPHER_PARAM_AEAD_IVLEN" "*CIPHER_PARAM_IVLEN")
set("CIPHER_PARAM_AEAD_TAGLEN" "taglen")      # size_t
set("CIPHER_PARAM_AEAD_MAC_KEY" "mackey")      # octet_string
set("CIPHER_PARAM_RANDOM_KEY" "randkey")     # octet_string
set("CIPHER_PARAM_RC2_KEYBITS" "keybits")     # size_t
set("CIPHER_PARAM_SPEED" "speed")       # uint
set("CIPHER_PARAM_CTS_MODE" "cts_mode")    # utf8_string
# For passing the AlgorithmIdentifier parameter in DER form
set("CIPHER_PARAM_ALGORITHM_ID_PARAMS" "alg_id_param")# octet_string
set("CIPHER_PARAM_XTS_STANDARD" "xts_standard")# utf8_string

set("CIPHER_PARAM_TLS1_MULTIBLOCK_MAX_SEND_FRAGMENT" "tls1multi_maxsndfrag")# uint
set("CIPHER_PARAM_TLS1_MULTIBLOCK_MAX_BUFSIZE" "tls1multi_maxbufsz")  # size_t
set("CIPHER_PARAM_TLS1_MULTIBLOCK_INTERLEAVE" "tls1multi_interleave")# uint
set("CIPHER_PARAM_TLS1_MULTIBLOCK_AAD" "tls1multi_aad")       # octet_string
set("CIPHER_PARAM_TLS1_MULTIBLOCK_AAD_PACKLEN" "tls1multi_aadpacklen")# uint
set("CIPHER_PARAM_TLS1_MULTIBLOCK_ENC" "tls1multi_enc")       # octet_string
set("CIPHER_PARAM_TLS1_MULTIBLOCK_ENC_IN" "tls1multi_encin")     # octet_string
set("CIPHER_PARAM_TLS1_MULTIBLOCK_ENC_LEN" "tls1multi_enclen")    # size_t

# digest parameters
set("DIGEST_PARAM_XOFLEN" "xoflen")       # size_t
set("DIGEST_PARAM_SSL3_MS" "ssl3-ms")      # octet string
set("DIGEST_PARAM_PAD_TYPE" "pad-type")     # uint
set("DIGEST_PARAM_MICALG" "micalg")       # utf8 string
set("DIGEST_PARAM_BLOCK_SIZE" "blocksize")    # size_t
set("DIGEST_PARAM_SIZE" "size")         # size_t
set("DIGEST_PARAM_XOF" "xof")          # int, 0 or 1
set("DIGEST_PARAM_ALGID_ABSENT" "algid-absent") # int, 0 or 1

# MAC parameters
set("MAC_PARAM_KEY" "key")           # octet string
set("MAC_PARAM_IV" "iv")            # octet string
set("MAC_PARAM_CUSTOM" "custom")        # utf8 string
set("MAC_PARAM_SALT" "salt")          # octet string
set("MAC_PARAM_XOF" "xof")           # int, 0 or 1
set("MAC_PARAM_DIGEST_NOINIT" "digest-noinit") # int, 0 or 1
set("MAC_PARAM_DIGEST_ONESHOT" "digest-oneshot")# int, 0 or 1
set("MAC_PARAM_C_ROUNDS" "c-rounds")      # unsigned int
set("MAC_PARAM_D_ROUNDS" "d-rounds")      # unsigned int

# If "engine",or "properties",are specified, they should always be paired
# with "cipher",or "digest".

set("MAC_PARAM_CIPHER" "*ALG_PARAM_CIPHER")        # utf8 string
set("MAC_PARAM_DIGEST" "*ALG_PARAM_DIGEST")        # utf8 string
set("MAC_PARAM_PROPERTIES" "*ALG_PARAM_PROPERTIES")    # utf8 string
set("MAC_PARAM_SIZE" "size")                     # size_t
set("MAC_PARAM_BLOCK_SIZE" "block-size")               # size_t
set("MAC_PARAM_TLS_DATA_SIZE" "tls-data-size")            # size_t

# KDF / PRF parameters
set("KDF_PARAM_SECRET" "secret")                   # octet string
set("KDF_PARAM_KEY" "key")                      # octet string
set("KDF_PARAM_SALT" "salt")                     # octet string
set("KDF_PARAM_PASSWORD" "pass")                     # octet string
set("KDF_PARAM_PREFIX" "prefix")                   # octet string
set("KDF_PARAM_LABEL" "label")                    # octet string
set("KDF_PARAM_DATA" "data")                     # octet string
set("KDF_PARAM_DIGEST" "*ALG_PARAM_DIGEST")        # utf8 string
set("KDF_PARAM_CIPHER" "*ALG_PARAM_CIPHER")        # utf8 string
set("KDF_PARAM_MAC" "*ALG_PARAM_MAC")           # utf8 string
set("KDF_PARAM_MAC_SIZE" "maclen")                   # size_t
set("KDF_PARAM_PROPERTIES" "*ALG_PARAM_PROPERTIES")    # utf8 string
set("KDF_PARAM_ITER" "iter")                     # unsigned int
set("KDF_PARAM_MODE" "mode")                     # utf8 string or int
set("KDF_PARAM_PKCS5" "pkcs5")                    # int
set("KDF_PARAM_UKM" "ukm")                      # octet string
set("KDF_PARAM_CEK_ALG" "cekalg")                   # utf8 string
set("KDF_PARAM_SCRYPT_N" "n")                        # uint64_t
set("KDF_PARAM_SCRYPT_R" "r")                        # uint32_t
set("KDF_PARAM_SCRYPT_P" "p")                        # uint32_t
set("KDF_PARAM_SCRYPT_MAXMEM" "maxmem_bytes")            # uint64_t
set("KDF_PARAM_INFO" "info")                     # octet string
set("KDF_PARAM_SEED" "seed")                     # octet string
set("KDF_PARAM_SSHKDF_XCGHASH" "xcghash")                # octet string
set("KDF_PARAM_SSHKDF_SESSION_ID" "session_id")          # octet string
set("KDF_PARAM_SSHKDF_TYPE" "type")                     # int
set("KDF_PARAM_SIZE" "size")                     # size_t
set("KDF_PARAM_CONSTANT" "constant")                 # octet string
set("KDF_PARAM_PKCS12_ID" "id")                       # int
set("KDF_PARAM_KBKDF_USE_L" "use-l")            # int
set("KDF_PARAM_KBKDF_USE_SEPARATOR" "use-separator")    # int
set("KDF_PARAM_KBKDF_R" "r")                        # int
set("KDF_PARAM_X942_ACVPINFO" "acvp-info")
set("KDF_PARAM_X942_PARTYUINFO" "partyu-info")
set("KDF_PARAM_X942_PARTYVINFO" "partyv-info")
set("KDF_PARAM_X942_SUPP_PUBINFO" "supp-pubinfo")
set("KDF_PARAM_X942_SUPP_PRIVINFO" "supp-privinfo")
set("KDF_PARAM_X942_USE_KEYBITS" "use-keybits")
set("KDF_PARAM_HMACDRBG_ENTROPY" "entropy")
set("KDF_PARAM_HMACDRBG_NONCE" "nonce")
set("KDF_PARAM_THREADS" "threads")                # uint32_t
set("KDF_PARAM_EARLY_CLEAN" "early_clean")            # uint32_t
set("KDF_PARAM_ARGON2_AD" "ad")                     # octet string
set("KDF_PARAM_ARGON2_LANES" "lanes")                  # uint32_t
set("KDF_PARAM_ARGON2_MEMCOST" "memcost")                # uint32_t
set("KDF_PARAM_ARGON2_VERSION" "version")                # uint32_t

# Known RAND names
set("RAND_PARAM_STATE" "state")
set("RAND_PARAM_STRENGTH" "strength")
set("RAND_PARAM_MAX_REQUEST" "max_request")
set("RAND_PARAM_TEST_ENTROPY" "test_entropy")
set("RAND_PARAM_TEST_NONCE" "test_nonce")
set("RAND_PARAM_GENERATE" "generate")

# RAND/DRBG names
set("DRBG_PARAM_RESEED_REQUESTS" "reseed_requests")
set("DRBG_PARAM_RESEED_TIME_INTERVAL" "reseed_time_interval")
set("DRBG_PARAM_MIN_ENTROPYLEN" "min_entropylen")
set("DRBG_PARAM_MAX_ENTROPYLEN" "max_entropylen")
set("DRBG_PARAM_MIN_NONCELEN" "min_noncelen")
set("DRBG_PARAM_MAX_NONCELEN" "max_noncelen")
set("DRBG_PARAM_MAX_PERSLEN" "max_perslen")
set("DRBG_PARAM_MAX_ADINLEN" "max_adinlen")
set("DRBG_PARAM_RESEED_COUNTER" "reseed_counter")
set("DRBG_PARAM_RESEED_TIME" "reseed_time")
set("DRBG_PARAM_PROPERTIES" "*ALG_PARAM_PROPERTIES")
set("DRBG_PARAM_DIGEST" "*ALG_PARAM_DIGEST")
set("DRBG_PARAM_CIPHER" "*ALG_PARAM_CIPHER")
set("DRBG_PARAM_MAC" "*ALG_PARAM_MAC")
set("DRBG_PARAM_USE_DF" "use_derivation_function")

# DRBG call back parameters
set("DRBG_PARAM_ENTROPY_REQUIRED" "entropy_required")
set("DRBG_PARAM_PREDICTION_RESISTANCE" "prediction_resistance")
set("DRBG_PARAM_MIN_LENGTH" "minium_length")
set("DRBG_PARAM_MAX_LENGTH" "maxium_length")
set("DRBG_PARAM_RANDOM_DATA" "random_data")
set("DRBG_PARAM_SIZE" "size")

# PKEY parameters
# Common PKEY parameters
set("PKEY_PARAM_BITS" "bits")# integer
set("PKEY_PARAM_MAX_SIZE" "max-size")# integer
set("PKEY_PARAM_SECURITY_BITS" "security-bits")# integer
set("PKEY_PARAM_DIGEST" "*ALG_PARAM_DIGEST")
set("PKEY_PARAM_CIPHER" "*ALG_PARAM_CIPHER") # utf8 string
set("PKEY_PARAM_ENGINE" "*ALG_PARAM_ENGINE") # utf8 string
set("PKEY_PARAM_PROPERTIES" "*ALG_PARAM_PROPERTIES")
set("PKEY_PARAM_DEFAULT_DIGEST" "default-digest")# utf8 string
set("PKEY_PARAM_MANDATORY_DIGEST" "mandatory-digest")# utf8 string
set("PKEY_PARAM_PAD_MODE" "pad-mode")
set("PKEY_PARAM_DIGEST_SIZE" "digest-size")
set("PKEY_PARAM_MASKGENFUNC" "mgf")
set("PKEY_PARAM_MGF1_DIGEST" "mgf1-digest")
set("PKEY_PARAM_MGF1_PROPERTIES" "mgf1-properties")
set("PKEY_PARAM_ENCODED_PUBLIC_KEY" "encoded-pub-key")
set("PKEY_PARAM_GROUP_NAME" "group")
set("PKEY_PARAM_DIST_ID" "distid")
set("PKEY_PARAM_PUB_KEY" "pub")
set("PKEY_PARAM_PRIV_KEY" "priv")
set("PKEY_PARAM_IMPLICIT_REJECTION" "implicit-rejection")

# Diffie-Hellman/DSA Parameters
set("PKEY_PARAM_FFC_P" "p")
set("PKEY_PARAM_FFC_G" "g")
set("PKEY_PARAM_FFC_Q" "q")
set("PKEY_PARAM_FFC_GINDEX" "gindex")
set("PKEY_PARAM_FFC_PCOUNTER" "pcounter")
set("PKEY_PARAM_FFC_SEED" "seed")
set("PKEY_PARAM_FFC_COFACTOR" "j")
set("PKEY_PARAM_FFC_H" "hindex")
set("PKEY_PARAM_FFC_VALIDATE_PQ" "validate-pq")
set("PKEY_PARAM_FFC_VALIDATE_G" "validate-g")
set("PKEY_PARAM_FFC_VALIDATE_LEGACY" "validate-legacy")

# Diffie-Hellman params
set("PKEY_PARAM_DH_GENERATOR" "safeprime-generator")
set("PKEY_PARAM_DH_PRIV_LEN" "priv_len")

# Elliptic Curve Domain Parameters
set("PKEY_PARAM_EC_PUB_X" "qx")
set("PKEY_PARAM_EC_PUB_Y" "qy")

# Elliptic Curve Explicit Domain Parameters
set("PKEY_PARAM_EC_FIELD_TYPE" "field-type")
set("PKEY_PARAM_EC_P" "p")
set("PKEY_PARAM_EC_A" "a")
set("PKEY_PARAM_EC_B" "b")
set("PKEY_PARAM_EC_GENERATOR" "generator")
set("PKEY_PARAM_EC_ORDER" "order")
set("PKEY_PARAM_EC_COFACTOR" "cofactor")
set("PKEY_PARAM_EC_SEED" "seed")
set("PKEY_PARAM_EC_CHAR2_M" "m")
set("PKEY_PARAM_EC_CHAR2_TYPE" "basis-type")
set("PKEY_PARAM_EC_CHAR2_TP_BASIS" "tp")
set("PKEY_PARAM_EC_CHAR2_PP_K1" "k1")
set("PKEY_PARAM_EC_CHAR2_PP_K2" "k2")
set("PKEY_PARAM_EC_CHAR2_PP_K3" "k3")
set("PKEY_PARAM_EC_DECODED_FROM_EXPLICIT_PARAMS" "decoded-from-explicit")

# Elliptic Curve Key Parameters
set("PKEY_PARAM_USE_COFACTOR_FLAG" "use-cofactor-flag")
set("PKEY_PARAM_USE_COFACTOR_ECDH" "*PKEY_PARAM_USE_COFACTOR_FLAG")

# RSA Keys
#
# n, e, d are the usual public and private key components
#
# rsa-num is the number of factors, including p and q
# rsa-factor is used for each factor: p, q, r_i (i = 3, ...)
# rsa-exponent is used for each exponent: dP, dQ, d_i (i = 3, ...)
# rsa-coefficient is used for each coefficient: qInv, t_i (i = 3, ...)
#
# The number of rsa-factor items must be equal to the number of rsa-exponent
# items, and the number of rsa-coefficients must be one less.
# (the base i for the coefficients is 2, not 1, at least as implied by
# RFC 8017)

set("PKEY_PARAM_RSA_N" "n")
set("PKEY_PARAM_RSA_E" "e")
set("PKEY_PARAM_RSA_D" "d")
set("PKEY_PARAM_RSA_FACTOR" "rsa-factor")
set("PKEY_PARAM_RSA_EXPONENT" "rsa-exponent")
set("PKEY_PARAM_RSA_COEFFICIENT" "rsa-coefficient")
set("PKEY_PARAM_RSA_FACTOR1" "rsa-factor1")
set("PKEY_PARAM_RSA_FACTOR2" "rsa-factor2")
set("PKEY_PARAM_RSA_FACTOR3" "rsa-factor3")
set("PKEY_PARAM_RSA_FACTOR4" "rsa-factor4")
set("PKEY_PARAM_RSA_FACTOR5" "rsa-factor5")
set("PKEY_PARAM_RSA_FACTOR6" "rsa-factor6")
set("PKEY_PARAM_RSA_FACTOR7" "rsa-factor7")
set("PKEY_PARAM_RSA_FACTOR8" "rsa-factor8")
set("PKEY_PARAM_RSA_FACTOR9" "rsa-factor9")
set("PKEY_PARAM_RSA_FACTOR10" "rsa-factor10")
set("PKEY_PARAM_RSA_EXPONENT1" "rsa-exponent1")
set("PKEY_PARAM_RSA_EXPONENT2" "rsa-exponent2")
set("PKEY_PARAM_RSA_EXPONENT3" "rsa-exponent3")
set("PKEY_PARAM_RSA_EXPONENT4" "rsa-exponent4")
set("PKEY_PARAM_RSA_EXPONENT5" "rsa-exponent5")
set("PKEY_PARAM_RSA_EXPONENT6" "rsa-exponent6")
set("PKEY_PARAM_RSA_EXPONENT7" "rsa-exponent7")
set("PKEY_PARAM_RSA_EXPONENT8" "rsa-exponent8")
set("PKEY_PARAM_RSA_EXPONENT9" "rsa-exponent9")
set("PKEY_PARAM_RSA_EXPONENT10" "rsa-exponent10")
set("PKEY_PARAM_RSA_COEFFICIENT1" "rsa-coefficient1")
set("PKEY_PARAM_RSA_COEFFICIENT2" "rsa-coefficient2")
set("PKEY_PARAM_RSA_COEFFICIENT3" "rsa-coefficient3")
set("PKEY_PARAM_RSA_COEFFICIENT4" "rsa-coefficient4")
set("PKEY_PARAM_RSA_COEFFICIENT5" "rsa-coefficient5")
set("PKEY_PARAM_RSA_COEFFICIENT6" "rsa-coefficient6")
set("PKEY_PARAM_RSA_COEFFICIENT7" "rsa-coefficient7")
set("PKEY_PARAM_RSA_COEFFICIENT8" "rsa-coefficient8")
set("PKEY_PARAM_RSA_COEFFICIENT9" "rsa-coefficient9")

# Key generation parameters
set("PKEY_PARAM_RSA_BITS" "*PKEY_PARAM_BITS")
set("PKEY_PARAM_RSA_PRIMES" "primes")
set("PKEY_PARAM_RSA_DIGEST" "*PKEY_PARAM_DIGEST")
set("PKEY_PARAM_RSA_DIGEST_PROPS" "*PKEY_PARAM_PROPERTIES")
set("PKEY_PARAM_RSA_MASKGENFUNC" "*PKEY_PARAM_MASKGENFUNC")
set("PKEY_PARAM_RSA_MGF1_DIGEST" "*PKEY_PARAM_MGF1_DIGEST")
set("PKEY_PARAM_RSA_PSS_SALTLEN" "saltlen")

# EC, X25519 and X448 Key generation parameters
set("PKEY_PARAM_DHKEM_IKM" "dhkem-ikm")

# Key generation parameters
set("PKEY_PARAM_FFC_TYPE" "type")
set("PKEY_PARAM_FFC_PBITS" "pbits")
set("PKEY_PARAM_FFC_QBITS" "qbits")
set("PKEY_PARAM_FFC_DIGEST" "*PKEY_PARAM_DIGEST")
set("PKEY_PARAM_FFC_DIGEST_PROPS" "*PKEY_PARAM_PROPERTIES")

set("PKEY_PARAM_EC_ENCODING" "encoding")# utf8_string
set("PKEY_PARAM_EC_POINT_CONVERSION_FORMAT" "point-format")
set("PKEY_PARAM_EC_GROUP_CHECK_TYPE" "group-check")
set("PKEY_PARAM_EC_INCLUDE_PUBLIC" "include-public")

# Key Exchange parameters
set("EXCHANGE_PARAM_PAD" "pad")# uint
set("EXCHANGE_PARAM_EC_ECDH_COFACTOR_MODE" "ecdh-cofactor-mode")# int
set("EXCHANGE_PARAM_KDF_TYPE" "kdf-type")# utf8_string
set("EXCHANGE_PARAM_KDF_DIGEST" "kdf-digest")# utf8_string
set("EXCHANGE_PARAM_KDF_DIGEST_PROPS" "kdf-digest-props")# utf8_string
set("EXCHANGE_PARAM_KDF_OUTLEN" "kdf-outlen")# size_t
# The following parameter is an octet_string on set and an octet_ptr on get
set("EXCHANGE_PARAM_KDF_UKM" "kdf-ukm")

# Signature parameters
set("SIGNATURE_PARAM_ALGORITHM_ID" "algorithm-id")
set("SIGNATURE_PARAM_PAD_MODE" "*PKEY_PARAM_PAD_MODE")
set("SIGNATURE_PARAM_DIGEST" "*PKEY_PARAM_DIGEST")
set("SIGNATURE_PARAM_PROPERTIES" "*PKEY_PARAM_PROPERTIES")
set("SIGNATURE_PARAM_PSS_SALTLEN" "saltlen")
set("SIGNATURE_PARAM_MGF1_DIGEST" "*PKEY_PARAM_MGF1_DIGEST")
set("SIGNATURE_PARAM_MGF1_PROPERTIES" "*PKEY_PARAM_MGF1_PROPERTIES")
set("SIGNATURE_PARAM_DIGEST_SIZE" "*PKEY_PARAM_DIGEST_SIZE")
set("SIGNATURE_PARAM_NONCE_TYPE" "nonce-type")
set("SIGNATURE_PARAM_INSTANCE" "instance")
set("SIGNATURE_PARAM_CONTEXT_STRING" "context-string")

# Asym cipher parameters
set("ASYM_CIPHER_PARAM_DIGEST" "*PKEY_PARAM_DIGEST")
set("ASYM_CIPHER_PARAM_PROPERTIES" "*PKEY_PARAM_PROPERTIES")
set("ASYM_CIPHER_PARAM_ENGINE" "*PKEY_PARAM_ENGINE")
set("ASYM_CIPHER_PARAM_PAD_MODE" "*PKEY_PARAM_PAD_MODE")
set("ASYM_CIPHER_PARAM_MGF1_DIGEST" "*PKEY_PARAM_MGF1_DIGEST")
set("ASYM_CIPHER_PARAM_MGF1_DIGEST_PROPS" "*PKEY_PARAM_MGF1_PROPERTIES")
set("ASYM_CIPHER_PARAM_OAEP_DIGEST" "*ALG_PARAM_DIGEST")
set("ASYM_CIPHER_PARAM_OAEP_DIGEST_PROPS" "digest-props")
# The following parameter is an octet_string on set and an octet_ptr on get
set("ASYM_CIPHER_PARAM_OAEP_LABEL" "oaep-label")
set("ASYM_CIPHER_PARAM_TLS_CLIENT_VERSION" "tls-client-version")
set("ASYM_CIPHER_PARAM_TLS_NEGOTIATED_VERSION" "tls-negotiated-version")
set("ASYM_CIPHER_PARAM_IMPLICIT_REJECTION" "implicit-rejection")

# Encoder / decoder parameters

set("ENCODER_PARAM_CIPHER" "*ALG_PARAM_CIPHER")
set("ENCODER_PARAM_PROPERTIES" "*ALG_PARAM_PROPERTIES")
# Currently PVK only, but reusable for others as needed
set("ENCODER_PARAM_ENCRYPT_LEVEL" "encrypt-level")
set("ENCODER_PARAM_SAVE_PARAMETERS" "save-parameters")# integer

set("DECODER_PARAM_PROPERTIES" "*ALG_PARAM_PROPERTIES")

# Passphrase callback parameters
set("PASSPHRASE_PARAM_INFO" "info")

# Keygen callback parameters, from provider to libcrypto
set("GEN_PARAM_POTENTIAL" "potential")# integer
set("GEN_PARAM_ITERATION" "iteration")# integer

# ACVP Test parameters : These should not be used normally
set("PKEY_PARAM_RSA_TEST_XP1" "xp1")
set("PKEY_PARAM_RSA_TEST_XP2" "xp2")
set("PKEY_PARAM_RSA_TEST_XP" "xp")
set("PKEY_PARAM_RSA_TEST_XQ1" "xq1")
set("PKEY_PARAM_RSA_TEST_XQ2" "xq2")
set("PKEY_PARAM_RSA_TEST_XQ" "xq")
set("PKEY_PARAM_RSA_TEST_P1" "p1")
set("PKEY_PARAM_RSA_TEST_P2" "p2")
set("PKEY_PARAM_RSA_TEST_Q1" "q1")
set("PKEY_PARAM_RSA_TEST_Q2" "q2")
set("SIGNATURE_PARAM_KAT" "kat")

# KEM parameters
set("KEM_PARAM_OPERATION" "operation")
set("KEM_PARAM_IKME" "ikme")

# Capabilities

# TLS-GROUP Capability
set("CAPABILITY_TLS_GROUP_NAME" "tls-group-name")
set("CAPABILITY_TLS_GROUP_NAME_INTERNAL" "tls-group-name-internal")
set("CAPABILITY_TLS_GROUP_ID" "tls-group-id")
set("CAPABILITY_TLS_GROUP_ALG" "tls-group-alg")
set("CAPABILITY_TLS_GROUP_SECURITY_BITS" "tls-group-sec-bits")
set("CAPABILITY_TLS_GROUP_IS_KEM" "tls-group-is-kem")
set("CAPABILITY_TLS_GROUP_MIN_TLS" "tls-min-tls")
set("CAPABILITY_TLS_GROUP_MAX_TLS" "tls-max-tls")
set("CAPABILITY_TLS_GROUP_MIN_DTLS" "tls-min-dtls")
set("CAPABILITY_TLS_GROUP_MAX_DTLS" "tls-max-dtls")

# TLS-SIGALG Capability
set("CAPABILITY_TLS_SIGALG_IANA_NAME" "tls-sigalg-iana-name")
set("CAPABILITY_TLS_SIGALG_CODE_POINT" "tls-sigalg-code-point")
set("CAPABILITY_TLS_SIGALG_NAME" "tls-sigalg-name")
set("CAPABILITY_TLS_SIGALG_OID" "tls-sigalg-oid")
set("CAPABILITY_TLS_SIGALG_SIG_NAME" "tls-sigalg-sig-name")
set("CAPABILITY_TLS_SIGALG_SIG_OID" "tls-sigalg-sig-oid")
set("CAPABILITY_TLS_SIGALG_HASH_NAME" "tls-sigalg-hash-name")
set("CAPABILITY_TLS_SIGALG_HASH_OID" "tls-sigalg-hash-oid")
set("CAPABILITY_TLS_SIGALG_KEYTYPE" "tls-sigalg-keytype")
set("CAPABILITY_TLS_SIGALG_KEYTYPE_OID" "tls-sigalg-keytype-oid")
set("CAPABILITY_TLS_SIGALG_SECURITY_BITS" "tls-sigalg-sec-bits")
set("CAPABILITY_TLS_SIGALG_MIN_TLS" "tls-min-tls")
set("CAPABILITY_TLS_SIGALG_MAX_TLS" "tls-max-tls")

# storemgmt parameters


# Used by storemgmt_ctx_set_params():
#
# - STORE_PARAM_EXPECT is an INTEGER, and the value is any of the
#   STORE_INFO numbers.  This is used to set the expected type of
#   object loaded.
#
# - STORE_PARAM_SUBJECT, STORE_PARAM_ISSUER,
#   STORE_PARAM_SERIAL, STORE_PARAM_FINGERPRINT,
#   STORE_PARAM_DIGEST, STORE_PARAM_ALIAS
#   are used as search criteria.
#   (STORE_PARAM_DIGEST is used with STORE_PARAM_FINGERPRINT)

set("STORE_PARAM_EXPECT" "expect")       # INTEGER
set("STORE_PARAM_SUBJECT" "subject")      # DER blob => OCTET_STRING
set("STORE_PARAM_ISSUER" "name")         # DER blob => OCTET_STRING
set("STORE_PARAM_SERIAL" "serial")       # INTEGER
set("STORE_PARAM_DIGEST" "digest")       # UTF8_STRING
set("STORE_PARAM_FINGERPRINT" "fingerprint") # OCTET_STRING
set("STORE_PARAM_ALIAS" "alias")        # UTF8_STRING

# You may want to pass properties for the provider implementation to use
set("STORE_PARAM_PROPERTIES" "properties")   # utf8_string
# DECODER input type if a decoder is used by the store
set("STORE_PARAM_INPUT_TYPE" "input-type")   # UTF8_STRING


# Libssl record layer
set("LIBSSL_RECORD_LAYER_PARAM_OPTIONS" "options")
set("LIBSSL_RECORD_LAYER_PARAM_MODE" "mode")
set("LIBSSL_RECORD_LAYER_PARAM_READ_AHEAD" "read_ahead")
set("LIBSSL_RECORD_LAYER_READ_BUFFER_LEN" "read_buffer_len")
set("LIBSSL_RECORD_LAYER_PARAM_USE_ETM" "use_etm")
set("LIBSSL_RECORD_LAYER_PARAM_STREAM_MAC" "stream_mac")
set("LIBSSL_RECORD_LAYER_PARAM_TLSTREE" "tlstree")
set("LIBSSL_RECORD_LAYER_PARAM_MAX_FRAG_LEN" "max_frag_len")
set("LIBSSL_RECORD_LAYER_PARAM_MAX_EARLY_DATA" "max_early_data")
set("LIBSSL_RECORD_LAYER_PARAM_BLOCK_PADDING" "block_padding")

function(generate_public_macros)
    set(macros)
    foreach (name IN LISTS PARAM_NAMES)
        set(val "${${name}}")
        set(def "# define OSSL_${name} ")
        string(SUBSTRING "${val}" 0 1 val1)
        if (val1 STREQUAL "*")
            string(SUBSTRING "${val}" 1 -1 val2)
            string(APPEND def "OSSL_${val2}")
        else()
            string(APPEND def "\"${val}\"")
        endif()
        list(APPEND macros "${def}")
    endforeach()

    list(SORT macros)
    list(JOIN macros "\n" j)
    set(MACROSRET "${j}" PARENT_SCOPE)
endfunction()

function(generate_internal_macros)
    set(param_names_sorted ${PARAM_NAMES})
    list(SORT param_names_sorted)
    set(count 0)

    foreach (name IN LISTS param_names_sorted)
        set(val "${${name}}")
        string(SUBSTRING "${val}" 0 1 val1)
        if (NOT val1 STREQUAL "*")
            # CMake support hyphen '-' in variable name, but I don't like it...
            # TODO: kill hyphen '-' in variable name afterwards
            if (NOT DEFINED reverse_${val})
                set("reverse_${val}" "${count}")
                math(EXPR count "${count} + 1")
            endif()
        endif()
    endforeach()

    set(macros)
    foreach (name IN LISTS PARAM_NAMES)
        set(val "${${name}}")
        set(def "#define PIDX_${name} ")
        string(SUBSTRING "${val}" 0 1 val1)
        if (val1 STREQUAL "*")
            string(SUBSTRING "${val}" 1 -1 val2)
            string(APPEND def "PIDX_${val2}")
        else()
            string(APPEND def "${reverse_${val}}")
        endif()
        list(APPEND macros "${def}")
    endforeach()

    list(SORT macros)
    list(JOIN macros "\n" j)
    set(MACROSRET "#define NUM_PIDX ${count}\n\n${j}" PARENT_SCOPE)
endfunction()

macro (generate_trie)
    set(generate_trie_param_names_sorted "${PARAM_NAMES}")
    list(REVERSE generate_trie_param_names_sorted)

    foreach (generate_trie_name IN LISTS generate_trie_param_names_sorted)
        set(generate_trie_val "${${generate_trie_name}}")
        if (NOT DEFINED TRIE_VALUE_${generate_trie_val})
            string(SUBSTRING "${generate_trie_val}" 0 1 generate_trie_val_sub1)
            if (NOT generate_trie_val_sub1 STREQUAL "*")
                set("TRIE_VALUE_${generate_trie_val}" "${generate_trie_name}")
                set(generate_trie_val_prefix)
                while (NOT generate_trie_val STREQUAL "")
                    string(SUBSTRING "${generate_trie_val}" 0 1 generate_trie_val_sub1)
                    list(APPEND "TRIE_SUFFICES_${generate_trie_val_prefix}" "${generate_trie_val_sub1}")
                    list(SORT "TRIE_SUFFICES_${generate_trie_val_prefix}")
                    list(REMOVE_DUPLICATES "TRIE_SUFFICES_${generate_trie_val_prefix}")
                    string(APPEND generate_trie_val_prefix "${generate_trie_val_sub1}")
                    string(SUBSTRING "${generate_trie_val}" 1 -1 generate_trie_val)
                    if (NOT DEFINED "TRIE_NUM_${generate_trie_val_prefix}")
                        set("TRIE_NUM_${generate_trie_val_prefix}" 0)
                    endif()
                    math(EXPR "TRIE_NUM_${generate_trie_val_prefix}" "${TRIE_NUM_${generate_trie_val_prefix}} + 1")
                endwhile()
            endif()
        endif()
    endforeach()

    unset(generate_trie_val_sub1)
    unset(generate_trie_val_prefix)
    unset(generate_trie_val)
    unset(generate_trie_name)
    unset(generate_trie_param_names_sorted)

    # The original data have duplicates
    # I didn't find any rule for resolving the duplicates so manually set the value here
    # This seems too unreasonable! but since we are doing things externally we don't like using original Perl based scripts
    # so let it be....
    set(TRIE_VALUE_tls-max-tls "CAPABILITY_TLS_GROUP_MAX_TLS")
    set(TRIE_VALUE_tls-min-tls "CAPABILITY_TLS_GROUP_MIN_TLS")
    set(TRIE_VALUE_saltlen "SIGNATURE_PARAM_PSS_SALTLEN")
    set(TRIE_VALUE_seed "KDF_PARAM_SEED")
    set(TRIE_VALUE_p "KDF_PARAM_SCRYPT_P")
    set(TRIE_VALUE_implicit-rejection "PKEY_PARAM_IMPLICIT_REJECTION")
    set(TRIE_VALUE_size "DRBG_PARAM_SIZE")
    set(TRIE_VALUE_type "PKEY_PARAM_FFC_TYPE")
    set(TRIE_VALUE_info "PASSPHRASE_PARAM_INFO")
    set(TRIE_VALUE_r "KDF_PARAM_SCRYPT_R")
    set(TRIE_VALUE_n "KDF_PARAM_SCRYPT_N")
    set(TRIE_VALUE_mode "LIBSSL_RECORD_LAYER_PARAM_MODE")
    set(TRIE_VALUE_salt "KDF_PARAM_SALT")
    set(TRIE_VALUE_key "KDF_PARAM_KEY")
    set(TRIE_VALUE_xof "MAC_PARAM_XOF")
    set(TRIE_VALUE_iv "CIPHER_PARAM_IV")
    set(TRIE_VALUE_blocksize "CIPHER_PARAM_BLOCK_SIZE")
    set(TRIE_VALUE_properties "STORE_PARAM_PROPERTIES")
    set(TRIE_VALUE_digest "ALG_PARAM_DIGEST")
    set(TRIE_VALUE_data "KDF_PARAM_DATA")
    set(TRIE_VALUE_version "KDF_PARAM_ARGON2_VERSION")
    set(TRIE_VALUE_name "PROV_PARAM_NAME")
endmacro()

function (locate_long_endings prefix)
    # need to deal with CMake function recurrsion.
    # Since this is function scope and global variable is not accessable, so we'd use PARENT_SCOPE to pass values
    # but PARENT_SCOPE only preserve one layer of function call, so we'd manually use set with PARENT_SCOPE in a loop
    if (prefix STREQUAL "")
        unset(TRIE_UNIQUE_SUFFICES)
    endif()

    if ( ( NOT ( prefix STREQUAL "" ) ) AND ( TRIE_NUM_${prefix} EQUAL 1 ) )
        # This case!
        # find the corresponding value for this prefix
        # remove variables whose name starts with TRIE_SUFFICES_${prefix} and TRIE_NUM_${prefix}
        # set variable TRIE_UNIQUE_SUFFIX_${prefix} to the whole suffix
        set(suffix)
        set(prefix1 "${prefix}")
        while (NOT DEFINED "TRIE_VALUE_${prefix1}")
            list(LENGTH "TRIE_SUFFICES_${prefix1}" lensuf)
            if (NOT lensuf EQUAL 1)
                message(FATAL_ERROR "WTF lensuf ${lensuf} ${prefix1}")
            endif()
            list(GET "TRIE_SUFFICES_${prefix1}" 0 suffix1)
            unset("TRIE_NUM_${prefix1}")
            unset("TRIE_SUFFICES_${prefix1}")
            string(APPEND suffix ${suffix1})
            string(APPEND prefix1 ${suffix1})
            if (NOT TRIE_NUM_${prefix1} EQUAL 1)
                message(FATAL_ERROR "WTF TRIE_NUM_prefix1 ${TRIE_NUM_${prefix1}} ${prefix1}")
            endif()
        endwhile()
        unset("TRIE_NUM_${prefix1}")
        unset("TRIE_SUFFICES_${prefix1}")
        set("TRIE_UNIQUE_SUFFIX_${prefix}" "${suffix}" PARENT_SCOPE)
        list(APPEND TRIE_UNIQUE_SUFFICES "${prefix}")
    else()
        foreach (A IN LISTS TRIE_SUFFICES_${prefix})
            locate_long_endings("${prefix}${A}")
        endforeach()
        foreach (A IN LISTS TRIE_UNIQUE_SUFFICES)
            set("TRIE_UNIQUE_SUFFIX_${A}" "${TRIE_UNIQUE_SUFFIX_${A}}" PARENT_SCOPE)
        endforeach()
    endif()
    set(TRIE_UNIQUE_SUFFICES "${TRIE_UNIQUE_SUFFICES}" PARENT_SCOPE)
endfunction()

function (generate_code_from_trie prefix)
    string(LENGTH "${prefix}" PREFIXLEN)
    set(indentsingle "    ")
    math(EXPR indentlvl "${PREFIXLEN} + 1")
    string(REPEAT "${indentsingle}" "${indentlvl}" indent)
    math(EXPR indentlvl1 "${indentlvl} + 1")
    string(REPEAT "${indentsingle}" "${indentlvl1}" indent1)
    set(OUTPUTSTR)

    if ( ( DEFINED TRIE_UNIQUE_SUFFIX_${prefix} ) AND ( NOT ( DEFINED TRIE_VALUE_${prefix} ) ) )
        set(OUTPUTSTR "${indent}if (strcmp(\"${TRIE_UNIQUE_SUFFIX_${prefix}}\", s + ${PREFIXLEN}) == 0)
${indent1}return PIDX_${TRIE_VALUE_${prefix}${TRIE_UNIQUE_SUFFIX_${prefix}}};")
    else()
        set(OUTPUTSTR "${indent}switch(s[${PREFIXLEN}]) {
${indent}default:")
        if (DEFINED TRIE_SUFFICES_${prefix})
            foreach (s IN LISTS TRIE_SUFFICES_${prefix})
                string(APPEND OUTPUTSTR "
${indent1}break;
${indent}case '${s}':")
                set(prefix2 "${prefix}${s}")
                generate_code_from_trie("${prefix2}")
                string(APPEND OUTPUTSTR "
${GENERATE_CODE_FROM_TRIE_RESULT_${prefix2}}")
            endforeach()
        endif()
        if (DEFINED TRIE_VALUE_${prefix})
            string(APPEND OUTPUTSTR "
${indent1}break;
${indent}case '\\\\0':
${indent1}return PIDX_${TRIE_VALUE_${prefix}};")
        endif()
        string(APPEND OUTPUTSTR "
${indent}}")
    endif()
    set("GENERATE_CODE_FROM_TRIE_RESULT_${prefix}" "${OUTPUTSTR}" PARENT_SCOPE)
endfunction()

function (produce_decoder)
    generate_trie()
    locate_long_endings("")
    generate_code_from_trie("")
    set(MACROSRET "
int ossl_param_find_pidx(const char *s)
{
${GENERATE_CODE_FROM_TRIE_RESULT_}
    return -1;
}
" PARENT_SCOPE)
endfunction()

set(START_ARGN)
foreach (I RANGE ${CMAKE_ARGC})
    if (CMAKE_ARGV${I} STREQUAL "-P")
        math(EXPR START_ARGN "${I} + 2")
        break()
    endif()
endforeach()

# This is my original thought
# file(STRINGS ${CMAKE_ARGV${START_ARGN}} FILECONTENTS)
# but it fails to parse the file with backslash appears just before end-of-line, it removes the end-of-line completely

# start of a HUGE workaround about CMake `file(STRINGS)` kills backslash before end-of-line with end-of-line
# the backslash - end-of-line combination is what we should preserve!

# warning: following workaround does not support CR-only EOL.

# Read the whole file as hexadecimal
file(READ ${CMAKE_ARGV${START_ARGN}} FILECONTENTSHEX HEX)

# Searching for "\n" (0x0a) byte by byte for line breaks
#
# I didn't found a string split function in current CMake so implement following on our own.
#
# Normally one byte is two hexadecimal number, so the place of "0a" should always be an even number.
# Place of "0a" being an even number is guaranteed for pure-ASCII since ASCII only use 01~7f where the higher bit is always less than 8. Nothing like "b0a1" exists.
# This case is the lucky case.
#
# But things will go wrong if multibyte character is playing a part, resulting something like "b0a1" exists in the HEX, causing the result is an odd number.
# This is the unlucky case where we must find the next "0a" starts on end of this "0a" and is an odd number, and concatenate the strings altogether for this line.
# Temporarily treat this as an error (implemention is complex). It seems like no multibyte character is in the header file of OpenSSL.
#
# Also we remove trailing CR since some OSes (especially Windows) use CRLF EOL for text files
# This is necessary since trailing CR will be used as escape character in logic below this part

set(FILECONTENTS)
set(FILEFOUND)
string(FIND ${FILECONTENTSHEX} "0a" FILEFOUND)
while (NOT FILEFOUND EQUAL -1)
    set(SINGLELINE)
    math(EXPR FILEFOUNDMOD2 "${FILEFOUND} % 2")
    if (FILEFOUNDMOD2 EQUAL 0)
        # the lucky case
        # kill "\r"
        set(SUBSTRINGEND "${FILEFOUND}")
        if (NOT FILEFOUND EQUAL 0)
            math(EXPR FILEFOUNDMINUS2 "${FILEFOUND} - 2")
            string(SUBSTRING "${FILECONTENTSHEX}" "${FILEFOUNDMINUS2}" 2 SINGLELINELAST2)
            if (SINGLELINELAST2 STREQUAL "0d")
                set(SUBSTRINGEND "${FILEFOUNDMINUS2}")
            endif()
        endif()
        string(SUBSTRING "${FILECONTENTSHEX}" 0 "${SUBSTRINGEND}" SINGLELINE)
        list(APPEND FILECONTENTS "${SINGLELINE}")
        math(EXPR FILEFOUNDPLUS2 "${FILEFOUND} + 2")
        string(SUBSTRING "${FILECONTENTSHEX}" "${FILEFOUNDPLUS2}" -1 REMAINDER)
        set(FILECONTENTSHEX "${REMAINDER}")
    else()
        # TODO: the unlucky case
        message(FATAL_ERROR "not implemented for now")
    endif()
    string(FIND "${FILECONTENTSHEX}" "0a" FILEFOUND)
endwhile()
# also deal with file without EOL on EOF
string(LENGTH "${FILECONTENTSHEX}" FILEFOUND)
if (NOT FILEFOUND EQUAL 0)
    set(SUBSTRINGEND "${FILEFOUND}")
    math(EXPR FILEFOUNDMINUS2 "${FILEFOUND} - 2")
    string(SUBSTRING "${FILECONTENTSHEX}" "${FILEFOUNDMINUS2}" 2 SINGLELINELAST2)
    if (SINGLELINELAST2 STREQUAL "0d")
        set(SUBSTRINGEND "${FILEFOUNDMINUS2}")
    endif()
    string(SUBSTRING "${FILECONTENTSHEX}" 0 "${SUBSTRINGEND}" SINGLELINE)
    list(APPEND FILECONTENTS "${SINGLELINE}")
endif()

# Convert back hexadecimal ASCII to original string, but...
# string(ASCII) receives decimal parameter. If the number is not converted the result is a wrong.
# e.g. "e" becomes "A" without conversion. ASCII of "e" is 65 in hexadecimal, which is "A" in decimal
#
# After the string is converted to original string we can list them up, but...
# The original header file may contain backslash before any arbitrary end-of-line, where the backslash is placed in end-of-string by above logic.
# list(JOIN) joins the end-of-string backslash and CMake list separator ";" WHICH MAKES THE LIST SEPARATOR ESCAPED!!!
# To workaround this, we should escape the end-of-string backslash. Since we removed end-of-string CR in above logic we can use CR as escape character for end-of-string backslash.

set(FILECONTENTSASCII)
foreach (I IN LISTS FILECONTENTS)
    set(I_SPLITTED)
    # Convert the hexadecimal I to decimal and make a list for it, to satisfy string(ASCII)
    string(LENGTH "${I}" I_LENGTH)
    set(I_SUBSTRING_REMAINDER "${I}")
    while(NOT I_LENGTH EQUAL 0)
        string(SUBSTRING "${I_SUBSTRING_REMAINDER}" 0 2 I_SUBSTRING_2)
        math(EXPR I_SUBSTRING_2_DEC "0x${I_SUBSTRING_2}" OUTPUT_FORMAT DECIMAL)
        list(APPEND I_SPLITTED "${I_SUBSTRING_2_DEC}")
        string(SUBSTRING "${I_SUBSTRING_REMAINDER}" 2 -1 I_SUBSTRING_REMAINDER_2)
        set(I_SUBSTRING_REMAINDER "${I_SUBSTRING_REMAINDER_2}")
        string(LENGTH "${I_SUBSTRING_REMAINDER}" I_LENGTH)
    endwhile()
    set(I_ASCII)
    list(LENGTH I_SPLITTED I_SPLITTED_LEN)
    if (NOT I_SPLITTED_LEN EQUAL 0)
        string(ASCII ${I_SPLITTED} I_ASCII)
    endif()
    # escape end-of-string backslash by replacing it with CR. End-of-string backslash will escape the CMake list separator when used alongwith list(APPEND)
    string(REGEX REPLACE "\\\\$" "\r" I_ASCII_ESCAPED_1 "${I_ASCII}")
    # escape ";", satisify CMake list
    string(REPLACE ";" "\;" I_ASCII_ESCAPED_2 "${I_ASCII_ESCAPED_1}")
    list(APPEND FILECONTENTSASCII "${I_ASCII_ESCAPED_2}")
endforeach()

# Here is the middle of the workaround - the file is loaded as FILECONTENTSASCII with end-of-string backslash replaced by CR

function(kill_code_quote inputstr outvar)
    set(result "${inputstr}")
    string(LENGTH "${inputstr}" inputlen)
    if (inputlen LESS 2)
        message(FATAL_ERROR "Length of ${inputstr} is less than 2")
    endif()
    math(EXPR inputlenminus1 "${inputlen} - 1")
    math(EXPR inputlenminus2 "${inputlen} - 2")
    string(SUBSTRING "${inputstr}" 0 1 inputstrhead)
    string(SUBSTRING "${inputstr}" ${inputlenminus1} 1 inputstrtail)
    if (inputstrhead STREQUAL "\"" AND inputstrtail STREQUAL "\"")
        string(SUBSTRING "${inputstr}" 1 ${inputlenminus2} result)
    endif()
    set(${outvar} "${result}" PARENT_SCOPE)
endfunction()

set(OUTPUT_CONTENTS)

set(FUNCPROCESSING false)
foreach (I IN LISTS FILECONTENTSASCII)
    string(STRIP "${I}" INPUTLINE)
    set(OUTPUTLINE)
    if (NOT FUNCPROCESSING)
        if (INPUTLINE STREQUAL "{-")
            set(FUNCPROCESSING true)
        else()
            string(FIND "${INPUTLINE}" "{-" INPUTLINE_CONTAINS_LEFTBRACKET_HYPHEN)
            string(FIND "${INPUTLINE}" "-}" INPUTLINE_CONTAINS_HYPHEN_RIGHTBRACKET)
            if ( ( NOT ( INPUTLINE_CONTAINS_LEFTBRACKET_HYPHEN EQUAL -1 ) ) AND ( NOT ( INPUTLINE_CONTAINS_HYPHEN_RIGHTBRACKET EQUAL -1 ) ) )
                if (INPUTLINE MATCHES "produce_decoder\\(\\)")
                    produce_decoder()
                elseif (INPUTLINE MATCHES "generate_internal_macros\\(\\)")
                    generate_internal_macros()
                elseif (INPUTLINE MATCHES "generate_public_macros\\(\\)")
                    generate_public_macros()
                else()
                    # message(WARNING "unmatched line in Perl code part: \"${INPUTLINE}\". ignored.")
                endif()
                string(REGEX REPLACE "{-.*-}" "${MACROSRET}" OUTPUTLINE "${INPUTLINE}")
            else()
                set(OUTPUTLINE "${I}")
            endif()
        endif()
    else()
        if (INPUTLINE STREQUAL "-}")
            set(FUNCPROCESSING false)
        else()
            set(MACROSRET)
            # We do a regex match / search in the code line.
            # There should only be 6 function calls.

            string(LENGTH "${INPUTLINE}" INPUTLINELEN)
            if (INPUTLINELEN EQUAL 0)
                # empty line
            elseif (INPUTLINE MATCHES "use OpenSSL::paramnames")
                # ignored
            else()
                message(WARNING "unmatched line in Perl code part: \"${INPUTLINE}\". ignored.")
            endif()
            set(OUTPUTLINE "${MACROSRET}")
        endif()
    endif()

    if (OUTPUTLINE STREQUAL I)
        # Here is the end of workaround - replace end-of-string CR back to backslash if the output is not modified.
        string(REGEX REPLACE "\r$" "\\\\" OUTPUTLINE_UNESCAPE_1 "${OUTPUTLINE}")
        set(OUTPUTLINE "${OUTPUTLINE_UNESCAPE_1}")
    endif()

    string(APPEND OUTPUT_CONTENTS "${OUTPUTLINE}" "\n")
endforeach()

if (DEFINED OUTPUT_FILE_NAME)
    string(REPLACE "\;" ";" OUTPUT_FILE_CONTENTS "${OUTPUT_CONTENTS}")
    file(WRITE ${OUTPUT_FILE_NAME} "${OUTPUT_FILE_CONTENTS}")
else()
    message(NOTICE "${OUTPUT_CONTENTS}")
endif()
