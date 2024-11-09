FROM public.ecr.aws/docker/library/node:21-slim
RUN npm install -g npm@latest --loglevel=error

# Instalar o curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --loglevel=error

COPY . .

# Copie o script de construção para o contêiner
COPY build.sh .

# Dê permissão de execução ao script
RUN chmod +x build.sh

# Execute o script de construção
RUN ./build.sh $ENVIRONMENT  # Usando a variável de ambiente

RUN mv client/build build
RUN rm -rf client/*
RUN mv build client/

EXPOSE 8080

CMD ["npm", "start"]