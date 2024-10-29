#!/usr/bin/env python

from sys import argv
from secrets import token_hex
from hashlib import sha256

salt = token_hex(32)
password = argv[1]
salt_hash = bytes.fromhex(salt)

print(f"salt={salt}")
print(f"password={sha256(password.encode() + salt_hash.hex().upper().encode()).hexdigest()}")


