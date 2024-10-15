
## Dependências

O processo de instalação assume que você já tenha os seguintes pacotes instaladas:

- ansible
- git
- python
- make


## Como instalar

Primeiramente clone o repositório **tshoot**

    git clone https://github.com/testandoterminal/tshoot.git
    
Entre no diretório **tshoot/docker** e execute:

    make deploy-prod

Caso tudo ocorra bem, os containers do **django** e **postgres** estarão em execução e um 'Hello world!' estara disponivel via HTTP na porta 8080.

    root@lab-mgc-1001:~/tshoot# docker ps -a
    CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                                       NAMES
    4cd3d25a6246   django            "sh -c /opt/hellowor…"   3 seconds ago   Up 3 seconds   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   django
    814e03092b68   postgres:latest   "docker-entrypoint.s…"   4 seconds ago   Up 3 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   postgres
    root@lab-mgc-1001:~/tshoot#

### Hello World
___


    root@lab-mgc-1001:~/tshoot/docker# echo $(curl http://localhost:8080 2> /dev/null)
    Hello, World!
    root@lab-mgc-1001:~/tshoot/docker#


## Visualizar os logs

    make logs
    
## Parar containers

    make stop

## Remover containers

    make clean



