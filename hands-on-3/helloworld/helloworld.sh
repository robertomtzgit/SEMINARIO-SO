#!/bin/bash

echo "=== Ejecutando el script de Linux ==="
echo "Hello World"

echo -e "\n>>> Contenido del directorio actual:"
ls -lh

DIR="Test"
if [ ! -d "$DIR" ]; then
    echo -e "\n>>> Creando el directorio '$DIR'..."
    mkdir "$DIR"
else
    echo -e "\n>>> El directorio '$DIR' ya existe."
fi

echo -e "\n>>> Contenido del directorio después de la creación:"
ls -lh

echo -e "\n>>> Entrando al directorio '$DIR'..."
cd "$DIR" || { echo "Error: No se pudo acceder a '$DIR'"; exit 1; }

echo -e "\n>>> Contenido del directorio '$DIR':"
ls -lh

echo -e "\n=== Fin del script ==="
