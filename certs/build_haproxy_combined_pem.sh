#!/bin/bash

# script to create a combined PEM format cert file for HAProxy

# replace cert names as necessary
HACERT=./selfsigned.pem
HACERTKEY=./selfsigned.key
#CAINTCERT=./ca.int.cert.pem
#CACERT=./ca.cert.pem
HADHPARAM=./dhparam
HAOUTPUTPEM=./selfsigned_combined.pem

# generate dhparam prime number to append to PEM for EC crypto
# reference https://wiki.mozilla.org/Security/Server_Side_TLS#DHE_handshake_and_dhparam
# NOTE: 2048 bit dhparam will break for older clients including JAVA 6
# NOTE: use 1024 if you need compatibility with legacy clients
openssl dhparam 2048 > $HADHPARAM

# create the combined PEM file 
# cert+privkey+intermediate+dhparam
echo
echo "building combined PEM file "$HAOUTPUTPEM
echo
echo "combinining the following files...."
echo "certificate file="$HACERT
echo "certificate key file="$HACERTKEY
echo "CA intermediate certificate file="$CAINTCERT
echo "CA certificate file="$CACERT
echo "DH Parameter file="$HADHPARAM
echo
cat $HACERT $HACERTKEY $CAINTCERT $CACERT $HADHPARAM > $HAOUTPUTPEM

# set permissions to protect key
chmod 400 $HAOUTPUTPEM $HACERTKEY

# clean up
rm $HADHPARAM

echo "DONE"
