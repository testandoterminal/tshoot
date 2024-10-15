
## Dependências

O processo de instalação assume que você já tenha os seguintes pacotes instaladas:

- ansible
- git
- python
- make


## Como instalar

Primeiramente clone o repositório **tshoot**

    git clone https://github.com/testandoterminal/tshoot.git
    
Entre no diretório **tshoot/django** e execute:

    make deploy-prod

Caso tudo ocorra bem, os containers do **django** e **postgres** estarão em execução:

## Visualizar os logs

    make logs
    
## Parar containers

    make stop

## Remover containers

    make clean

