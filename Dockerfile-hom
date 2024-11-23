FROM public.ecr.aws/docker/library/node:21-slim

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --loglevel=error

COPY . .

RUN NODE_OPTIONS=--openssl-legacy-provider REACT_APP_API_URL=https://hom.projeto-aws.com.br SKIP_PREFLIGHT_CHECK=true npm run build --prefix client

RUN mv client/build build && rm -rf client/* && mv build client/

EXPOSE 8080

CMD [ "npm", "start" ]