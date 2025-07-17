#!/bin/bash

# Recibe numero de archivos y ruta donde se generaran los archivos

# Funcion para mostrar error
error () {
    echo $1
    exit 1
}

# Revisa que se hayan recibido 2 parametros
if [ $# -ne 2 ]; then
    error "Uso: $0 debe recibir número de archivos a generar y ruta"
fi

# Comprueba la existencia del fichero
if [ ! -d $2 ]; then
    error "Error: el directorio no existe"
fi

# Verifica el numero de archivos que se van a generar
if [ $1 -lt 1 ]; then
    error "El número de ficheros no puede ser menor que 1"
fi

# Bucle para crear los archivos
for (( i = 1; i <= $1; i++ )); do
    # Seleccion de un nombre aleatorio del archivo words en /usr/share/dict/
    # Previamente se tuvo que instalar el paquete words de AUR en ArchLinux
    name=$(shuf -n 1 /usr/share/dict/words)
    # Identificacion de la carpeta en la que se encuentra el script junto al achivo formatos
    script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    # Seleccion de un foramto aleatorio en el archivo formatos
    formato=$(shuf -n 1 "$script_dir/formatos")
    # Concatenacion del nombre del archivo
    fname=$name.$formato
    # Creacion del archivo
    touch $2$fname
done