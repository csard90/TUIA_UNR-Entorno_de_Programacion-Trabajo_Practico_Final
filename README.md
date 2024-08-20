# Trabajo Práctico Final - Entorno de Programación - TUIA
## Integrantes: 

Comisión I
* DEMARRÉ ESTOFAN, Lucas Federico
* DONNARUMMA, César Julián

# Documentación
## Desplegar Docker:
En el GitHub se encuentra un archivo llamado *"Dockerfile"*, este archivo servirá para crear la imagen que se usará para la ejecución de la aplicación. 
Por lo tanto, lo primero sería descargar el repositorio junto al archivo *"Dockerfile"*

Luego, suponiendo que ya se tenga instalado Docker, lo siguiente sería crear la imagen con el comando: ***"docker build -t edp_img ."*** *'edp_img'* va a ser el nombre que se le dé a la imagen y el *'.'* representa el directorio donde se encuentra el Dockerfile, es decir, el directorio actual.

![Screenshot from 2022-07-30 23-31-00](https://user-images.githubusercontent.com/88700518/182007141-47ba0783-8135-42d6-b724-18a93d83c6b1.png)

*Si es necesario, se puede ingresar directamente como usuario root con el comando **"sudo su"** y así facilitar el trabajo a la hora de ingresar comando de docker.*

Después de ya haber creado la imagen, lo siguiente es correrla. Para ello, ejecutamos el comando ***"docker run -it edp_img"**, 
el parámetro *'-it'* nos permitirá interactuar, a través de la consola, con el contenedor. Recibiremos esta confirmación visual en la consola:

![Screenshot from 2022-07-30 23-33-48](https://user-images.githubusercontent.com/88700518/182007202-c7275231-2d62-420d-9bff-8cb4813b6ab0.png)

## Desplegar aplicación:
Una vez ya estemos en la consola del contenedor, necesitamos movernos a la carpeta llamada *"TUIA_EDP"*, en dicha carpeta se encuentran el texto y
todos los scripts que se utilizarán. Para movernos a esta carpeta necesitamos ejecutar el comando ***"cd TUIA_EDP/"*** 

![Screenshot from 2022-07-30 23-35-55](https://user-images.githubusercontent.com/88700518/182007243-f2f25336-3d0a-495c-b233-4cb1ead31b1c.png)

Ya estando dentro de la carpeta, ahora toca ejecutar el script *"main.sh"* para lanzar la aplicación. Dicho script sólo acepta un único argumento,
el cuál va a ser la ruta (o nombre si es que está en el mismo directorio) del archivo .txt. En este caso sí está en el mismo directorio, por lo tanto,
sólo escribiremos en consola el siguiente comando: ***"./main.sh texto.txt"***

![Screenshot from 2022-07-30 23-37-14](https://user-images.githubusercontent.com/88700518/182007299-39d1b8fe-9922-47f6-82e3-830e0bd42885.png)

## Funcionamiento de la aplicación:
Ya dentro del script, veremos **10 opciones** a elegir, todas estas opciones son lo que nos permite hacer la aplicación con el texto a analizar o 
salir de la aplicación.

![Screenshot from 2022-08-04 16-19-33](https://user-images.githubusercontent.com/88700518/182937715-3371f66f-c612-4e7c-8c91-1f5bee3a221f.png)

A partir de acá, se puede elegir cualquier opción y el programa va a hacer dicha acción, lo único que se tiene que hacer es seleccionar el número que
corresponda con la opción que deseamos.

![Screenshot from 2022-08-04 16-19-42](https://user-images.githubusercontent.com/88700518/182937701-c804b170-c49b-4033-8659-27cc05f765ad.png)

Luego de haber hecho dicha acción, el programa se cerrará, por lo que, si queremos volver a probar otra opción, es necesario ejecutar nuevamente la
aplicación con el comando ***"./main.sh texto.txt"***

![Screenshot from 2022-08-04 16-19-50](https://user-images.githubusercontent.com/88700518/182937667-dbbfd128-9541-4292-b4ab-c4af89db0eea.png)

*Recordar que, si se le pasa más de un argumento o ninguno o el archivo referenciado no existe, el programa va a devolver un error y se cerrará. 
Lo que hará que se tenga que ejecutar de nuevo con el comando anterior en caso de querer probar diferentes opciones.*
