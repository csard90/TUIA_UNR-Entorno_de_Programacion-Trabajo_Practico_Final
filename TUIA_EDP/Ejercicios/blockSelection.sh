#!/bin/bash
TXT=$1

# Cálculo de cantidad de oraciones (eliminamos los puntos y cálculamos la diferencia de caracteres totales - la cantidad de caracteres totales sin los puntos) 
# lo usaremos para validar en el menú.
CANTIDAD_ORACIONES=$(($(cat $TXT | wc -m)-$(cat $TXT | tr -d "." | wc -m)))

# Cálculo de cantidad de párrafos (eliminamos los saltos de línea y cálculamos igual que arriba) lo usaremos para validar en el menú.
CANTIDAD_PARRAFOS=$(($(cat $TXT | wc -m)-$(cat $TXT | tr -d ';' | wc -m)))
REDUCCION=0 # Cantidad de caracteres que no se van a leer del .txt.

# Se recorre el .txt la cantidad de veces igual a la cantidad de párrafos que haya.
for i in $(seq $CANTIDAD_PARRAFOS)
do	
	# Se lee el .txt y se reemplazan todos los saltos de líneas por guiones. Después se reduce la cantidad de caracteres a leer.
	# Esto es para poder sacar la posición exacta de un determinado caracter (en este caso, el ';'), pero solo podemos sacar la posición de uno sólo.
	# Para poder sacar la posición de los demás, tenemos que IGNORAR todos los caracteres que hay hasta el ";" anterior, y así podes determinar la posición de otro. 
	TEXTO_REDUCIDO=$(cat $TXT | tr "\n" "-" | tail -c +$REDUCCION)
	POSICION="${TEXTO_REDUCIDO%%;*}" # Se cálcula la posición del caracter ';'

	# Se determina cuanto se va a reducir dependiendo de cuantas veces se repita el bucle.
	# Es decir, mientras más caracteres ';' haya en el texto, mayor cantidad de caracteres se tienen que ignorar. 
	# Para ello, vamos a sumar las posiciones de los anteriores para saber la cantidad total de caracteres a ignorar.
	((REDUCCION +=  $(( ${#POSICION} + 2 )) )) 

	POSICIONES=("${POSICIONES[@]}" $(( ${#POSICION} + 2 ))) # Lista donde se guardan todas las posiciones del caracter ';'.
done

# Opción elegida durante el menú
OPCION=""

# Menú para elegir opciones
while true
do
	read -p "Por donde desea navegar? Ingrese la opcion elegida (O-Oracion ; P-Parrafo): " OPCION
	# Se valida que se ingrese alguno de los siguientes caracteres como válidos: [O, o] [P, p].
	if [[ ! $OPCION =~ ^[Oo]$ && ! $OPCION =~ ^[Pp]$ ]] 
	then
		echo "Opcion $OPCION no valida, intente nuevamente"
		continue # Sino se ingresa lo correcto, se reinicia el bucle.
	else
		# Camino 1: Oración
		if [[ $OPCION =~ ^[Oo]$ ]]
		then		
			# Menú para elegir el número de oración.
			while true
			do
				read -p "Elija el número de oración a la que quiere llegar: " OPCION
				# La oración elegida tiene que estar entre 1 y la cantidad total de oraciones.
				if [ $OPCION -gt $CANTIDAD_ORACIONES ] || [ $OPCION -lt 1 ]
				then
					echo "Opción $OPCION no válida. El número debe estar entre 1 y $CANTIDAD_ORACIONES"
					continue # Sino se reinicia el bucle de adentro
				else
					# Para movernos por cada una de las oraciones con el comando cut eliminamos los saltos de línea quedando un archivo provisorio con todas 
					# las oraciones en una única línea.
					cat $TXT | tr -d "\n" >> texto_sinsaltos.txt
					# Imprimimos en pantalla el texto original y la oración elegida.
					echo -e "\nTexto original: "
					cat $TXT
					echo -e "\n\nOración $OPCION: $(cat texto_sinsaltos.txt | cut -d "." -f $OPCION | tr -d ";")"
					break # Fin bucle de adentro.
				fi
			done
		else
			# Camino 2: Párrafos
			# Menú de selección de párrafos
			while true
            do
                read -p "Elija el número de párrafo al que quiere llegar: " OPCION
				# Validación de que el numero de párrafo exista.
                if [ $OPCION -gt $CANTIDAD_PARRAFOS ] || [ $OPCION -lt 1 ]
                then
                    echo "Opción $OPCION no válida. El número debe estar entre 1 y $CANTIDAD_PARRAFOS"
                    continue # Si no existe el párrafo, se reinicia el bucle de adentro.
                else
					# Se hace un bucle que se repite una vez menos a la opción elegida del usuario.
					# Esto es para calcular la reducción total que se va a hacer al texto para después poder mostrar el párrafo, es decir:
					# si el usuario elije el número 3 como opción, significa que quiere ver el tercer párrafo, esto nos dice, por una cuestión lógica...
					# que dentro de la lista POSICIONES, antes de ese tercer párrafo, hay dos más, lo que vamos a hacer es SUMAR la posición de los caracteres...
					# de esos dos párrafos y así vamos a saber CUANTOS caracteres pertenecen a esos párrafos.
					for i in $(seq $(($OPCION - 1)))
					do
						((REDUCCION_TOTAL += ${POSICIONES[($i - 1)]}))
					done

					# Imprimimos en pantalla el texto original y el párrafo elegido.
					echo -e "\nTexto original: "
					cat $TXT
					echo -e "\n\nPárrafo $OPCION: "
					# Después se ignoran esos caracteres con el tail "convirtiendo" al tercer párrafo como si fuera el primero y se lee los caracteres...
					# que correspondan con su posición con el head
					echo $(cat $1 | tr "\n" "-" | tail -c +$(($REDUCCION_TOTAL + 1)) | head -c ${POSICIONES[($OPCION - 1)]} | tr "-" "\n")
                    break # Fin del bucle de adentro
                fi
            done
		fi		
	fi
	break #Fin del bucle de afuera.
done

# Eliminamos los archivos provisorios utilizados si es que existen.
[ -e texto_sinsaltos.txt ] && rm texto_sinsaltos.txt
exit 0