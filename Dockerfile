FROM registry:2

MAINTAINER Taylor Silenzio <tsilenzio@gmail.com>

RUN mkdir /certs/ \
    # Generate RSA
    && openssl genrsa -des3 -passout pass:x -out /certs/pass 2048 \
    && openssl rsa -passin pass:x -in /certs/pass -out /certs/domain.key \
    && rm /certs/pass \
    # Genetate CSR
    && openssl req -new -key /certs/domain.key -out /certs/domain.csr -subj "/CN=*.tsilenz.io/" \
    # Genetate Certificate
    && openssl x509 -req -days 1024 -in /certs/domain.csr -signkey /certs/domain.key -out /certs/domain.crt