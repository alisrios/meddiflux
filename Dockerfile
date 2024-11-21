FROM public.ecr.aws/docker/library/node:21-slim

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --loglevel=error

COPY . .

# Definição de argumentos (disponíveis apenas no build time)
ARG ENVIRONMENT
ARG DB_SECRET_NAME_HOM
ARG DB_SECRET_NAME_PROD
ARG DB_HOST_HOM
ARG DB_HOST_PROD

# Definição de variáveis de ambiente (disponíveis no runtime)
ENV REACT_APP_API_URL_PROD=https://prod.projeto-aws.com.br
ENV REACT_APP_API_URL_HOM=https://hom.projeto-aws.com.br
ENV DB_PORT=5432
ENV DB_REGION=us-east-1

# Transferindo valores de ARG para ENV
ENV ENVIRONMENT=${ENVIRONMENT}
ENV DB_SECRET_NAME_HOM=${DB_SECRET_NAME_HOM}
ENV DB_SECRET_NAME_PROD=${DB_SECRET_NAME_PROD}
ENV DB_HOST_HOM=${DB_HOST_HOM}
ENV DB_HOST_PROD=${DB_HOST_PROD}

# Criar o arquivo .env antes do build
RUN if [ "$ENVIRONMENT" = "https://prod.projeto-aws.com.br" ]; then \
    echo "Usando API URL de Produção"; \
    echo "REACT_APP_API_URL=${REACT_APP_API_URL_PROD}" > .env; \
    echo "DB_SECRET_NAME=${DB_SECRET_NAME_PROD}" >> .env; \
    echo "DB_HOST=${DB_HOST_PROD}" >> .env; \
  else \
    echo "Usando API URL de Homologação"; \
    echo "REACT_APP_API_URL=${REACT_APP_API_URL_HOM}" > .env; \
    echo "DB_SECRET_NAME: ${DB_SECRET_NAME_HOM}" >> .env; \
    echo "DB_HOST=${DB_HOST_HOM}" >> .env; \
    echo "DB_REGION=${DB_REGION}" >> .env; \
    echo "DB_PORT=${DB_PORT}" >> .env; \
  fi

# Garante que o arquivo .env está disponível durante o build
RUN cat .env

# Build da aplicação com as variáveis de ambiente
RUN NODE_OPTIONS=--openssl-legacy-provider REACT_APP_API_URL=$ENVIRONMENT SKIP_PREFLIGHT_CHECK=true npm run build --prefix client

RUN mv client/build build && rm -rf client/* && mv build client/

EXPOSE 8080

CMD [ "npm", "start" ]