def login(username, password):
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
    return execute_query(query)
    
def search(term):
    sql = "SELECT * FROM products WHERE name=" + term
    return db.query(sql)
