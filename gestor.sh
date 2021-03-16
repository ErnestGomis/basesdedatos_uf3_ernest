#!/bin/bash

DEBUG="1"

echo "Esto es el gestor de amongmeme"
echo "=============================="


echo "¿Que quieres hacer?"
echo "-------------------"

echo "1.- Mostrar Personajes"
echo "2.- Mostrar Inventario de un Personaje"
echo "3.- Crear Personaje"
echo "4.- Crear Item"
echo "5.- Dar Item a Personaje"
echo "6.- Actualiza Personaje"
echo "7.- Eliminar Personaje"
echo "Q.- Salir"

read INPUT

if [ "$INPUT" == "Q" ] || [ "$INPUT" == "q" ] || [ "$INPUT" == "" ]; then
	echo "Pos hasta luego"
	exit 0
fi


if [ "$INPUT" == "1" ]; then
	echo "Personajes:"

	echo "select id_character,name from characters" | mysql -u enti -p amongmeme

elif [ "$INPUT" == "2" ]; then
	echo "Iventario:"
	echo "=========="
	echo "¿De qué personaje quieres ver el inventario?"

	read INPUT

	if [ "$INPUT" == "" ]; then
		echo "Has de introducir algún valor"
		exit 1
	fi 

	QUERY="select * from characters_items_summary where id_character=$INPUT" 
	echo $QUERY | mysql -u consultas amongmeme | cut -d $'\t' -f 4

elif [ "$INPUT" == "3" ]; then

	echo "Inserción de personaje"
	echo "======================"

	echo -n "Name: "
	read NOMBRE

	echo -n "Age: "
	read EDAD

	echo -n "HP: "
	read HP

	echo -n "Gender (1): "
	read GENDER

	echo -n "Style (1): "
	read STYLE

	echo -n "Mana: "
	read MANA

	echo -n "Class (2): "
	read CLASS

	echo -n "Race (2): "
	read RACE

	echo -n "xp: "
	read XP

	echo -n "Level: "
	read LEVEL

	echo -n "Height: "
	read HEIGHT

	QUERY="INSERT INTO characters (name, age, hp, gender, style, mana, class," 
	QUERY="$QUERY race, level, height)"
	QUERY="$QUERY VALUES ('$NAME', '$AGE', '$HP', '$GENDER', '$STYLE', '$MANA', '$CLASS',"
	QUERY="$QUERY '$RACE', '$XP', '$LEVEL', '$HEIGHT')"
	
	if [ "$DEBUG" == "1" ]; then
		echo $QUERY
	fi

	echo $QUERY | mysql -u gestor amongmeme

elif [ "$INPUT" == "5" ]; then
	echo "¿Que personaje quieres usar?"
	read CHARACTER

	echo "¿Que item quieres darle? (id_item)"
	read ITEM

	QUERY="INSERT INTO characters_items (id_character, id_item)"
	QUERY="$QUERY VALUES ($ID_CHARACTER, $ID_ITEM)";

	if [ "$QUERY" == "1" ]; then
		echo "$QUERY"
	fi

	echo $QUERY | mysql -u gestor amongmeme

elif [ "$INPUT" == "6" ]; then
	echo "¿Qué personaje quieres actualizar? Introduce el nombre (o parte)"
	read NOMBRE

	LEN=`echo -n $NOMBRE | wc -c`

	if [ $LEN -lt 4 ]; then
		echo "Error en el largo del nombre: ha de ser igual o mayor que 4"
		exit 1
	fi
	
	QUERY="SELECT id_character FROM characters WHERE name LIKE '%$NOMBRE%'"
	CHAR=`echo $QUERY | mysql -u gestor amongmeme | tail -n 1`
	
	if [ "$CHAR" == "" ]; then
		echo "ERROR: Nombre no encontrado"
		exit 4
	fi

	ID_CHAR=`echo $CHAR | cut -f 1`
	CHAR_NAME=`echo $CHAR | cut -f 2`

	echo "Nombre completo: $CHAR_NAME"
	echo -n "Introduce el nuevo nombre: "

	read NOMBRE
	
	if [ "$NOMBRE" == "" ]; then
		echo "ERROR: Debes introducir un nombre"

		exit 2
	fi

	if [ `echo $NOMBRE | wc -c` -lt 4 ]; then
		echo "ERROR: el nombre es más corto de 4 carácteres"

		exit 3
	fi

	QUERY="UPDATE characters SET name='$NOMBRE' WHERE id_character=$ID_CHAR"

	echo $QUERY | mysql -u gestor amongmeme

elif [ "$INPUT" == "7" ]; then
	echo "Introduce password de Admin"
	read -s PASS

	echo "Introduce el nombre (o parte) del personaje a eliminar:"
	read NOMBRE

	LEN=`echo -n $NOMBRE | wc -c`

	if [ $LEN -lt 4 ]; then
		echo "Error en el largo del nombre: ha de ser igual o mayor que 4"
		exit 1
	fi

	QUERY="SELECT id_character FROM characters WHERE name LIKE '%$NOMBRE%'"
	echo $QUERY
	ID_CHAR=`echo $QUERY | mysql -u gestor amongmeme | tail -n 1`

	if [ "$ID_CHAR" == "" ]; then
		echo "No hay coincidencias"
		exit 2
	fi
	
	QUERY="DELETE FROM characters_items WHERE id_character$ID_CHAR"
	#echo $QUERY
	echo $QUERY | mysql -u gestor -p$PASS amongmeme

	QUERY="DELETE FROM characters WHERE id_character=$ID_CHAR'"
	#echo $QUERY
	echo $QUERY | mysql -u gestor -p$PASS amongmeme


else
	echo "Opción Incorrecta"

fi


