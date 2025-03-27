@echo off
echo === Ejecutando el script en Windows ===

echo Hola Mundo > mytext.txt
echo Archivo 'mytext.txt' creado con contenido.

echo Contenido del archivo 'mytext.txt':
type mytext.txt

if not exist backup (
    mkdir backup
    echo Carpeta 'backup' creada.
)

move mytext.txt backup\
echo Archivo 'mytext.txt' movido a 'backup'.

echo Contenido de la carpeta 'backup':
dir backup

timeout /t 2 >nul

del backup\mytext.txt
echo Archivo 'mytext.txt' eliminado de 'backup'.

rmdir backup
echo Carpeta 'backup' eliminada.

echo === Fin del script ===
pause
