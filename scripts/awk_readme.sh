#!/bin/bash

# Imprime qualquer linha que tenha caractere no arquivo em questao
zcat /usr/share/doc/gcc-12-base/README.Debian.amd64.gz | awk '/./'
