#!/bin/bash

IFS=:

input="/tmp/suporte/novosusuarios"


criarcontas() {
while read user gecos; do
	# add user prefix
	realuser="sre_${user}"
	echo -n "-> Criando usuario $(tput rev)${realuser}$(tput rmso) ... "
	# Cria usuario informando se houve sucesso ou erro
	if useradd -m -d /home/${realuser} -c "${gecos}" ${realuser} > /dev/null 2>&1; then
		echo OK!
	else
		echo ERRO!
	fi
done < ${input}
}

if [ ! -f "${input}" ]; then
	echo "[!!] ERRO: Arquivo de entrada nao encontrado!"
	exit 1
else
	criarcontas;
fi
