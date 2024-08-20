#!/bin/bash
TXT=$1

# "Limpiamos" las palabras sacandole algunos caracteres especiales y lo guardamos en una variable.
PALABRAS=$(sed -r 's/[,.";:!?¡¿]/ /g' <<< cat $TXT)

# Guardamos las palabras de más de 4 caracteres en un nuevo .txt pasadas a minúsculas para que no haya problemas de no detección de palabras iguales.
for p in $PALABRAS
do	
	[ $(expr length $p) -ge 4 ] && echo ${p,,} >> palabras.txt
done

# A palabras.txt lo ordenamos alfabéticamente, luego uniq -c quita las repeteciones y realiza un conteo, a su vez... 
# ordenamos por el número del conteo anterior y con -r lo damos vuelta al orden. De esto mostramos los 10 primeros resultados.
echo -e "\nTop de las diez palabras, de al menos 4 letras, más usadas: "
cat palabras.txt | sort | uniq -c | sort -n -r | head -n 10
rm palabras.txt

exit 0