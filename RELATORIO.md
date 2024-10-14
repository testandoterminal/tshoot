# Relatório Tecnico de Incidente

Esse relatorio tem como objetivo esclarecer as ações realizadas no servidor **ubuntu**, tanto para identificação dos problemas relacionados aos serviços de **Apache**, **MySQL** e **RabbitMQ**, bem como mitigação / restabelecimento do ambiente.

## 1. systemctl

O comando **systemctl** estava sem permissão de execução, impossibilitando a verificação do status de serviços SystemD. 

## 2. Apache

Arquivo de configuração do Apache com diretiva inválida, impedindo que o serviço iniciasse, na linha 19 do arquivo **/etc/apache2/sites-enabled/000-default.conf**:

     14         # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
     15         # error, crit, alert, emerg.
     16         # It is also possible to configure the loglevel for particular
     17         # modules, e.g.
     18         #LogLevel info ssl:warn
     19         #InvalidDirective On
     20
     21         ErrorLog ${APACHE_LOG_DIR}/error.log
     22         CustomLog ${APACHE_LOG_DIR}/access.log combined

O erro foi prongamente identificado atrávés do comando apachectl, apontando a configuração inválida em questão.

> apachectl configtest

Após comentar a linha em questão, o serviço do Apache subiu normalmente.

## 3. MySQL

Similar ao problema do Apache, o serviço do MySQL não estava iniciando pois estava configurado com um valor inválido para o parâmetro **default_authentication_plugin**, conforme linha 79 do arquivo **/etc/mysql/mysql.conf.d/mysqld.cnf**:

     74 # log_bin                       = /var/log/mysql/mysql-bin.log
     75 # binlog_expire_logs_seconds    = 2592000
     76 max_binlog_size   = 100M
     77 # binlog_do_db          = include_database_name
     78 # binlog_ignore_db      = include_database_name
     79 #default_authentication_plugin=invalid_plugin

Para correção, a linha em questão foi comentada, permitindo o serviço do **MySQL** inicializar normalmente com a variável em questão padrão, conforme pode ser observado abaixo:

    mysql> show variables like 'default_authentication_plugin';
    +-------------------------------+-----------------------+
    | Variable_name                 | Value                 |
    +-------------------------------+-----------------------+
    | default_authentication_plugin | caching_sha2_password |
    +-------------------------------+-----------------------+
    1 row in set (0.00 sec)
    
    mysql>


## 4. RabbitMQ

Após verificação do status do serviço do **RabbitMQ**, espeficamente a SystemD unity **rabbitmq-server.service**, o serviço estava em *crashloop*. Após verificação dos arquivos de log, foi observado que o serviço estava tentando escutar na porta 80, conforme trecho abaixo:

    Error during startup: {error,
                           {could_not_start_listener,"::",80,
                            {{shutdown,
                              {failed_to_start_child,
                               {ranch_embedded_sup,
                                {acceptor,{0,0,0,0,0,0,0,0},80}},
                               {shutdown,
                                {failed_to_start_child,

A porta 80 já estava em uso pelo serviço do **Apache**, além de não ser a porta padrão do **RabbitMQ**.
Realizada a alterada a configuração de porta conforme linha 14 do arquivo **/etc/rabbitmq/rabbitmq-env.conf**:

      9 # address family.
     10 #NODE_IP_ADDRESS=127.0.0.1
     11
     12 # Defaults to 5672.
     13 #NODE_PORT=5672
     14 RABBITMQ_NODE_PORT=5672

Após o ajuste, o serviço do **RabbitMQ** foi inicializado normalmente.

# Conclusão
Diante do cenário em que foi encontrado no servidor **ubuntu**, recomenda-se a criação de um servidor de homologação, para que as devidas alterações de configurações sejam validades previamente, preservando o funcionamento do ambiente de produção.
