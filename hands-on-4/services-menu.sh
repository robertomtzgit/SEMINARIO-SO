#!/bin/bash

while true; do
    clear
    echo "================================"
    echo "     Menú de Servicios Bash     "
    echo "================================"
    echo "[1] Listar el contenido de un directorio"
    echo "[2] Crear un archivo de texto"
    echo "[3] Comparar dos archivos de texto"
    echo "[4] Sustituir palabras en un archivo con awk"
    echo "[5] Buscar una palabra en un archivo con grep"
    echo "[6] Salir"
    echo "--------------------------------"
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1)
            echo "---- Listar el contenido de un directorio ----"
            read -p "Ingrese la ruta absoluta del directorio: " dir
            if [ -d "$dir" ]; then
                echo "Contenido del directorio:"
                ls -lh "$dir"
            else
                echo "Error: El directorio no existe."
            fi
            read -p "Presione enter para continuar..."
            ;;
        2)
            echo "---- Crear un archivo de texto ----"
            read -p "Ingrese el nombre del archivo (sin extensión): " archivo
            read -p "Ingrese el contenido del archivo: " contenido
            echo "$contenido" > "${archivo}.txt"
            echo "Archivo '${archivo}.txt' creado con éxito."
            ls -l "${archivo}.txt"
            echo "Contenido del archivo:"
            cat "${archivo}.txt"
            read -p "Presione enter para continuar..."
            ;;
        3)
            echo "---- Comparar dos archivos de texto ----"
            read -p "Ingrese la ruta del primer archivo: " archivo1
            read -p "Ingrese la ruta del segundo archivo: " archivo2
            if [[ -f "$archivo1" && -f "$archivo2" ]]; then
                echo "Diferencias entre los archivos:"
                diff "$archivo1" "$archivo2" || echo "No hay diferencias."
            else
                echo "Error: Uno o ambos archivos no existen."
            fi
            read -p "Presione enter para continuar..."
            ;;
        4)
            echo "---- Sustituir palabras en un archivo con awk ----"
            read -p "Ingrese la ruta del archivo: " archivo
            if [ -f "$archivo" ]; then
                read -p "Ingrese la palabra a reemplazar: " palabra_reemplazar
                read -p "Ingrese la nueva palabra: " sustituto
                echo "Archivo antes del reemplazo:"
                cat "$archivo"
                awk -v old="$palabra_reemplazar" -v new="$sustituto" '{gsub(old, new); print}' "$archivo" > temp.txt && mv temp.txt "$archivo"
                echo "Reemplazo completado."
                echo "Archivo después del reemplazo:"
                cat "$archivo"
            else
                echo "Error: El archivo no existe."
            fi
            read -p "Presione enter para continuar..."
            ;;
        5)
            echo "---- Buscar una palabra en un archivo con grep ----"
            read -p "Ingrese la ruta del archivo: " archivo
            if [ -f "$archivo" ]; then
                read -p "Ingrese la palabra a buscar: " palabra
                echo "Resultados de la búsqueda:"
                grep --color=auto "$palabra" "$archivo" || echo "No se encontraron coincidencias."
            else
                echo "Error: El archivo no existe."
            fi
            read -p "Presione enter para continuar..."
            ;;
        6)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Intente de nuevo."
            ;;
    esac
done
