
# There is some uncommon method of generating targets.
# A script reads and writes the same file at same time.

# Let's temporarily ignore the generation of this file and use the file bundled in the git repository
# Note: MSVC builds always use the pre-generated one

get_filename_component(LIBCRYPTO_CURRENTDIR ${CMAKE_CURRENT_LIST_FILE} NAME_WE)

set(LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/o_names.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_dat.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_lib.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_err.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_xref.c
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/objects.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_mac.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_dat.h
    ${CMAKE_SOURCE_DIR}/openssl/crypto/objects/obj_xref.h
)

set(LIBCRYPTO_SOURCES ${LIBCRYPTO_SOURCES} ${LIBCRYPTO_${LIBCRYPTO_CURRENTDIR}_SOURCES})
unset(LIBCRYPTO_CURRENTDIR)
