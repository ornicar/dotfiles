## localhost ssl cert

https://medium.com/@eng.fadishaar/step-by-step-guide-configuring-nginx-with-https-on-localhost-for-secure-web-application-testing-c78febc26c78

```sh
take ~/localhost-ssl/l.org
# passphrase: local
openssl genrsa -des3 -out rootCA.key 2048
# ignore all questions
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 7300 -out rootCert.pem
openssl genrsa -out cert.key 2048
# ignore all questions
openssl req -new -key cert.key -out cert.csr
v openssl.cnf
```

```
# Extensions to add to a certificate request
basicConstraints       = CA:FALSE
authorityKeyIdentifier = keyid:always, issuer:always
keyUsage               = nonRepudiation, digitalSignature, keyEncipherment, dataEncipherment
subjectAltName         = @alt_names
[ alt_names ]
DNS.1 = l.org
```

```sh
openssl x509 -req -in cert.csr -CA rootCert.pem -CAkey rootCA.key -CAcreateserial -out cert.crt -days 7300 -sha256 -extfile openssl.cnf
openssl verify -CAfile rootCert.pem -verify_hostname l.org cert.crt
```

chrome://settings/certificates
Authorities
Import rootCert.pem
trust for identifying websites

```sh
sudo ln -s /home/thib/localhost-ssl/l.org/cert.crt /etc/ssl/certs/l.org.crt
sudo ln -s /home/thib/localhost-ssl/l.org/cert.key /etc/ssl/private/l.org.key
```

nginx.conf

```

    server {
      server_name localhost;
      listen 443 ssl;
      ssl_certificate /etc/ssl/certs/cert.crt;
      ssl_certificate_key /etc/ssl/private/cert.key;
    }
```

then same for socket.l.org
