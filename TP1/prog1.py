import fonctions as f

a = int(input("Veuillez entrer le premier nombre (entier) : "))
b = int(input("Veuillez entrer le second nombre (entier) : "))

res = f.puissance(a, b)

print(f"{a} élevé à la puissance {b} est {res}.")
