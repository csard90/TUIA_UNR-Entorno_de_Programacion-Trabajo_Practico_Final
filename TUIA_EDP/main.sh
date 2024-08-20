#!/bin/bash
[ ! -f $1 ] && echo "El archivo no existe." && exit 0 # Se determina si el archivo pasado como argumento existe
[ ! $# -eq 1 ] && echo "Sólo se permite un único argumento." && exit 1 # Se determina que sólo se haya paso un argumento

TXT=$(readlink -e $1) # Se guarda en la variable la ruta absoluta del .txt para evitar errores
ejercicios=( "Estadístico de longitud de palabras" "Estadístico de uso de palabras" "Encontrar nombres" "Longitud de oraciones" "Contador de líneas en blanco" "Mayúsculas a minúsculas y viceversa" "Reemplazo de subcadenas" "Selección de oración o párrafo" "Detectar palíndromes" "Salir" ) # Lista de opciones

echo "Opciones de análisis para el texto: "
# Según la opción que eliga el usuario, se ejecuta el script correspondiente con esa opción
select OPT in "${ejercicios[@]}"
do
    cd Ejercicios
    case $OPT in
	"Estadístico de longitud de palabras") ./statsWords.sh $TXT; break;;
	"Estadístico de uso de palabras") ./statsUsageWords.sh $TXT; break;;
	"Encontrar nombres") ./findNames.sh $TXT ;break;;
	"Longitud de oraciones") ./statsSentences.sh $TXT; break;;
    "Contador de líneas en blanco") ./blankLinesCounter.sh $TXT; break;;
	"Mayúsculas a minúsculas y viceversa") ./caseConverter.sh $TXT; break;;
    "Reemplazo de subcadenas") ./substringReplace.sh $TXT; break;;
	"Selección de oración o párrafo") ./blockSelection.sh $TXT; break;;
	"Detectar palíndromes") ./palindromeDetection.sh $TXT; break;;
    "Salir") exit; break;;
    esac
done
