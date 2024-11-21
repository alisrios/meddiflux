FROM public.ecr.aws/docker/library/node:21-slim

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --loglevel=error

COPY . .

# Definição dos argumentos e variáveis de ambiente
ARG ENVIRONMENT
ENV REACT_APP_API_URL_PROD=https://prod.projeto-aws.com.br
ENV REACT_APP_API_URL_HOM=https://hom.projeto-aws.com.br
ENV DB_PORT=""
ENV DB_REGION=""
ENV DB_SECRET_NAME=""
ENV DB_HOST=""

# Criar o arquivo .env antes do build
RUN if [ "$ENVIRONMENT" = "https://prod.projeto-aws.com.br" ]; then \
    echo "Usando prod API URL"; \
    echo "REACT_APP_API_URL=${REACT_APP_API_URL_PROD}" > .env; \
  else \
    echo "Usando hom API URL"; \
    echo "REACT_APP_API_URL=${REACT_APP_API_URL_HOM}" > .env; \
    echo "DB_HOST=db-hom-meddiflux.cluster-c9qkwqag6uxj.us-east-1.rds.amazonaws.com" >> .env; \
    echo "DB_SECRET_NAME=rds!cluster-42d51256-37a1-433c-b7b8-868f6e67c357" >> .env; \
    echo "DB_REGION=us-east-1" >> .env; \
    echo "DB_PORT=5432" >> .env; \
  fi

# Garante que o arquivo .env está disponível durante o build
RUN cat .env

# Build da aplicação com as variáveis de ambiente
RUN NODE_OPTIONS=--openssl-legacy-provider REACT_APP_API_URL=$ENVIRONMENT SKIP_PREFLIGHT_CHECK=true npm run build --prefix client

RUN mv client/build build && rm -rf client/* && mv build client/

EXPOSE 8080

CMD [ "npm", "start" ]