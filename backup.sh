#!/bin/bash

if [ "$1" == "" ]; then
	echo "Indica el nombre del archivo: "
	echo -e "\t$0 NOMBRE_ARCHIVO"

	exit 1
fi 

mysqldump -u backup amongmeme > /tmp/$1

tar czf $1.tar.gz --absolute-names /tmp/$1

rm $1

exit 0
