#!/bin/bash

zip_file="escritorio.zip"

read -p "Introduce el nombre del servidor ssh: " ssh_user
read -p "Introduce la ip del servidor: " ssh_server
read -p "Introduce la dirección donde  quieras que se guarde la copia: " remote_path

zip -r "$zip_file" .

scp "$zip_file" "$ssh_user@$ssh_server:$remote_path"

if [ $? -eq 0 ]; then
    echo "La operación fue en exito"
else 
    echo "Hubo un error en la ejecución"
fi

rm "$zip_file"