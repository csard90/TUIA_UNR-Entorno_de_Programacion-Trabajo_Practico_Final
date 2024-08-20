#!/bin/bash

TXT=$1

echo "Cantidad de líneas en blanco: $(grep -cvP '\S' $TXT)"

# -c imprime la cantidad de líneas
# -v selecciona las líneas que no coinciden con los parámetros
# -P '\S' los parámetros que se tienen en cuenta, en este caso, cualquier línea que no este en blanco

exit 0