FROM public.ecr.aws/docker/library/node:21-slim
RUN npm install -g npm@latest --loglevel=error

# Instalar o curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --loglevel=error

COPY . .

# Definir variáveis de ambiente no Dockerfile, se necessário
ARG REACT_APP_API_URL
ARG SKIP_PREFLIGHT_CHECK

# Passar as variáveis para o ambiente de execução durante o build
ENV REACT_APP_API_URL=${REACT_APP_API_URL}
ENV SKIP_PREFLIGHT_CHECK=${SKIP_PREFLIGHT_CHECK}

RUN npm run build --prefix client

RUN mv client/build build
RUN rm -rf client/*
RUN mv build client/

EXPOSE 8080

CMD ["npm", "start"]
