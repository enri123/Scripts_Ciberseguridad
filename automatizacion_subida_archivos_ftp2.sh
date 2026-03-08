#!/bin/bash

# IP y usuario para iniciar sesion al servidor FTP

read -p 'Introduce la ip del servidor: ' servidor
read -p 'Introduce el usuario del servidor: ' usuario
read -p 'Introduce la contraseña del usuario: ' contraseña
#Ruta del archivo a subir al servidor

read -p 'Introduce la ruta absoluta del archivo que quieras subir al servidor: ' archivo

#Ruta y nombre donde queramos guardar el archivo en el servidor

read -p 'Introduce la ruta donde quieras guardar el archivo en el servidor: ' ruta_remoto

#Comando para subir el archivo

curl -u "$usuario:$contraseña" -T "$archivo" ftp://$servidor/$ruta_remoto