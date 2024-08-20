#!/bin/bash
TXT=$1

echo "\nResultado: "
# Se lee el texto y se intercambia con tr las mayúsculas por minúsuclas.
# Todo eso se guarda en resultado.txt, un archivo temporal para poder mostrar como sería la conversión.
cat $TXT | tr "a-zA-Z" "A-Za-z" >> resultado.txt 
cat resultado.txt # Se lee el .txt con los caracteres convertidos.
rm resultado.txt # Se elimina dicho .txt.
echo ""

exit 0