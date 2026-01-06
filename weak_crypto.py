import hashlib

def hash_password(password):
    return hashlib.md5(password.encode()).hexdigest()

def legacy_hash(data):
    return hashlib.sha1(data.encode()).hexdigest()
