#!/bin/bash

# ref: https://kura.io/2014/07/02/haproxy-ocsp-stapling/

# update OCSP data for *.foo.com cert
# the details will vary for different CAs
#openssl ocsp -noverify -issuer /etc/haproxy/certs/your_ca.crt -cert /etc/haproxy/certs/your_server.crt -url http://ocsp.exampleca.com -respout /etc/haproxy/certs/your_server.crt..ocsp

# UNCOMMENT line below only if cert is in use by haproxy
# echo "set ssl ocsp-response $(/usr/bin/base64 -w 10000 /etc/haproxy/certs/your_server.crt.ocsp)" | socat stdio /var/lib/haproxy/stats
