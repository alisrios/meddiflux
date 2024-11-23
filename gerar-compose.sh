#!/bin/bash

# Definir o ambiente como variável de entrada
# O valor do ambiente pode ser 'prod' ou 'hom'
AMBIENTE=${1:-hom}  # Default para 'prod' se nenhum argumento for fornecido

# Verificar o ambiente e atribuir a imagem correspondente
if [ "$AMBIENTE" == "prod" ]; then
  IMAGE="148761658767.dkr.ecr.us-east-1.amazonaws.com/prod-meddiflux:latest"
elif [ "$AMBIENTE" == "hom" ]; then
  IMAGE="148761658767.dkr.ecr.us-east-1.amazonaws.com/hom-meddiflux:latest"
else
  echo "Ambiente inválido! Use 'prod' ou 'hom'."
  exit 1
fi

# Gerar o arquivo docker-compose.yml
cat > docker-compose.yml <<EOF
services:
  server:
    env_file: .env
    image: $IMAGE
    container_name: meddiflux
    ports:
      - "80:8080"
EOF

echo "docker-compose.yml gerado com sucesso para o ambiente $AMBIENTE!"
