import hashlib

def pass_to_hash(password):
    return hashlib.sha512(str.encode(password)).hexdigest().upper()