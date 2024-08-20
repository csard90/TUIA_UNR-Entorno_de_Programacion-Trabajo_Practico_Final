#!/bin/bash
TXT=$1

PALABRALARGA=0
PALABRACORTA=0

PALABRASTOTALES=$(wc -w $TXT | cut -d " " -f 1) # Se cuenta la cantidad total de palabras y con el cut se saca de la variable el nombre del archivo
LONGITUDTOTAL=0

# El comando read recibe una entrada y dicha entrada la guarda en una variable.
# A este bucle while se le pasa todas las líneas del .txt que se pasa como parámetro, todas las líneas son leídas por el comando read y guardadas en la variable "line".
# El bucle se repite hasta que se lean todas las líneas del .txt.
while read line
do
    # Este bucle recorre cada palabra que haya en cada línea, guardándolo en la variable "word".
    for WORD in $line
    do      
        WORD=$(echo ${WORD//[.,¿?!¡;]/}) # Se elimian todos los caracteres especiales que contenga las palabras.
        LONGITUD=${#WORD} # Se imprime la longitud de la palabra
        ((LONGITUDTOTAL += $LONGITUD)) # Se suma esa longitud a las demás

        # Si ambas longitud, la más corta y la más larga, son iguales a 0, significa que se esta recorriendo la primera palabra del .txt
        # por lo tanto, se les asigna dicho valor a ambas variables.
        if [[ $PALABRACORTA -eq 0 && $PALABRALARGA -eq 0 ]]
        then
            PALABRACORTA=$LONGITUD
            PALABRALARGA=$LONGITUD
        else
            # En caso de que haya más palabras, se determina si ese valor es mayor a la palabra más larga...
            if [[ $LONGITUD -gt $PALABRALARGA ]]
            then
                PALABRALARGA=$LONGITUD
            else
                # o menor a la palabara más corta.
                # En cualquiera de los casos, si es afirmativo, se le va ese valor a su correspondiente variable.
                # En caso de que no, simplemente se ignora.
                if [[ $LONGITUD -lt $PALABRACORTA ]]
                then
                    PALABRACORTA=$LONGITUD
                fi
            fi
        fi
    done
done < $TXT
PROMEDIO=$(echo "scale=2; $LONGITUDTOTAL/$PALABRASTOTALES" | bc) # El promedio se redondea permitiendo dos decimales.

# Se imprimen todos los valores en consola.
echo -e "\nLongitud de la palabra más larga: $PALABRALARGA"
echo "Longitud de la palabra más corta: $PALABRACORTA"
echo "Promedio de longitud de las palabras: $PROMEDIO"

exit 0
