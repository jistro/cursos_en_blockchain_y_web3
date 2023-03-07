<img title="" src="./img/10 img1.png" alt="" width="100" data-align="center">

# ¿Qué es el Interplanetary FileSystem?

Es un sistema de almacenamiento peer-to-peer este permite el almacenamiento de datos y archivos de manera descentralizada y rápida, siempre y cuando exista una persona que tenga el archivo o dato en al menos un nodo

# Como funciona

Para en tender esto debemos comprender la idea de como funciona un sistema centralizado de almacenamiento, digamos que pedimos una imagen, esta se ubica en una dirección de ip o el nombre de domino, este método se llama _direccionamiento basado en la ubicación_ esto es bueno cuando queramos obtener el documento de una forma simple pero si por algún motivo ese documento no esta disponible debido a que el servidor esta cerrado ya sea porque el servicio ya no existe o por censura de algún gobierno este es por obvios motivos inaccesible

<img src="./img/10%20img2.png" title="" alt="" data-align="center">

Sabemos que descargamos esa imagen pero por ser el internet tal y como es no existen dudas de que alguien también tenga esa imagen igual. 

Entonces, ¿como entra IPFS en esto? simple, IFFS permite el intercambio de este contenido mediante un sistema de _direccionamiento basado en el contenido_ es decir que en vez de decir donde encontrar ese recurso, solicitamos que es lo que queremos.

Para ello cada documento tiene su propia llave hash podríamos asimilarlo a como las huellas dactilares definen que persona es, entonces el cliente solicita en la red quien tiene ese documento con el hash _x_ y alguien en la red lo proporciona, talvez suena a lo mismo que hemos visto en programas como Torrent o "ares" y nos llega la pregunta ¿como sabemos que el documento no ha sido modificado? la respuesta es simple y es mediante el hash, este se modifica no importa el mas mínimo cambio, es decir si tenemos un documento llámese "imagen.img" y editamos un solo pixel de este, el hash se modifica completamente, esto hace que IPFS detecte si el hash del documento es el correcto y de no ser así, el sistema lo rechaza y buscara otro

Otra cosa interesante de IPFS es que tiene un sistema de deduplicación , esto es debido a que si existe un documento que se quiera subir a la red con las mismas propiedades y mismas características  (generando así el mismo hash) este nuevo documento duplicado será rechazado y en vez se dará el hash del documento original que existe en la red haciendo la red mas eficiente.

# Como almacena los datos

IPFS almacena mediante IPFS objects, estos pueden almacenar hasta 256kb de datos y además de poder contener uniones (links) a otros objetos 

<img src="./img/10%20img3.png" title="" alt="" data-align="center">

El dato "hola" que tenemos como ejemplo en el sistema ascii ocupa 20 bytes por lo tanto se puede almacenar en un objeto, pero que pasaría con datos que tengan mas de 250kb, pensemos en datos de 1, 2, 3 o mas mega bytes, bueno estos se dividen en varios objetos IPFS creando un objeto maestro que hará la función de unir todos esos pedazos en uno solo.

<img src="./img/10%20img4.png" title="" alt="" data-align="center">

Debemos tener en cuenta que este sistema de almacenamiento es inmutable al igual que las redes de blockchain, pero entonces ¿como podemos editar documentos y subirlos a la red?

IPFS si bien es un sistema inmutable podemos permitir la edición y almacenamiento de cambios mediante el uso de "versionamiento", digamos que subimos un archivo de texto y este lo vamos a compartir con varias personas, este se va editando por la persona que lo genero durante x tiempo, para ello IPFS crea un objeto tipo _commit_ que permite el guardar estas modificaciones, este objeto commit simplemente apunta que commit o commits fueron antes y lo direcciona al objeto IPFS del documento, pensémoslo como commits en git. El sistema de IPFS garantiza que el archivo junto con todo el historial de modificaciones sea accesible para otro nodos

<img src="./img/10%20img5.png" title="" alt="" data-align="center">

# Limitaciones de la red

Si bien esto parece un sistema perfecto IPFS tiene sus limitantes y este es mantener los archivos disponibles.

El gran problema de la red es mantener esos archivos disponibles, recordando lo que hemos dicho anteriormente IPFS toma el archivo de alguien que ya lo tiene anteriormente, esto indica que si la ultima persona que tiene este archivo lo borra este desaparece de la red 

Esto se puede evitar incentivando a los nodos a guardar esta información o proactivamente distribuir estos archivos, algo que podemos hacer de manera manual o usando ostros sistemas como filecoin 
