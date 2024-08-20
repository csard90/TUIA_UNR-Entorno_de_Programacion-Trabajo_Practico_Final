#!/bin/bash
TXT=$1

# Se pide al usuario ingresar tanto la primera cadena a buscar y la segunda cadena para reemplazar la primera.
read -p "Ingrese la primera cadena: " CADENA1
read -p "Ingrese la segunda cadena: " CADENA2

# Consideraciones:
# Se usa un .txt temporal porque si se hiciera todo el comando para mostrar los cambios que habría en el .txt original.

echo -e "\nCadenas que contienen: '$CADENA1', fueron cambiadas por: '$CADENA2'"
# cat $TXT lee la copia del archivo .txt que ingreso el usuario.
# iconv -f UTF-8 -t ASCII//TRANSLIT elmina las tíldes.
# > temporal.txt toda la salida de ese comando se manda al temporal.txt que se crea directamente al no existir.
# sed -i "s/$CADENA1/$CADENA2/g" temporal.txt reemplaza las cadenas que pidió el usuario en el .txt temporal.
cat $TXT | iconv -f UTF-8 -t ASCII//TRANSLIT > temporal.txt | sed -i "s/$CADENA1/$CADENA2/g" temporal.txt
# cat temporal.txt lee e imprime en pantalla los cambios de cadenas
# rm temporal.txt se elimina el .txt temporal que se utilizó.
cat temporal.txt 
echo -e "\n"
rm temporal.txt

exit 0