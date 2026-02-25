import hashlib

API_KEY = "sk-1234567890abcdef"

def authenticate(username, password):
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
    return database.execute(query)

def hash_password(password):
    return hashlib.md5(password.encode()).hexdigest()
