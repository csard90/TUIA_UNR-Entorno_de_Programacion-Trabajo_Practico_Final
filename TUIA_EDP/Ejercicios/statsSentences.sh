#!/bin/bash
TXT=$1

# Contador de cantidad de puntos (u oraciones) = "cantidad total de caracteres con los puntos" - "cantidad de caracteres eliminando los puntos".
ORACIONES=$(($(cat $TXT | wc -m)-$(cat $TXT | tr -d "." | wc -m)))

# Con el objetivo de a futuro movernos por cada una de las oraciones con el comando cut eliminamos los saltos de línea quedando 
# un archivo con todas las oraciones en una única línea.
cat $TXT | tr -d "\n" >> texto_sinsaltos.txt

# Recorremos las oraciones una por una con un for (contamos los caracteres de cada una, cálculamos la sumatoria de caracteres para el promedio, 
# y asignamos a un nuevo documento provisorio la salida con el sig formato: "cantidad de caracteres: oración a la que le corresponde").
CARACTERES_ORACION=0
SUMATORIA_CARACTERES=0

for NUMERO_ORACION in $(seq $ORACIONES) # seq va de 1 a la cantidad de oraciones.
do
	# Caracteres correspondientes a la oración por la que va el for.
	CARACTERES_ORACION=$(cat texto_sinsaltos.txt | cut -d "." -f $NUMERO_ORACION | wc -m)
	
	# Sumatoria de los caracteres de todas las oraciones.
	SUMATORIA_CARACTERES=$(($SUMATORIA_CARACTERES+$CARACTERES_ORACION))

	# Contador de cantidad de caracteres (wc -m) en cada oración.
	echo -n "$CARACTERES_ORACION caracteres:" >> longitud_oraciones.txt

	# Al lado se indica a que oración pertenece.
	echo $(cat texto_sinsaltos.txt | cut -d "." -f $NUMERO_ORACION) >> longitud_oraciones.txt
done

# Cálculo del promedio de longitud de las oraciones. scale=2 dos decimales. Se hace con bc porque de otro modo no se tienen en cuenta los decimales en la división.
PROMEDIO=$(echo "scale=2; $SUMATORIA_CARACTERES / $ORACIONES" | bc)

# Documento provisorio para agrupar todos los resultados.
echo -e "\nResultados: " >> estadisticas_final.txt
echo "Promedio de longitud de oraciones: $PROMEDIO caracteres por oración." >> estadisticas_final.txt
echo "Oración más corta: $(cat longitud_oraciones.txt | sort -n -r | tail -1)" >> estadisticas_final.txt
echo "Oración más larga: $(cat longitud_oraciones.txt | sort -n -r | head -1)" >> estadisticas_final.txt

# Se muestran los resultados
cat estadisticas_final.txt
# Se eliminan todos los documentos provisorios utilizados para no llenar el directorio de archivos y no tener problemas en las siguientes ejecuciones.
rm texto_sinsaltos.txt | rm longitud_oraciones.txt | rm estadisticas_final.txt

# NOTA: Para el cálculo del promedio de longitud por oraciones se consideraron los caracteres (incluidos, espacios, puntos, y demas correspondientes a dicha oración) 
# y se excluyeron los saltos de línea. Se considera que cada punto corresponde a la oración que empieza inmediatamente después del último punto.
exit 0