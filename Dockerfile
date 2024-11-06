# Usando uma imagem Node.js
FROM public.ecr.aws/docker/library/node:21-slim

# Atualizando o npm
RUN npm install -g npm@latest --loglevel=error

# Instalar o curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Definir o diretório de trabalho
WORKDIR /usr/src/app

# Copiar o arquivo package.json e package-lock.json
COPY package*.json ./

# Instalar dependências
RUN npm install --loglevel=error

# Copiar o restante dos arquivos
COPY . .

# Definir a variável de ambiente para a API URL
# Usando a variável de ambiente durante o build
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Rodar o build do React
RUN SKIP_PREFLIGHT_CHECK=true npm run build --prefix client

# Mover a build para o diretório correto
RUN mv client/build build
RUN rm -rf client/*
RUN mv build client/

# Expor a porta 8080
EXPOSE 8080

# Comando para rodar o app
CMD ["npm", "start"]
