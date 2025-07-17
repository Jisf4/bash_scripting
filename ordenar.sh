#!/bin/bash

# Ordenar los archivos en una carpeta en diferentes de acuerdo al formato
# Recibe la ubicacion de la carpeta que se quiere ordenar


# Funcion para mostrar error
error () {
    echo $1
    exit 1
}

# Funcion para ordenar los achivps
ordenar () {
    # Comprobar si el formato pertenece a la categoria
    if [[ $1 =~ $n_formato ]]; then
        # Comprobar si ya existe la carpeta de la categoria
        if [ ! -d "$2$3" ]; then
            mkdir "$2$3"
        fi
        # Mover el archivo a la carpeta de la categoria a la que pertenece
        ((++$4))
        mv "$2$f" "$2$3"
    fi    
}

reporte () {
    echo "Se han movido $1 archivos a la carpeta $2."
}

# Listas de formatos de archivos
declare -a music_f={".aiff"".au"".midi"".mp3"".m4a"".wav"".wma"}
declare -a video_f={".avi"".mp4"".m4v"".mov"".mpg"}
declare -a documentos_f={".txt"".rtf"".pdf"".csv"".ods"".odp"}
declare -a comp_f={".zip"".rar"".tar"}
declare -a img_f={".jpg"".png"".gif"".bmp"}

# Comprobar que el numero de parametros es correcto
if [ $# -ne 1 ]; then
    error "Uso: debe recibir prefijo y ruta"
fi

# Comprobar que el directorio existe 
if [ ! -d $1 ]; then
    error "Error: el directorio no existe"
fi
m=0
v=0
d=0
a=0
i=0
# Recorrer cada fichero del directorio
for f in `ls $1`; do
    if [ ! -d "$1$f" ]; then
        # Establecer . como un delimitador del nombre de los archivos
        IFS='.'
        # Leer el nombre del archivo, separarlo de acuerdo al delimitador
        # y guardarlo en una lista
        read -ra formato <<< $f
        # Obtener el formato del archivo
        n_formato=${formato[1]}
        # Ordenar los archivos de cada categoria mediante funcion
        ordenar "${music_f[@]}" "$1" "Musica" m
        ordenar "${video_f[@]}" "$1" "Videos" v
        ordenar "${documentos_f[@]}" "$1" "Documentos" d
        ordenar "${comp_f[@]}" "$1" "Archivos_comprimidos" a
        ordenar "${img_f[@]}" "$1" "Imagenes" i
    fi

done

# Reportar la cantidad de archivos movidos a cada carpeta
reporte $m "musica"
reporte $v "videos"
reporte $d "documentos"
reporte $a "archivos comprimidos"
reporte $i "imagenes"








