# Servidor de Impresión en Windows

### Configuración inicial

-Para esta práctica necesitaremos un Windows Server y Windows7 que harán lo roles de servidor y cliente.

-Realizaremos las configuraciones estándar en ambas máquinas.

## Impresora compartida

 ### Rol impresión

 -En el servidor instaleremos el rol de impresión con la opción de impresión internet.

 ![](1.JPG)
 ![](2.JPG)

 ### Instalar impresora PDF

 -Para está practica simularemos una impresora con el programa PDFCreator que descargaremos desde su página web oficial.

 -Al iniciar la instalación es posible que le programa requiera instalar componentes adicionales para su funcionamiento.

 ![](3.JPG)

 -Una vez instalado entraremos en perfiles/guardar y marcaremos automático.

  ![](4.JPG)

  ### Probar la impresora en local

  -Probamos la impresora creando un archivo de texto desde el bloc de notas y dandole a imprimir.

  ![](5.JPG)

  ![](6.JPG)

  ## Compartir por red

  -En el servidor nos dirigimos a *herramientas administrativas/administración de impresión/todas_las_impresoras* y presionamos botón derecho sobre PDFCreator. En la pestaña compartir *marcamos compartir esta impresora* y ponemos como nombre de recurso *PDFAyoze07*.

  ![](10.JPG)

  -Ahora desde el cliente nos dirigimos a "Recursos de red" y buscamos el recurso compartido. Si tarda o no aparce podemos buscarlo desde la barra de navegación escribiendo la ip del servidor.
  Nos pedirá un usuario/clave para acceder al servidor.   --Una vez introducido, seleccionamos la impresora y con botón derecho damos en conectar.

  ![](11.JPG)

  -Ya podemos imprimir de forma remota.

  ![](12.JPG)

  ## Acceso Web

  ### Instalar característica impresión WEB

  -Desde la máquina cliente nos dirigimos al navegador para localizar la impresora de una forma distinta.

  -Escribimos la *\\192.168.1.17\printers*, nos volverá a pedir usuario/clave para acceder.

  ![](13.JPG)

  -Una vez dentro buscaremos la opción de propiedades y apuntaremos los datos que nos proporciona.

 ![](14.JPG)  

### Comprobar desde el navegador

-Desde el servidor accederemos mediante el navegador a la impresora y pondremos el servicio en pausa.

![](15.JPG)  

-Ahora desde el cliente intentaremos imprimir un documento a ver que pasa.

![](16.JPG)  

-Como podemos observar se queda en cola hasta que reanudemos el servcio.

# Servidor de Impresión GNU/Linux (CUPS)

-Para esta práctica necesitaremos 2 máquinas GNU/Linux, que harán las veces de servidor y cliente.

## Servidor de Impresión

-En el servidor instalaremos el servicio **CUPS**.  
Para ello nos dirigimos a la terminal y escribimos:
*zypper install cups* y una vez instalado comprobamos el estado del servicio.

![](21.JPG)

-Para configurar el servicio nos dirgimos al ficher */etc/cups/cupsd.conf* deajndolo de la siguinte manera:

![](22.JPG)
![](23.JPG)

-Reiniciamos el servicio y a continuación acedemos al servicio a través del navegador con *localhost:631* y nos dirigimos a la pestaña de administración.

![](24.JPG)

-Una vez allí en las opciones del servidor accedemos a "ver archivo de regsitro de accesos".
Nos pedirá usuario/clave para acceder.

![](25.JPG)

## Imprimir de forma local

-Para probar nuestro servicio de impresión instalaremos "cups-pdf" en el servidor.

![](26.JPG)

-Una vez instalado crearemos un archivo con extensión TXT o Odf y lo intetaremos imprimir.

![](27.JPG)

-El archivo una vez creado lo encontramos en el directorio
*/var/spool/cups-pdf/ayoze*

![](28.JPG)

## Imprimir de forma remota

-En el servidor habilitamos la impresora como recurso de red compartido.

![](30.JPG)

-Por último desde el cliente accedemos a la impresora con el navegador.

![](31.JPG)
