#!/bin/bash

openssl req -x509 -newkey rsa:2048 -nodes -sha256 -keyout selfsigned.key -out selfsigned.pem -days 365 -subj "/CN=$HOSTNAME"

