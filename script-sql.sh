#!/bin/bash

echo "Esto es el inventario de amongmeme"
echo "=================================="


echo "¿Que quieres hacer?"
echo "-------------------"

echo "1.- Mostrar Personajes"
echo "2.- Mostrar Inventario de un Personaje"
echo "3.- Salir"

read INPUT

if [ "$INPUT" == "3" ] || [ "$INPUT" == "" ]; then
	echo "Pos hasta luego"
	exit 0
fi


if [ "$INPUT" == "1" ]; then
	echo "Personajes:"

	echo "select id_character,name from characters" | mysql -u enti -p amongmeme

elif [ "$INPUT" == "2" ]; then
	echo "Iventario:"

else
	echo "Opción Incorrecta"

fi
