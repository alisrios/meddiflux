#!/bin/bash

# Verifica o argumento passado para definir a URL da API
if [ "$1" == "prod" ]; then
  export REACT_APP_API_URL=https://pro.projeto-aws.com.br
else
  export REACT_APP_API_URL=https://hom.projeto-aws.com.br
fi

# Instala as dependências e constrói o projeto
npm install --loglevel=error
REACT_APP_API_URL=$REACT_APP_API_URL SKIP_PREFLIGHT_CHECK=true npm run build --prefix client