#!/bin/bash
TXT=$1

echo 'Nombres propios: '
# El comando read recibe una entrada y dicha entrada la guarda en una variable.
# A este bucle while se le pasa todas las líneas del .txt que se pasa como parámetro, todas las líneas son leídas por el comando read y guardadas en la variable "line".
# El bucle se repite hasta que se lean todas las líneas del .txt.
while read LINE
do
    # Este bucle recorre cada palabra que haya en cada línea, guardándolo en la variable "word".
    for WORD in $LINE
    do      
        WORD=$(echo ${WORD//[.,¿?!¡;]/}) # Se elimian todos los caracteres especiales que contenga las palabras.

        # ^[A-Z] significa que el primer caracter de la palabra tiene que ser una mayúscula.
        # [a-z]+$ significa que la palabra tiene que terminar con caracteres en minúscula.
        # Si la palabra coincide con todas estas expresiones, se imprime dicha palabra.
        if [[ $WORD =~ ^[A-Z][a-z]+$ ]]
        then
            echo $WORD
        fi
    done
done < $TXT

exit 0