#!/bin/bash

# Generate a 32-byte salt in hexadecimal format
#salt=$(openssl rand -hex 32)
password="guacadmin"
salt="41cb47edf01d572b4b933c74f3f7123f7b0d1409e0e13e15c9e98576725d8186"

# Compute the SHA-256 hash of the password with the salt
hashed_password=$(echo -n "${password}${salt^^}" | sha256sum | awk '{print $1}')

# Output the salt and hashed password
echo "Salt: $salt"
echo "Password: $hashed_password"