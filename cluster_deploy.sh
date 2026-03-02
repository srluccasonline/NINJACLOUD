#!/bin/bash
# cluster_deploy.sh - NINJABR.CLOUD
# Automação para deploy em 100+ VPS independentes

# 1. LISTA DE IPS (Adicione os seus 100 IPs aqui)
VPS_IPS=(
  "200.1.1.1"
  "200.1.1.2"
  # ... adicione os outros 98 IPs
)

# 2. CONFIGURAÇÕES
IMAGE_NAME="seu-usuario-docker/ninjabr-cloud:latest"
DOMAIN="ninjabr.cloud"
USER_PASS="ninja"
ADMIN_PASS="admin_ninja"

echo "========================================"
echo "   INICIANDO DEPLOY NO CLUSTER (100+)   "
echo "========================================"

# Loop por cada VPS
for i in "${!VPS_IPS[@]}"; do
    IP=${VPS_IPS[$i]}
    ID=$((i+1))
    SUBDOMAIN="s$ID.$DOMAIN"
    
    echo "----------------------------------------"
    echo "Servidor $ID [$IP] -> $SUBDOMAIN"
    
    # Comando remoto via SSH
    # Certifique-se de ter sua chave SSH configurada nas VPSs
    ssh -o ConnectTimeout=5 root@$IP << EOF
        # 1. Instalar Docker se não existir
        if ! command -v docker &> /dev/null; then
            echo "Instalando Docker..."
            curl -fsSL https://get.docker.com | sh
        fi

        # 2. Criar diretório de configuração
        mkdir -p ~/ninjabr-cloud
        cd ~/ninjabr-cloud

        # 3. Criar docker-compose.yml dinâmico
        cat <<EOT > docker-compose.yml
services:
  neko:
    image: $IMAGE_NAME
    container_name: ninjabr-cloud
    restart: unless-stopped
    shm_size: "2gb"
    ports:
      - "80:8080"
      - "52000-52100:52000-52100/udp"
    environment:
      NEKO_NAT1TO1: "$IP"
      NEKO_MEMBER_MULTIUSER_USER_PASSWORD: "$USER_PASS"
      NEKO_MEMBER_MULTIUSER_ADMIN_PASSWORD: "$ADMIN_PASS"
      NEKO_DESKTOP_SCREEN: "1920x1080@30"
      NEKO_WEBRTC_EPR: "52000-52100"
      NEKO_WEBRTC_ICELITE: "1"
EOT

        # 4. Pull e Up
        docker compose pull
        docker compose up -d
        echo "Instância $SUBDOMAIN ativa!"
EOF
done

echo "========================================"
echo "          DEPLOY CONCLUÍDO!             "
echo "========================================"
