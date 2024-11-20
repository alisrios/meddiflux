FROM public.ecr.aws/docker/library/node:21-slim

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --loglevel=error

COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]