# DS POR COMANDOS

## Instalar Servidor LDAP

- Abrimos la terminal y nos damos privilegios de superusuario.

- Hacemos "*zypper in 389-ds*" para instalar el servicio.

- Una vez instalado crearemos el fichero "**/root/instance.inf**" con los datos de nuestro servidor.

![](./img/1jp)

- Ejecutamos el siguiente comando para instalar la instancia en el LDAP. "*dscreate -v from-file /root/instance.inf*" y comprobamos el estado del servicio con "*dsctl localhost status*".

![](2.jpg)

- Creamos el fichero **/root/.dsr** con el siguiente contenido para proporcionar los permisos.

![](3.jpg)

- Comprobamos el servicio con "*systemctl status dirsrv@localhost*"

![](4.jpg)

- Instalamos el comando **nmap** y ejecutamos el siguiente comando para comprobar que nuestro LDAP es accesible desde la red.

![](5.jpg)

- Para comprobar el acceso al contenido del LDAP ejecutamos los siguientes comandos "*ldapsearch -b "dc=ldap07,dc=curso2021" -x | grep dn*" y "*ldapsearch -H ldap://localhost -b "dc=ldapXX,dc=curso2021" -W -D "cn=Directory Manager" | grep dn*" ("esté último nos pedira contraseña")

![](6.jpg)

- Comprobamos que se han creado las unidades organizativas (OU) ejecutando el siguiente comando.

![](7.jpg)

## Creación de Usuarios

- Ahora añadiremos un usuario.
Para ello crearemos el fichero "*mazinger-add.ldif*" con los siguientes registros:

![](8.jpg)

- Ejecutamos el siguiente comando para actualizar el LDAP con los datos del usuario que hemos creado.
"*ldapadd -x -W -D "cn=Directory Manager" -f mazinger-add.ldif*"
y comprobamos si se ha unido correctamente al LDAP.
"*ldapsearch -W -D "cn=Directory Manager" -b "dc=ldap07,dc=curso2021" "(uid=*)"*"

![](9.jpg)

- Para eliminar a este usuario crearemos el fichero **mazinger-delete.ldif** con el contenido que se muestra a continuación y ejecutamos el siguiente comando.

![](10.jpg)

## Claves Encriptadas

- Hasta ahora hemos utilizado una clave en texto plano no segura.
Para utulizar claves encriptadas instalaremos la siguiente herramienta **slappasswd**, ejecutando "*zypper in openldap2*".
Una vez instalada la ejecutamos con un cifrado SSHA con el comando
"*slappasswd -h {SSHA}*" e introducimos nuestra clave.

![](11.jpg)

## Agregamos Más Usuarios

- Por último crearemos los usuarios "**koji, boss y drinfierno**".

![](13.jpg)
