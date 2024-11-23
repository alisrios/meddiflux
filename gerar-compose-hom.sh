cat > docker-compose.yml <<EOF
services:
  server:
    env_file: .env
    image: "148761658767.dkr.ecr.us-east-1.amazonaws.com/hom-meddiflux:latest"
    container_name: meddiflux
    ports:
      - "80:8080"
EOF

echo "docker-compose.yml gerado com sucesso para o ambiente $AMBIENTE!"
