FROM public.ecr.aws/docker/library/node:21-slim

# Install dependencies (update and install curl, remove cache)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install project dependencies with minimal logging
RUN npm install --loglevel=error

# Copy remaining project files
COPY . .

# Define API URL environment variables
ARG ENVIRONMENT
ENV REACT_APP_API_URL_PROD=https://prod.projeto-aws.com.br
ENV REACT_APP_API_URL_HOM=https://hom.projeto-aws.com.br

# Set API URL based on environment
RUN if [ "$ENVIRONMENT" = "https://prod.projeto-aws.com.br" ]; then \
    echo "Using prod API URL"; \
    echo "REACT_APP_API_URL=${REACT_APP_API_URL_PROD}" >> .env; \
  else \
    echo "Using hom API URL"; \
    echo "REACT_APP_API_URL=${REACT_APP_API_URL_HOM}" >> .env; \
  fi

# Build React app with dynamic API URL
RUN NODE_OPTIONS=--openssl-legacy-provider SKIP_PREFLIGHT_CHECK=true npm run build --prefix client

# Clean and move build artifacts
RUN mv client/build build && rm -rf client/* && mv build client/

# Expose port for container
EXPOSE 8080

# Start the application in the container
CMD [ "npm", "start" ]