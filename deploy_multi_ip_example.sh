#!/bin/bash
# Script de Exemplo para Deploy em Multi-IP - NINJABR.CLOUD

# Lista de IPs da sua VPS (Exemplo)
IPS=("200.1.1.1" "200.1.1.2" "200.1.1.3") 
# Você pode carregar isso de um arquivo: IPS=($(cat lista_de_ips.txt))

DOMAIN="ninjabr.cloud"

for i in "${!IPS[@]}"; do
    IP=${IPS[$i]}
    ID=$((i+1))
    
    echo "Iniciando Instância $ID no IP $IP (s$ID.$DOMAIN)"
    
    # Rodando um container por IP
    docker run -d \
        --name "ninjabr-s$ID" \
        --restart unless-stopped \
        --shm-size=2gb \
        -p "$IP:80:8080" \
        -p "$IP:52000-52100:52000-52100/udp" \
        -e NEKO_NAT1TO1="$IP" \
        -e NEKO_MEMBER_MULTIUSER_USER_PASSWORD="usuario$ID" \
        -e NEKO_MEMBER_MULTIUSER_ADMIN_PASSWORD="admin$ID" \
        -e NEKO_DESKTOP_SCREEN="1920x1080@30" \
        sua-imagem-customizada-do-ninjabr
done
