def puissance(a, b):
    if not (type(a) is int and type(b) is int):
        raise TypeError("Only integers are allowed")
    
    result = 1

    for _ in range(b):
        result *= a
    
    return result

