#!/bin/bash
TXT=$1

echo "Palabras palíndromes encontradas en el texto: "
# El comando read recibe una entrada y dicha entrada la guarda en una variable.
# A este bucle while se le pasa todas las líneas del .txt que se pasa como parámetro, todas las líneas son leídas por el comando read y guardadas en la variable "LINE".
# El bucle se repite hasta que se lean todas las líneas del .txt.
while read LINE
do
    # Este bucle recorre cada palabra que haya en cada línea, guardándolo en la variable "WORD".
    for WORD in $LINE
    do      
        # echo $WORD imprime la palabra en la variable $WORD
        # rev invierte la palabra impresa
        # iconv -f UTF-8 -t ASCII//TRANSLIT elimina todas las tíldes que tenga la palabra.
        # tr [:lower:] [:upper:] convierte las minúsculas en mayúsculas

        REV=$(echo $WORD | rev | iconv -f UTF-8 -t ASCII//TRANSLIT | tr [:lower:] [:upper:]) # Se invierte, limpia y se convierte en mayúsculas toda la palabra.
        PALABRAMAYUS=$(echo $WORD | iconv -f UTF-8 -t ASCII//TRANSLIT | tr [:lower:] [:upper:]) # Lo mismo sólo que sin invertir la palabra.

        # Si coincide la palabra con su inversa, entonces es un palíndromo y se imprime la palabra en consola.
        if [[ $PALABRAMAYUS == $REV ]]
        then
            echo ${WORD^} 
        fi    
    done
done < $TXT

exit 0