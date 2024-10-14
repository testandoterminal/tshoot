#!/bin/bash

# Procura palavras iniciando com sre_ no arquivo /etc/passwd
awk '/^sre_/' /etc/passwd
