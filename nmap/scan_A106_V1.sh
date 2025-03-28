#!/bin/bash

# Vérifier si nmap est installé
if ! command -v nmap &> /dev/null
then
    echo "nmap n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Identifier l'interface réseau active
# l'option -F de awk sert à spécifier le séparateur de champs. Dans cet exemple, ': ' est utilisé pour séparer le champ au niveau de l'interface réseau.
# l'option -v de grep sert à inverser la correspondance. Dans cet exemple, elle permet de filtrer (exclure) la ligne contenant "lo" (l'interface de loopback).
INTERFACE=$(ip -o link show | awk -F': ' '{print $2}' | grep -v "lo" | head -n 1)

# Vérifier si l'interface a été détectée
if [ -z "$INTERFACE" ]; then
    echo "Impossible de détecter l'interface réseau active. Veuillez vérifier votre connexion."
    exit 1
fi

# Détecter l'IP locale et le masque de sous-réseau de l'interface active

LOCAL_IP=$(ip -o -4 addr show dev $INTERFACE | awk '{print $4}' | cut -d/ -f1)
NETMASK=$(ip -o -4 addr show dev $INTERFACE | awk '{print $4}' | cut -d/ -f2)

# Vérifier si l'IP locale a été détectée
if [ -z "$LOCAL_IP" ]; then
    echo "Impossible de détecter l'adresse IP locale."
    exit 1
fi

# Forcer le masque de sous-réseau à /24
NETWORK=$(echo "$LOCAL_IP" | cut -d. -f1-3).0/24

# Afficher l'adresse IP et le réseau détecté
echo "Interface détectée : $INTERFACE"
echo "IP locale : $LOCAL_IP"
echo "Réseau local : $NETWORK"

# Fichier de sortie
OUTPUT_FILE="scan-result_1.csv"

# Écrire l'en-tête dans le fichier CSV
echo "# - IP - TCP ports" > $OUTPUT_FILE

# Étape 1 : Scanner le réseau pour détecter les IPs avec des ports ouverts (ports principaux)
# Limiter à une petite gamme de ports (par exemple, 22, 80, 443, 8080)
IP_ADDRESSES=$(nmap -p 22,80,443,8080 --open -sT "$NETWORK" -oG - | grep "open" | awk '{print $2}')

# Vérifier si des IPs ont été détectées
if [ -z "$IP_ADDRESSES" ]; then
    echo "Aucune IP avec des ports ouverts n'a été trouvée."
    exit 1
fi

# Étape 2 : Pour chaque IP détectée, compter les ports ouverts parmi les ports spécifiés
for IP in $IP_ADDRESSES; do
    # Vérifier si l'IP est valide avant de lancer le scan
    if [[ ! "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "L'adresse IP $IP n'est pas valide, elle sera ignorée."
        continue
    fi
    
    # Compter le nombre de ports ouverts pour cette IP
    OPEN_PORTS=$(nmap -p 22,80,443,8080 --open -sT "$IP" | grep -c "open")
    
    # Ajouter l'IP et le nombre de ports ouverts dans le fichier CSV
    echo "$IP;$OPEN_PORTS" >> $OUTPUT_FILE
done

echo "Scan terminé. Les résultats sont enregistrés dans $OUTPUT_FILE"
