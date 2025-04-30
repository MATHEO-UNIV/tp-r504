#!/bin/bash

# Paramètres
REDIS_QUEUE="message_queue"
BURST_SIZE=1000
PAUSE_BETWEEN_BURSTS=3

# Fonction pour envoyer des valeurs à Redis
send_values_to_redis() {
    for i in $(seq 1 $BURST_SIZE); do
        # Générer une valeur aléatoire
        value=$((RANDOM))
        # Ajouter la valeur à la file Redis
        redis-cli LPUSH $REDIS_QUEUE $value
    done
}

# Boucle infinie pour envoyer des valeurs
while :; do
    send_values_to_redis
    echo "Envoyé $BURST_SIZE valeurs à Redis"
    sleep $PAUSE_BETWEEN_BURSTS
done
