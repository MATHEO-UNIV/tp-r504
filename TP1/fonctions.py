def puissance(a, b):
    if not (type(a) is int and type(b) is int):
        raise TypeError("Seuls les nombres entiers sont autorisés")
    
    if b == 0:
        return 1  # a^0 = 1 for any a
    
    if a == 0 and b < 0:
        raise ValueError("0 ne peut être élevé à une puissance négative")
    
    result = 1
    positive_b = abs(b)

    for _ in range(positive_b):
        result *= a
    
    if b < 0:
        return 1 / result
    else:
        return result


