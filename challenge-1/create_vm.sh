#!/bin/bash

# Ruta de VBoxManage
VBOX="/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"

# Solicitar al usuario los datos
read -p "Nombre de la máquina virtual: " VM_NAME
read -p "Tamaño del disco (en MB, ejemplo 10000): " DISK_SIZE
read -p "Cantidad de RAM (en MB, ejemplo 2048): " RAM_SIZE
read -p "Número de CPUs: " CPU_COUNT
read -p "¿Qué ISO deseas usar? (1 para Debian, 2 para Ubuntu): " ISO_OPTION

# Variables ISO y tipo de sistema operativo
if [ "$ISO_OPTION" = "1" ]; then
    ISO_PATH="C:\\Users\\rober\\Documentos\\Virtual Machines\\debian-12.4.0-amd64-DVD-1.iso"
    OS_TYPE="Debian_64"
elif [ "$ISO_OPTION" = "2" ]; then
    ISO_PATH="C:\\Users\\rober\\Documentos\\Virtual Machines\\ubuntu-24.04.1-desktop-amd64.iso"
    OS_TYPE="Ubuntu_64"
else
    echo "Opción inválida. Saliendo..."
    exit 1
fi

# Crear la máquina virtual
"$VBOX" createvm --name "$VM_NAME" --register

# Configurar hardware
"$VBOX" modifyvm "$VM_NAME" --memory "$RAM_SIZE" --cpus "$CPU_COUNT" --ostype "$OS_TYPE" --nic1 nat

# Crear carpeta si no existe
mkdir -p "$HOME/VirtualBox VMs/$VM_NAME"

# Crear disco duro
"$VBOX" createmedium disk --filename "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi" --size "$DISK_SIZE"

# Agregar el disco a la VM
"$VBOX" storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
"$VBOX" storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi"

# Agregar ISO
"$VBOX" storagectl "$VM_NAME" --name "IDE Controller" --add ide
"$VBOX" storageattach "$VM_NAME" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$ISO_PATH"

# Configurar orden de arranque correctamente
"$VBOX" modifyvm "$VM_NAME" --boot1 dvd --boot2 disk --boot3 none --boot4 none

echo "Maquina '$VM_NAME' creada correctamente con ISO: $ISO_PATH"
