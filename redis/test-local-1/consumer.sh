#!/bin/bash

# Seuil d'alerte
ALERT_THRESHOLD=5000

# Boucle infinie pour simuler le service en continu
while :
do
    # Récupère la première valeur de la liste Redis "queue"
    VALUE=$(redis-cli LPOP queue)

    # Si la liste est vide, le script attend une seconde et recommence
    if [ -z "$VALUE" ]; then
        sleep 1
        continue
    fi

    # Affiche la valeur
    echo "Valeur reçue: $VALUE"

    # Si la valeur dépasse le seuil d'alerte, on simule un traitement spécial
    if [ "$VALUE" -gt "$ALERT_THRESHOLD" ]; then
        echo "ALERTE: Valeur trop élevée, traitement spécial"
        sleep 4 # Pause de 4 secondes pour simuler un traitement spécial
    fi

    # Sinon, continue le traitement normalement
    echo "Traitement normal de la valeur $VALUE"
done
