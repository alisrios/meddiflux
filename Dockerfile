FROM public.ecr.aws/docker/library/node:21-slim
RUN npm install -g npm@latest --loglevel=error

# Instalar o curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --loglevel=error

COPY . .

# Definir variáveis de ambiente no Dockerfile
ARG REACT_APP_API_URL
ARG SKIP_PREFLIGHT_CHECK

# Usar as variáveis de ambiente durante o build
RUN REACT_APP_API_URL=${REACT_APP_API_URL} SKIP_PREFLIGHT_CHECK=${SKIP_PREFLIGHT_CHECK} npm run build --prefix client

RUN mv client/build build

RUN rm -rf client/*

RUN mv build client/

EXPOSE 8080

CMD [ "npm", "start" ]

