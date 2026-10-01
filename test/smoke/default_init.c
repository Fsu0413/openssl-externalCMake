/* SPDX-License-Identifier: Unlicense */
#include <stdio.h>
#include <openssl/err.h>
#include <openssl/evp.h>
#include <openssl/pem.h>
#include <openssl/rand.h>
#include <openssl/ssl.h>
#include <openssl/x509_vfy.h>

static X509 *read_cert(const char *path)
{
    BIO *bio = BIO_new_file(path, "r");
    X509 *cert = bio != NULL ? PEM_read_bio_X509(bio, NULL, NULL, NULL) : NULL;
    BIO_free(bio);
    return cert;
}

int main(int argc, char **argv)
{
    unsigned char random[32];
    SSL_CTX *tls = NULL;
    X509 *root = NULL, *leaf = NULL;
    X509_STORE *store = NULL;
    X509_STORE_CTX *verify = NULL;
    int result = 1;
    if (argc != 3)
        return 2;
    if (RAND_bytes(random, sizeof(random)) != 1) {
        fprintf(stderr, "RAND_bytes failed\n");
        goto out;
    }
    if ((tls = SSL_CTX_new(TLS_client_method())) == NULL) {
        fprintf(stderr, "SSL_CTX_new failed\n");
        goto out;
    }
    if (EVP_get_digestbyname("SHA256") == NULL
        || EVP_get_cipherbyname("AES-256-CBC") == NULL) {
        fprintf(stderr, "Digest/cipher name registration failed\n");
        goto out;
    }
    root = read_cert(argv[1]);
    leaf = read_cert(argv[2]);
    store = X509_STORE_new();
    verify = X509_STORE_CTX_new();
    if (root == NULL || leaf == NULL || store == NULL || verify == NULL
        || X509_STORE_add_cert(store, root) != 1
        || X509_STORE_CTX_init(verify, store, leaf, NULL) != 1)
        goto out;
    /* Match the security checks performed by direct TLS clients. */
    X509_VERIFY_PARAM_set_auth_level(X509_STORE_CTX_get0_param(verify), 2);
    if (X509_verify_cert(verify) != 1) {
        fprintf(stderr, "Certificate verification failed: %s\n",
            X509_verify_cert_error_string(X509_STORE_CTX_get_error(verify)));
        goto out;
    }
    puts("Random bytes, TLS context, algorithm names, and certificate verification passed");
    result = 0;
out:
    if (result != 0)
        ERR_print_errors_fp(stderr);
    X509_STORE_CTX_free(verify);
    X509_STORE_free(store);
    X509_free(leaf);
    X509_free(root);
    SSL_CTX_free(tls);
    return result;
}
