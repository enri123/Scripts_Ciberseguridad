#!/bin/bah

#Si no se han introduccido dos parametros en el comando, mostramos la forma correcta de usar el script y ejecutamos un exit
if [ $# -ne 2 ]; then 
    echo "Uso: <diccionario> <URL>"
    exit 1 
fi

#$1 es el primer parametro introducido y $2 es el segundo
diccionario="$1"
url="$2"

#Usamos wc -l para contar todas las lineas del diccionario, y awk $1 para cojer la primera columna que es la que corresponde a las lineas totales
total_lines=$(wc -l $diccionario | awk '{print $1}')
current_line=0

while read -r linea; do 
#Usamos echo -ne y \r para que solo se imprima una vez
    current_line=$((current_line+1))
    echo -ne "Progreso: $current_line/$total_lines\r"

    respuesta =$(curl -s -o /dev/null -m "%{http_code}" "$url$linea/")

    if [ "$respuesta" -eq 200 ]; then
        echo "URL accesible: $url$linea/"
    fi

done < "$diccionario"