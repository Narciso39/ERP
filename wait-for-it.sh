#!/bin/bash
# wait-for-it.sh

# Função que aguarda a disponibilidade do banco de dados
host="$1"
shift
port="$1"
shift
cmd="$@"

until nc -z "$host" "$port"; do
  echo "Aguardando o banco de dados no host $host na porta $port..."
  sleep 1
done

echo "Banco de dados disponível, executando comando..."
exec $cmd
