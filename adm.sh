#!/bin/bash
op=0
op1=0
op2=0
op3=0
op6=0
op7=0

# Voy a usar tput para probar a poner colores al texto

Rojo='tput setaf 1'
Verde='tput setaf 2'
Amarillo='tput setaf 3'
Azul='tput setaf 4'
Magenta='tput setaf 5'
Cian='tput setaf 6'
Blanco='tput setaf 7'
Negro='tput setaf 0'
while [ "$op" -ne 6 ]
do  
    clear
        $Rojo
        echo "**********************************"
	echo "*              MENU              *"
	echo "**********************************"
    $Amarillo	
    echo "1. Administrar ficheros"
    $Verde
    echo "2. Informacion del sistema"
    $Azul
    echo "3. Administrar usuarios y grupos"
    $Magenta
    echo "4. Paquetes (APT)"
    $Cian
    echo "5. Visor de archivos"
    $Negro
    echo "6. Salir"
    read -p "Ingrese una opcion: " op
        
    case $op in
        1)  while [ "$op1" -ne 7 ]
            do
                clear
		$Amarillo
                echo "1. Crear un fichero"
                echo "2. Modificar permisos de fichero o directorio"
                echo "3. Eliminar un fichero"
                echo "4. Copiar un fichero a otra ruta"
                echo "5. Listar un directorio en formato largo"
                echo "6. Respaldar un directorio"
                echo "7. Salir"
                read -p "Ingrese una opcion: " op1
    
                case $op1 in
                    1)  read -p "Ingrese el nombre que desea ponerle al archivo: " archivo0
			            if ( test -f "$archivo0" ) then
                            echo "Ya existe el archivo $archivo0"
                        else
                            touch "$archivo0"
                        fi
                        read -p "Presione Enter para continuar...";;
                    2)  read -p "Ingrese el nombre del archivo o directorio: " nombre
		    	        if ( test -d "$nombre" ) then
                            read -p "Ingrese los permisos (ej: 700 o u+rwx): " permisos
                            chmod $permisos "$nombre"
		    	        elif ( test -f "$nombre" ) then
                            read -p "Ingrese los permisos (ej: 700 o u+rwx): " permisos
                            chmod $permisos "$nombre"
			                ls -l $nombre
                        else
                            echo "El archivo o directorio no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    3)  read -p "Ingrese el nombre del fichero a borrar: " archivo1
	        		    if ( test -f "$archivo1" ) then
                            rm -i "$archivo1"
                        else
                            echo "El archivo $archivo1 no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    4)  read -p "Ingrese el nombre del archivo a copiar: " archivo2
			            if ( test -f "$archivo2" ) then
                            read -p "Ingrese la ruta destino (ej: /home): " ruta
                            cp "$archivo2" "$ruta"
                        else
                            echo "El archivo $archivo2 no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    5)  read -p "Ingrese el nombre del directorio a listar: " directorio0
			            if ( test -d "$directorio0" ) then
                            ls -la "$directorio0"
                        else
                            echo "El directorio $directorio0 no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    6)  read -p "Ingrese el nombre del directorio a respaldar: " directorio1
			            if ( test -d "$directorio1" ) then
                            read -p "Ingrese la fecha (ej: 8Agosto2025): " fecha
                            tar -czvf "${directorio1}_${fecha}a.tar.gz" "$directorio1"
                        else
                            echo "El directorio $directorio1 no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    7)  ;;
                    *)  echo "Opcion incorrecta"
                        read -p "Presione Enter para continuar...";;
                esac
            done;;
        2)  while [ "$op2" -ne 4 ]
            do
                clear
		$Verde
                echo "1. Uso de disco"
                echo "2. Uso de RAM"
                echo "3. Usuarios conectados"
                echo "4. Salir"
                read -p "Ingrese una opcion: " op2

                case $op2 in
                    1)  df -h
                        read -p "Presione Enter para continuar...";;
                    2)  free -h
                        read -p "Presione Enter para continuar...";;
                    3)  users
                        read -p "Presione Enter para continuar...";;
                    4)  ;;
                    *)  echo "Opcion incorrecta"
                        read -p "Presione Enter para continuar...";;
                esac
            done;;
        3)  while [ "$op3" -ne 8 ]
            do  
                clear
		$Azul
                echo "1. Crear un usuario"
                echo "2. Eliminar usuario"
                echo "3. Agregar usuario a grupos secundarios y listar pertenencia"
                echo "4. Cambiar el grupo principal de un usuario"
                echo "5. Crear y eliminar grupos"
                echo "6. Gestionar password de grupo"
                echo "7. Listar usuarios y grupos"
                echo "8. Salir"
                read -p "Ingrese una opcion: " op3

                case $op3 in
                    1)  read -p "Ingrese el nombre del usuario: " nomUser
                        grep "$nomUser" /etc/passwd >> usuarios.txt
			if ( test -s usuarios.txt ) then
                            echo "El usuario $nomUser ya existe"
                        else
                            read -p "Ingrese el nombre del directorio home: " directorioHome
                            read -p "Ingrese la ruta del shell (ej: /bin/bash): " shellUser
                            sudo useradd -m -s "$shellUser" -d "/home/${directorioHome}" "$nomUser"
                            echo "Ingrese la contraseña: "
                            sudo passwd "$nomUser"
                        fi
                        read -p "Presione Enter para continuar...";;
                    2)  read -p "Ingrese el nombre del usuario a eliminar: " nomUser1
                        grep "$nomUser1" /etc/passwd >> archusuarios.txt
			if ( test -s archusuarios.txt ) then
                            sudo userdel "$nomUser1"
                        else
                            echo "El usuario $nomUser1 no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    3)  read -p "Ingrese el nombre del grupo secundario: " grupoSec
                        grep "$grupoSec" /etc/group >> archgrupos.txt
			if ( test -s archgrupos.txt ) then
                            read -p "Ingrese el usuario a agregar: " nomUser2
                            grep "$nomUser2" /etc/passwd >> archusuarios1.txt
			    if ( test -s archusuarios1.txt ) then
                                sudo usermod -aG "$grupoSec" "$nomUser2"
                                echo "El usuario pertenece a: "
                                id "$nomUser2"
                            else
                                echo "El usuario $nomUser2 no existe"
                            fi
                        else
                            echo "El grupo $grupoSec no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    4)  read -p "Ingrese el nuevo grupo principal: " grupoPrinci
                        grep "$grupoPrinci" /etc/group >> archgrupos1.txt
			if ( test -s archgrupos1.txt ) then
                            read -p "Ingrese el usuario: " nomUser3
                            grep "$nomUser3" /etc/passwd >> archusuarios2.txt
			    if ( test -s archusuarios2.txt ) then
                                sudo usermod -g "$grupoPrinci" "$nomUser3"
                            else
                                echo "El usuario $nomUser3 no existe"
                            fi
                        else
                            echo "El grupo $grupoPrinci no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    5)  read -p "Ingrese 1 para crear grupo o 2 para eliminarlo: " op4
                        if [ "$op4" -eq 1 ]; then
                            read -p "Ingrese el nombre del grupo: " nomGrupo
                            grep "$nomGrupo" /etc/group >> archgrupos2.txt
                            if test -s archgrupos2.txt; then
                                echo "El grupo $nomGrupo ya existe"
                            else
                                sudo addgroup "$nomGrupo"
                            fi
                        elif [ "$op4" -eq 2 ]; then
                            read -p "Ingrese el grupo a eliminar: " nomGrupo1
                            grep "$nomGrupo1" /etc/group >> archgrupos3.txt
                            if test -s archgrupos3.txt; then
                                sudo groupdel "$nomGrupo1"
                            else
                                echo "El grupo $nomGrupo1 no existe"
                            fi
                        else
                            echo "Opcion incorrecta"
                        fi
                        read -p "Presione Enter para continuar...";;
                    6)  read -p "Ingrese el grupo: " nomGrupo2
                        grep "$nomGrupo2" /etc/group >> archgrupos4.txt
			if ( test -s archgrupos4.txt ) then
                            echo "Ingrese una contraseña para el grupo: "
                            sudo gpasswd "$nomGrupo2"
                        else
                            echo "El grupo $nomGrupo2 no existe"
                        fi
                        read -p "Presione Enter para continuar...";;
                    7)  read -p "Ingrese 1 para usuarios o 2 para grupos: " op5
                        if [ "$op5" -eq 1 ]; then
                            echo "Usuarios del sistema: "
                            cat /etc/passwd
                        elif [ "$op5" -eq 2 ]; then
                            echo "Grupos del sistema: "
                            cat /etc/group
                        else
                            echo "Opcion incorrecta"
                        fi
                        read -p "Presione Enter para continuar...";;
                    8)  ;;
                    *)  echo "Opcion incorrecta"
                        read -p "Presione Enter para continuar...";;
                esac
            done;;
	4)      while [ "$op6" -ne 6 ]
	        do 
	           clear
		   $Magenta
	           echo "1. Buscar un paquete con apt search"
	           echo "2. Instalar paquete"
	           echo "3. Actualizar indices"
	           echo "4. Actualizar paquetes"
	           echo "5. Limpiar paqutes y cache"
	           echo "6. Salir"
	           read -p "Ingrese una opcion: " op6
	           case $op6 in
    	           1) read -p "Ingrese el nombre del paquete que desea buscar: " nombrePaquete
    	              apt search $nombrePaquete
    	              read -p "Presione Enter para continuar...";;
    	           2) sudo apt update
    	              read -p "Ingrese el nombre del paquete que desea instalar: " nombrePaquete1
    	              sudo apt install $nombrePaquete1
    	              read -p "Presione Enter para continuar...";;
    	           3) sudo apt update
    	              read -p "Presione Enter para continuar...";;
    	           4) sudo apt upgrade
    	              read -p "Presione Enter para continuar...";;
    	           5) sudo apt autoremove
    	              sudo apt autoclean
    	              read -p "Presione Enter para continuar...";;
    	           6) ;;
    	           *) echo "Opcion incorrecta"
                      read -p "Presione Enter para continuar...";;
	           esac
	        done;;
	5)      while [ "$op7" -ne 6 ]
	        do
		   clear
		   $Cian
	           echo "1. Ver archivo con cat"
	           echo "2. Ver archivo con less"
	           echo "3. Mostrar primeras lineas con head"
	           echo "4. Mostrar ultimas lineas con tail"
	           echo "5. Explicacion de diferencia entre cat y less"
	           echo "6. Salir"
	           read -p "Ingrese una opcion: " op7
	        case $op7 in
	                1) read -p "Ingrese nombre del archivo a visualizar con cat: " archivoVisualizar
	                   cat $archivoVisualizar
	                   read -p "Presione Enter para continuar...";;
	                2) read -p "Ingrese nombre del archivo a visualizar con less: " archivoVisualizar1
	                   less $archivoVisualizar1
	                   read -p "Presione Enter para continuar...";;
	                3) read -p "Ingrese la cantidad de lineas: " numlineas
	                   read -p "Ingrese nombre del archivo a visualizar con head: " archivoVisualizar2
	                   head -n $numlineas $archivoVisualizar2
	                   read -p "Presione Enter para continuar...";;
	                4) read -p "Ingrese la cantidad de lineas: " numlineas1
	                   read -p "Ingrese nombre del archivo a visualizar con tail: " archivoVisualizar3
	                   tail -n $numlineas1 $archivoVisualizar3
	                   read -p "Presione Enter para continuar...";;
	                5) echo "La diferencia entre cat y less es que cat muestra todo el contenido del archivo de una sola vez"
	                   echo "mientras que less permite avanzar y retroceder en el contenido en paginas, lo que lo hace ideal para archivos extensos"
	                   read -p "Presione Enter para continuar...";;
	                6) ;;
                    *) echo "Opcion incorrecta"
                       read -p "Presione Enter para continuar...";;
	        esac
	        done;;
	6) ;;
	*) $Negro
	   echo "Opcion incorrecta"
	   read -p "Presione Enter para continuar...";;
    esac
done