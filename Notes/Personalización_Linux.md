
## Iniciando la configuración del sistema


1. Inicialmente, al tener instalado ya nuestro sistema operativo parrot. Como primer paso, realizaríamos un update. Aquí podríamos llegar a encontrarnos con un problema al realizar él:

	```
		sudo apt update
	```

	el cual se muestra de la siguiente manera:
	 ![[IMG_0001.jpeg]]
2. Para solucionar este problema tendríamos que acceder a la ruta del archivo mostrado y comentar una de las líneas, ya que este error se da debido a que está dos veces la misma línea:

	```
		sudo vim /etc/apt/sources.list.d/parrot.list
	```
	 
	 (actualmente, para la última versión de parrot este problema ha sido totalmente solucionado)
3. En parrot no podremos realizar un upgrade como en otras versiones de Linux, ya que esto podría romper el sistema; por lo tanto, en su lugar emplearemos un comando propio de parrot:

	```
		 sudo parrot-upgrade
	```
	 
	 Esto actualizaría correctamente todas las listas de paquetes del sistema.
	 
4. En caso de que nos indique que podría ser necesario remover algún paquete con:

	```
		 sudo apt autoremove
	```
	 
	 Lo más recomendable sería no realizarlo de esta manera, debido a que puede terminar borrando un montón de paquetes que es posible que quisiéramos mantener en el sistema.

	Una forma de ver qué cosas terminaría borrando sería ejecutando:
	 
	```
		 sudo apt autoremove —-dry-run
	```

	Pero en todo caso, lo mejor sería utilizar como alternativa:
	 
	```
		 sudo apt remove <binario a eliminar>
	```


## ¿Que es *Bspwm* y *Sxhkd*?

1. #### *Bspwm (Binary Space Partitioning Window Manager)*

	*Bspwm* es un gestor de ventanas que utiliza la técnica de partición binaria del espacio para organizar las ventanas del escritorio. Es conocido por su simplicidad y eficiencia, ya que se configura y se controla exclusivamente a través de scripts y comandos en terminal.
	Bspwm no maneja teclados ni otros dispositivos de entrada por sí mismo, sino que delega esta tarea a otras herramientas, lo que permite una mayor personalización y flexibilidad.
	
	Cada ventana se organiza automáticamente de manera que ocupe un área divisoria del espacio disponible en el escritorio, optimizando el uso de espacio y facilitando la navegación entre diferentes aplicaciones y documentos abiertos.
	</br>
1. #### *Sxhkd (Simple X Hotkey Daemon)*

	*Sxhkd* es un demonio de teclas de acceso rápido para sistemas X Window. Funciona en conjunto con gestores de ventanas como ==Bspwm== y permite a los usuarios asignar acciones a combinaciones de teclas y botones del mouse. Su configuración se realiza a través de un archivo de texto plano , donde el usuario define combinaciones de teclas y las acciones correspondientes que se deben de ejecutar. ==Sxhkd== es altamente configurable y ligero, diseñado para ser rápido y eficiente en el manejo de eventos de entrada, lo que lo hace ideal para entornos donde los recursos del sistema son limitados o cuando se busca una experiencia de usuario altamente personalizable y controlada.

Ambos programas son muy populares en la comunidad de entusiastas de Linux que prefieren un entorno de escritorio altamente personalizable y orientado al uso del teclado.

## Instalación y configuración de *Bspwm* y *Sxhkd*

1. *bspwm* es importante, ya que será el entorno donde se va a estar trabajando, ya que este es un gestor de ventanas, lo que nos permite sobre este desplegar la polybar y configuraciones que harán que nuestro entorno sea más presentable.

	Por otro lado, pero igual de importante, tendremos el *sxhkd*, el cual nos permitirá configurar todos los atajos de teclado para navegar en nuestro entorno.


	Todo esto proviene de un repositorio en GitHub, de una persona, la que ha realizado este proyecto con estas utilidades.
	</br>


2.  Con esto en mente nos moveríamos a nuestro directorio de descargas:

	```
		cd ~/Downloads
	```


	Antes de empezar a utilizar los recursos mencionados, se tendrán que instalar una serie de paquetes necesarios para todo el proceso. Estos son bastantes paquetes y se instalan con el siguiente comando, estando como usuario root:
	
	```
		sudo su
		apt install build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev
	```

	Al momento de preguntar si queremos instalarlo todo, le damos a la tecla ”Y”.
	</br>


3.  Para la instalación de *bspwm*, regresamos a nuestro usuario no privilegiado, tan solo con el comando:


	```
		exit 
	```

	o 

	```
		su <nombre de usuario>
	```

	Instalamos de forma sencilla y rapida, para evitar problemas de que el sistema no detecte bspwm:

	```
		apt install bspwm
	```

	Y ademas de otra forma, clonamos el repositorio original, el cual pertenece a [Baskerville](https://github.com/baskerville?tab=overview&from=2024-10-01&to=2024-10-27):

	```
		git clone https://github.com/baskerville/bspwm.git
	```

	De una vez, nos traeremos el *sxhkd* también:

	```
		git clone https://github.com/baskerville/sxhkd.git
	```


	Con estos repositorios clonados, tendríamos las carpetas:

	*bspwm/* y *Sxhkd/*

	Para instalarlo, nos iríamos a la carpeta *bspwm/*, y ejecutaríamos los comandos:

	```
		cd bspwm/
		make
		sudo make install
	```

	Con esto listo, podríamos verificar si se instaló con el comando:

	```
		which bspwm
	```

	Si todo ha salido bien, nos regresará la ruta absoluta de este programa, lo que querrá decir que se ha instalado sin problemas.

	Ahora, encontrándonos nuevamente en el directorio *Downloads/* entramos en *sxhkd/*, la instalación va a ser de la misma manera que con bspwm:

	```
		make
		sudo make install
	```

	Y para verificar que esté instalado correctamente:

	```
		which sxhkd
	```
	</br>

4.  Con esto instalado, ahora nos tocaría ver los archivos de configuración, recordando que:

	Para *bspwm*, su archivo de configuración es:
	* ==bspwmrc== 

	Para *sxhkd*, su archivo de configuración es:
	* ==sxhkdrc==

	Pero hasta este momento no es del todo así, ya que estos archivos de configuración aún no se encuentran creados o más bien en su lugar correcto para ser tomados en cuenta por el sistema, por lo que tendríamos que crear dos directorios dentro de nuestro directorio *.config/*:

	```
		mkdir ~/.config/{bspwm,sxhkd}
	```

	Esto crearía los dos directorios dentro de este directorio, el cual es un directorio oculto del sistema.

	Con ello, como aún permanecemos en el directorio *Downloads/*, entramos nuevamente al directorio *bspwm/* y dentro de este en un directorio *examples/* nos dan ambos archivos con una configuración base:

	```
		cd Downloads/bspwm/examples
		ls -l
	```
		
	![[IMG_0003.jpeg]]

	Estos archivos ya contienen una configuración base, pero durante la configuración del entorno le iremos agregando más cositas.

	Por ello realizaríamos una copia de estos archivos de configuración, cada uno a su correspondiente directorio que hemos creado dentro del directorio *.config/*:

	```
		cp bspwmrc ~/.config/bspwm/
		cp sxhkdrc ~/.config/sxhkd/
	```

	Con ello comprobamos que se hayan copeado correctamente:
	
	```
		ls ~/.config/bspwm/
		ls ~/.config/sxhkd/
	```
    ![[IMG_0004.jpeg]]

5. Configurando un poco nuestro *sxhkdrc*:

	En este nos enfocaremos primeramente en el apartado ==# terminal emulador==; este será nuestro atajo por defecto para abrir nuestra terminal y lo que está en la siguiente línea es el comando a ejecutar, en este caso ahí tendríamos que colocar la *kitty*, que es una terminal más completa que estaremos empleando y configurando más adelante.

	Contenido actual en el apartado ==# terminal emulador==:
	
	```
		# terminal emulador
		super + return
			urxvt
	```

	De primeras, esto no funcionaría, ya que si escribimos *urxvt* en terminal, esta terminal no existe y, por ende no se ejecuta nada.

	La terminal que emplea parrot es una *gnome-terminal* y no una ==urxvt==.
	
	Contenido al que se cambiará:
	
	```
		# terminal emulador
		super + return
			Kitty
	```

	Esto es debido a que al presionar la combinación de teclas “windows + enter” nos ejecutaría la terminal kitty.
	</br>


6. Ok. Pero, ¿dónde está mi terminal kitty?

	Esta terminal no existe por defecto, por lo que tendremos que instalarla mediante el siguiente comando:

	```
		sudo apt install kitty
	```

	Esta versión no será la más reciente que emplearemos, pero momentáneamente la dejaremos para más adelante agregar la más reciente. En la fecha actual 26-10-24 se encuentra en la versión ==0.36.4==.

	Se puede verificar la versión de la *kitty* descargada, con el comando:

	```
		Kitty —-version
	```

	La versión más actual podrá verificarse en el repositorio oficial de GitHub.

	Ahora podríamos ver su ruta absoluta con:

	```
		which kitty
	```

	Esto nos dará la ruta absoluta de la *kitty*, si se nos hace mejor, podríamos cambiar *kitty* que será el comando que la ejecute. Por su ruta absoluta, al final de cuentas sería prácticamente lo mismo.

	Una terminal *kitty*, se ve de la siguiente manera:

	![[IMG_0005.jpeg]]


	Ahora mismo se ve algo fea, pero se verá mejor.
	</br>

7. Viendo y configurando algunos atajos de teclado

	En nuestro mismo archivo *sxhkdrc*, podremos observar los atajos de teclado seguidos del apartado ==# quit/restart bspwm==, empezaremos por aquí.

	*bspwm* nos sirve para cargar nuestro entorno, ya que su configuración se carga apenas arranca el sistema, en este podremos definir por ejemplo, que se cargue el fondo de pantalla, que se habilite la clipboard bidireccional para que nos permita copear de afuera de la máquina virtual hacia la máquina virtual y viceversa, entre otras cosas.

	Si estos cambios los hiciéramos mientras utilizamos el sistema, el apartado ==# quit/restart== *bspwm* nos ayudaría a aplicar los cambios sin necesidad de tener que reiniciar el sistema.

	Para esta acción tenemos predeterminado:

	```
		# quit/restart bspwm
		super + alt + {q,r}
			bspc {quit,wm -r}
	```

	Al presionar la combinación de teclas con “q”, cerraríamos o saldríamos del entorno hacia el login; al hacerlo con “r”, reiniciaríamos, lo que quiere decir que tomaría en cuenta la configuración más actual del entorno, lo que sería como recargarlo.

	Una forma mas cómoda para esto seria con shift:

	```
		# quit/restart bspwm
		super + shift + {q,r}
			bspc {quit,wm -r}
	```

	De esta misma forma podríamos modificar el apartado ==# close and kill== para hacerlo un poco más cómodo con el atajo de teclado, el cual está de la siguiente manera:

	```
		# close and kill
		super + {_,shift + }w
			bspc node -{c,k}
	```

	Y sería mayormente cómodo si dejamos que para este sea la "q", en lugar de "w":

	```
		# close and kill
		super + {_,shift + }q
			bspc node -{c,k}
	```


	Esta opción lo que nos permite es cerrar cualquier ventana que tengamos abierta en nuestro entorno. Un ejemplo, sería encontrándonos en uso de nuestra terminal y que necesitemos cerrarla, pues esta combinación de teclas sería la indicada.

	El apartado ==# focus the node in the given direction== nos permite desplazarnos entre ventanas de aplicaciones. Sí tenemos el navegador y una terminal abierta, podríamos movernos de izquierda a derecha y viceversa entre ambas cosas.
	
	Esto como configuración base está de la siguiente manera:

	```
		# focus the node in the given direction
		super + {_,shift + }{h,j,k,l}
		bscp node -{f,s} {west,south,north,east}
	```

	Una forma más cómoda sería poder movernos entre las ventanas con las flechas del teclado, lo cual quedaría de la siguiente manera, definiendo la tecla con la orientación correspondiente:
	
	```
		# focus the node in the given direction
		super + {_,shift + } {Left,Down,Up,Right}
		bspc node -{f,s} {west,south,north,east}
	```

	Con esto directamente vamos al apartado de los preselectores ==# preselect==, estos lo que nos permiten es previsualizar el tamaño que tomará la aplicación una vez sea abierta, lo cual será representado mediante un rectángulo de color amarillo.

	Esto es interesante por si queremos darle un tamaño más pequeño del esperado a la aplicación o en alguna parte específica de las disponibles en el escritorio.

	La forma base sería:

	```
		# preselect the direction
		super + ctrl + {h,j,k,l}
			bspc node -p {west,south,north,east}
	```

	Está bien de esta manera, pero una forma más cómoda sería utilizar las flechas y agregar el "alt" a la combinación ya establecida:

	```
		# preselect the direction
		super + ctrl + {Left,Down,Up.Right}
			bspc node -p {est,south,north,east}
	```


	Después de esto, podríamos definir un tamaño específico con el apartado ==# preselect the ratio==, quedando con las teclas:

	```
		# preselect the ratio
		super + ctrl + {1-9}
		bspc node -o 0.{1-9}
	```


	Ahora bien, si quisiéramos cancelar la preselección y simplemente no seleccionar nada, la opción correcta sería:

	```
		# cancel the preselection for the focused node
		super + ctrl + space
			bspc node -p cancel
	```

	Nuevamente, una mejor forma para esto, es configurándolo como el atajo de teclado:

	```
		# calcel the preselection for the focused node
		super + ctrl + alt + space
			bspc node -p cancel
	```


	Para el apartado ==# move/resize==, eliminamos los primeros dos atajos de teclado, esto es debido a que más adelante configuraríamos un archivo específico para el redimensionamiento.

	En el apartado que nos queda ==# move a floating window==, nos sirve para darnos la posibilidad de mover una pestaña abierta:

	```
		# move a floating window
		super + {Left,Down,Up,Right}
			bspc node -v {-20 0,0 20,0 -20,20 0}
	```

	Para una mayor comodidad seria agregar shift:

	```
		# move a floating window
		super + shift + {Left,Down,Up,Right}
			bspc node -v {-20 0,0 20,0 -20,20 0}
	```

	Con esto ya definiríamos un apartado de ==# Custom resize==, esto nos permite ajustar el tamaño de una pestaña hacia cualquier lado.
	
	```
		# Custom rezise
		 super + alt + {Left,Down,Up,Right}
		  /home/<user_name>/.config/bspwm/scripts/bspwm_resize {west,south,north,east}
	```
	
	Esto al final será ejecutar un script propio, el que nos permitirá realizar esto mismo. Aún no existe la ruta del directorio scripts dentro de ==bspwm/==, por ello la creamos y creamos nuestro script *bspwm_resize*, el cual tendrá como contenido lo siguiente:

	```
	#!/usr/bin/env dash

	if bspc query -N -n focused.floating > /dev/null; then
		step=20
	else
		step=100
	fi

	case "$1" in
		west) dir=right; falldir=left; x="-$step"; y=0;;
		east) dir=right; falldir=left; x="$step"; y=0;;
		north) dir=top; falldir=bottom; x=0; y="-$step";;
		south) dir=top; falldir=bottom; x=0; y="$step";;
	esac

	bspc node -z "$dir" "$x" "$y" || bspc node -z "$falldir" "$x" "$y"
	```


## ¿Que son la *Polybar*, *Picom* y *Rofi*?

Estos tres son paquetes esenciales para la personalización de un entorno en Bspwm, mejorando la interfaz y la usabilidad.

1. #### *Polybar*

	Es una barra de tareas altamente personalizable para sistemas de ventanas X.
	*Polybar* se destaca por su flexibilidad y capacidad de mostrar información variada, como la fecha, la utilización del CPU, la memoria, y mucho más. 
	
	Puedes configurar completamente su apariencia y los módulos que muestra, lo que la hace muy popular entre los usuarios que desean un escritorio minimalista y funcional.
	</br>
1. #### *Picom*

	Es un compositor para el sistema de ventanas X, lo que significa que maneja cómo se muestran las ventanas y los efectos visuales del escritorio, como sombras, transparencias y animaciones suaves.
	
	*Picom* ayuda a mejorar la estética general del escritorio y reduce el desgarro de la pantalla durante la reproducción de video y el movimiento de ventanas.
	</br>
1. #### *Rofi*

	Es un lanzador de aplicaciones ligero y personalizable, que también puede servir como conmutador de ventanas y más.
	
	*Rofi* permite a los usuarios buscar y lanzar aplicaciones rápidamente, cambiar entre ventanas  activas, o incluso ejecutar comandos personalizados. Su interfaz es altamente configurable, lo que permite a los usuarios adaptarla a sus necesidades específicas y estética del escritorio.


## Instalación de la *Polybar*, *Picom* y *Rofi*

1. Para la instalación de la *Polybar* se podría realizar mediante su repositorio, pero existe una forma más sencilla y es con el comando ==apt install==:

	```
	sudo apt install polybar
	```
	</br>

2. Para la instalación de *Picom* utilizaríamos su [repositorio](https://github.com/yshui/picom) el cual pertenece a [yshui](https://github.com/yshui).

	Empezando con su instalación, tendríamos que primeramente instalar los paquetes indicados. 
	
	Como parrot es una versión basada en Debian, entonces tendríamos que fijarnos qué paquetes se requieren para las versiones basadas en Debian. Que los instalaras de la siguiente manera:

	```
	sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev	
	```

	Luego de instalar todos estos paquetes, de preferencia realizar un update de todos los paquetes en el sistema y además instalar CMake:

	```
	sudo apt update
	sudo apt install cmake
	```

	Ahora, como ==usuario no privilegiado==, nos dirigimos a la carpeta de descargas y nos clonamos este mismo repositorio:

	```
	git clone https://github.com/yshui/picom.git
	```

	Una vez clonado, nos dirigimos al directorio del repositorio clonado y, gracias a un paquete recién instalado, aplicamos los siguientes comandos:

	```
	meson setup --buildtype=release build
	ninja -C build
	ninja -C build install
	```

	El último comando solicitará la contraseña para el usuario root.
	Con esto, si verificamos con *which* veríamos la ruta donde fue instalado picom:

	```
	which picom
	```
	</br>

3. Ahora instalaremos *Rofi* que será como nuestro buscador y lanzador de aplicaciones.

	```
	sudo apt install rofi
	```

	Si estamos como usuario privilegiado (root), salimos de este. Ahora podremos ejecutar el rofi para ver cómo es de estética (más adelante se mejorará) y funcionalidad:

	```
	rofi -show run
	```

	Tiene la siguiente estetica y desde aqui podremos lanzar *firefox*, por ejemplo:

	![[IMG_0006.png]]

	De esta manera, al darle al ==enter==, la ejecutaríamos. Funciona de la misma manera para  cualquier aplicación. 
	
	Esta misma acción, lo ideal sería de una vez definirla en nuestro archivo de configuración de   los atajos de teclado, el cual se encuentra almacenado en *~/.config/sxhkd/*, nos dirigimos aquí y abrimos nuestro archivo, ya sea con nvim o nano. 
	
	Editamos el apartado ==# program launcher==:

	```
	# program launcher
	super + @space
		dmenu_run
	```

	Donde colocaremos que la acción a ejecutar sea el rofi, además para mayor comodidad también cambiaremos el atajo de teclado, podríamos simplemente colocar el comando de ejecución, pero preferiblemente agregaremos su ruta absoluta:

	```
	# program launcher
	super + d
		/usr/bin/rofi -show run
	```

	De esta manera, con Windows + d, estaríamos abriendo rofi una vez que cambiemos de  entorno. 
	
	Para esto vamos a reiniciar la máquina o irnos a la pantalla de bloqueo para cambiar el  entorno que nos da parrot por bspwm, con el comando:

	```
	kill -9 -1
	```

	Ahora buscaremos un círculo con un símbolo especial. Esto podría cambiar dependiendo de la versión de parrot; en este caso lo observamos en la parte superior de la siguiente manera:

	![[IMG_0007.png]]

	Presionamos el primer símbolo y cambiamos la selección actual (==MATE==) por el que será nuestro entorno de ventanas ==bspwm==:

	![[IMG_0008.png]]

	Con esto listo, volvemos a iniciar sesión, ahora solo nos quedaría un entorno totalmente  oscuro y vacío, debido a que aún no tenemos un nada totalmente configurado, ni la polybar lista. 
	
	Si utilizamos algunas de las distintas combinaciones de teclas que hemos configurado,   veremos cómo todo funciona perfectamente; ahora la que nos interesa para seguir trabajando en el entorno es *Windows + enter*, ya que esta nos abrirá la terminal *kitty*. 
	
	Con esto listo, ahora toca configurar las fuentes, la terminal kitty e instalar Feh, pero antes  sus conceptos.

##  ¿Que son la *kitty*, *Hack Nerd Fonts* y *Feh*?

Estas herramientas son bastantes populares en la comunidad de usuarios avanzados en Linux, especialmente aquellos que prefieren entornos altamente personalizables y eficientes.
</br>

1. #### ¿Que es la *kitty*?

	*Kitty* es un emulador de terminal moderno para sistemas operativos pasados en Unis, como Linux y macOS.

	Es especialmente conocido por su eficiencia y capacidad para manejar gráficos modernos como imágenes y emojis directamente en la terminal. Kitty es altamente personalizable y ofrece funcionalidades avanzadas como pestañas, división de ventanas, y transparencia, entre otros.

	Además utiliza aceleración por GPU para renderizar los textos, lo que lo hace particularmente rápido.
	</br>
2. #### ¿Que son las *Hack Nerd Fonts*?

	Las *Hack Nerd Fonts* son una versión modificada de la fuente mono-espaciada Hack, que ha sido ampliada con una gran cantidad de iconos y símbolos adicionales, comocidos como "glyphs". 
	
	Estos incluyen íconos de populares herramientas de desarrollo y sistemas, lo que hace a esta fuente muy útil para desarrolladores y usuarios de terminales, ya que permite visualizar íconos específicos de herramientas directamente de la interfaz de la terminal.
	</br>
3. #### ¿Que es *Feh*?

	*Feh* es un visor de imágenes ligero y rápido para Linux que también puede ser utilizado para configurar fondos de pantalla en sistemas de escritorio. 
	
	Es muy eficiente y funciona bien en entornos de escritorio ligeros o configuraciones minimalistas, ya que no depende de grandes librerías gráficas. Feh puede ser utilizado en scripts y configuraciones para cambiar automáticamente fondos de pantalla o para mostrar imágenes en presentaciones de diapositivas.
## Configurando las fuentes, la kitty e instalación de Feh

1. Iniciaremos con la instalación de la fuente ==Hack Nerd Font==, esta nos será de mucha ayuda durante la personalización de nuestra terminal mediante el uso de la ==PowerLevel10k== que será lo que nos permitirá darle una mejor estética a la terminal o para representar iconos en nuestra ==polybar==. 
	
   Para esto la idea es llevar las fuentes a nuestro directorio ==/usr/local/share/fonts==, para ello utilizaremos un navegador, ==firefox== viene por defecto y agregaremos de una vez una combinación de teclas para este al final del archivo ==sxhkdrc==, recordando que se encuentra en el directorio ==~/.config/sxhkd==. 
   
    El atajo que agregaremos recordando siempre colocar la ruta absoluta de los programas, será:

	```
	# open firefox
	super + shift + f
		/usr/bin/firefox
	```
	
	Nota: 
	Firefox es un buen navegador, pero si queremos una opción que nos dé una mayor privacidad, para ello tenemos [*LibreWolf*](https://librewolf.net/installation/debian/) (un navegador basado en firefox) u otro que además por defecto nos borra todo lo que hemos realizado una vez se cierra [*Mullvad Browser*](https://mullvad.net/en/download/browser/linux). 
	
	Si ahora quisiéramos efectuar la combinación de teclas, notaremos que esta no funciona y esto se debe a que tenemos el apartado ==# make sxhkd reload its configuration files==, donde su atajo de teclado efectúa o actualiza los cambios realizados en nuestro ==sxhkd==, para ello tendríamos que realizar primero este atajo de teclas, una vez realizado ahora si nos funcionaría el del navegador. 
	
	Ahora se abrirá el navegador y lo pasaremos al segundo escritorio con ==windows + shift + 2==, que es uno de los atajos de teclado ya configurados, el cual nos permite cambiar la ventana seleccionada de escritorio y con ==windows + 2== nos estaríamos cambiando a este escritorio. 
	
	De esta manera tendremos en el primer escritorio la terminal y en el segundo el navegador, en nuestro navegador buscaremos [nerdfonts.com](https://www.nerdfonts.com/). Una vez estando en la página, nos iremos al apartado de descargas y buscaremos entre todas las fuentes la de ==Hack Nerd Font==, la descagaremos por lo pronto en la carpeta ==Downloads/== del directorio home del usuario. 
	
	Este será un archivo ==.zip==. Recordando que nuestra terminal del primer escritorio está en el directorio ==/usr/local/share/fonts==, moveremos a este directorio, el archivo recién descargado:

	```
	sudo mv ~/Downloads/Hack.zip .
	```

	Esto tendrá como contenido diversos archivos ==.ttf==, esta terminación en archivos se utiliza para las fuentes. Por lo que una vez las llamemos desde distintas configuraciones veremos como son estas fuentes. 
	
	==7z== es un comando que nos permite descomprimir cualquier tipo de archivo, para descomprimirlo solo ejecutaremos:

	```
	sudo 7z x Hack.zip
	```

	Finalmente, borraremos 3 archivos que ya no serán necesarios:

	```
	sudo rm Hack.zip LICENSE.md README.md
	```

	Con esto listo ahora instalaríamos la terminal que vamos a emplear, ya que actualmente estamos utilizando una terminal ==bash== y vamos a emplear una ==zsh== la cual nos permitirá una mayor configuración.

	```
	sudo apt install zsh -y
	```

	Ahora, antes de continuar configuraremos la clipboard bidireccional, esta nos servirá para poder copear y pegar contenido entre nuestra máquina base y nuestra máquina virtualizada. 
	
	Para ello nos dirigiremos al archivo ==bspwmrc== y al final del todo agregaremos la siguiente instrucción, agregando & al final para que se ejecute en segundo plano siempre:

	 ```
	 vmware-user-suid-wrapper &
	```

	Como hemos realizado cambios en nuestro archivo de configuración de bspwm, tendremos que efectuar la combinación de teclas ==windows + shift + r==, esto reiniciara el bspwm y ahora si intentamos copear y pegar contenido entre la máquina virtual y nuestra máquina base, funcionaria sin ningún problema. 
	
	Teniendo en cuenta que en la máquina virtual: 
	
	==ctrl + shift + c== --> copea contenido 
	==ctrl + shift + v== --> pega contenido
	</br>
2. Ahora vamos a actualizar la versión de la kitty que tenemos, para ello nos iríamos a su [repositorio](https://github.com/kovidgoyal/kitty) y en el apartado de releases seleccionamos siempre la última versión:

	![[IMG_0009.png]]

	Una vez aquí nos encontraremos con bastantes paquetes, nos iremos al final y buscaremos el que diga ==Linux amd64 binary bundle==:

	![[IMG_0010.png]]

   Damos clic y automáticamente se nos descargará. Se nos guardaría en el directorio ==Downloads==, con esto nosotros lo moveríamos al directorio ==/opt/==, donde tendremos que manejarlo como usuario root, ya que en este directorio se requiere de permisos de administrador para escribir.
   
	Estando en el directorio ==/opt/==:

	```
	sudo su
	```

	Colocamos la contraseña y ahora eliminaremos la kitty, qué cuidado porque aquí podría fallar debido a que estamos en una terminal kitty. 
	
	Si esto llegara a suceder, solo tendríamos que abrir el rofi con ==Windows + d== y ejecutar una gnome-terminal. 
	
	La eliminaríamos con:

	```
	apt remove kitty
	```

	Si ahora la kitty funciona bien y no nos da fallos, seguimos en ella, de lo contrario nos vamos a la gnome-terminal. 
	
	Con esto listo, dentro del directorio /opt, vamos a traer el archivo .txz que hemos descargado de la kitty más actualizada:

	```
	mv /home/<user>/Downloads/kitty.txz .
	```

	Recordando cambiar \<user\> por su usuario y que el nombre ==kitty.txz== cambiara dependiendo del nombre con el que se descargue el paquete. 
	
	Una forma de siempre ver qué contenido hay dentro de un archivo comprimido, es utilizando ==7z l file==, en lugar de "x", de esta manera antes de descomprimir podremos verificar y ya almacena todo en un directorio o si se almacenarán todos los archivos por separado en nuestra carpeta actual, tendríamos que crear una carpeta para que se almacenen todos los archivos de la kitty. 
	
	Ahora descomprimimos el archivo:

	```
	7z x kitty.txz
	```

	Este tendrá otro archivo .tar dentro, por lo que una vez descomprimido vamos a eliminar él .txz. Quedándonos con el archivo .tar. 
	
	Como en este caso el archivo .tar trae directamente las sub carpetas, crearemos un directorio para kitty y ahí almacenaremos todo el contenido, con los siguientes comandos:

	```
	mkdir kitty
	mv kitty.tar ./kitty/
	cd kitty
	7z x kitty.tar -y
	rm -f kitty.tar
	```

	De esta manera ahora tendríamos todo descomprimido y el archivo .tar eliminado. 
	
	Ahora entraríamos al directorio bin/, en caso de que kitty y kitten no tengan permisos de ejecución, se los daríamos y después vamos a cambiar el directorio de ejecución de kitty en nuestro archivo de configuración sxhkdrc, para que funcione correctamente el atajo de teclado.
	
	![[IMG_0011.png]]

	```
	chmod +x kitty kitten
	```

	Con esto listo, en nuestro archivo sxhkdrc cambiaríamos el directorio de kitty, por el que acabamos de agregar:

	```
	# terminal emulador
	super + Return
		/opt/kitty/bin/kitty
	```

	Con esto ya estaría actualizada nuestra kitty. 
	
	Es posible que esto nos dé bastantes problemas con los permisos al quererlo ejecutar como usuario no privilegiado, al estarlo haciendo como root, por lo que tendremos que ir viendo a qué sub carpetas y archivos darle permisos de lectura y ejecución. 
	
	Una vez dados correctamente los permisos, ahora si vamos a efectuar un ==Windows + esc== para recargar la configuración del sxhkdrc y cerraremos manualmente nuestra kitty escribiendo ==exit== hasta que se cierre. 
	
	Ahora si presionamos ==Windows + enter== y tendremos nuestra kitty actualizada. 
	
	Ahora la idea es empezar a modificar la estética de nuestra terminal, por ello nos iremos al directorio ==/home/\<usuario\>/.config/kitty==, si el directorio final "kitty" no existe, lo creamos. 
	
	Encontrándonos en el directorio, crearemos el archivo ==kitty.conf== y le agregaremos como contenido lo siguiente:

	```
	enable_audio_bell no

	include color.ini
	
	font_family HackNerdFont
	font_size 13
	
	disable_ligatures never
	
	url_color #61afef
	
	url_style curly

	# cambiar entre paneles de una kitty
	map ctrl+left neighboring_window left
	map ctrl+right neighboring_window right
	map ctrl+up neighboring_window up
	map ctrl+down neighboring_window down

	# clipboards para copear y pegar contenido en la kitty
	map f1 copy_to_buffer a
	map f2 paste_from_buffer a
	map f3 copy_to_buffer b
	map f4 paste_from_buffer b

	# tamaño del cursor
	cursor_shape beam
	cursor_beam_thickness 1.8
	
	mouse_hide_wait 3.0
	detect_urls yes
	
	repaint_delay 10
	input_delay 3
	sync_to_monitor yes
	
	map ctrl+shift+z toggle_layout stack
	tab_bar_style powerline
	
	inactive_tab_background #e06c75
	active_tab_background #98c379
	inactive_tab_foreground #000000
	tab_bar_margin_color black

	# abrira un nuevo panel
	map ctrl+shift+enter new_window_with_cwd
	map ctrl+shift+t new_tab_with_cwd

	# opacidad (tambien se definira desde picom)
	background_opacity 0.95

	# forzar tipo de shell
	shell zsh
	```

	Como podemos observar al final estamos forzando que la terminal sea un zsh, pero de cualquier manera vamos a configurar para que tanto el usuario no privilegiado como el root, tengan por defecto esta terminal. 
	
	Kitty es bastante configurable, con estas configuraciones podría bastar, pero de cualquier manera kitty tiene su propia [documentación](https://sw.kovidgoyal.net/kitty/).
	
	Ahora nos crearemos un archivo ==color.ini== para que tengamos una presentación bonita con los colores al momento de trabajar en nuestra sesión con la kitty y le colocaremos el siguiente contenido:

	```
	cursor_shape          Underline
	cursor_underline_thickness 1
	window_padding_width  20
	
	# Special
	foreground #a9b1d6
	background #1a1b26
	
	# Black
	color0 #414868
	color8 #414868
	
	# Red
	color1 #f7768e
	color9 #f7768e
	
	# Green
	color2  #73daca
	color10 #73daca
	
	# Yellow
	color3  #e0af68
	color11 #e0af68
	
	# Blue
	color4  #7aa2f7
	color12 #7aa2f7
	
	# Magenta
	color5  #bb9af7
	color13 #bb9af7
	
	# Cyan
	color6  #7dcfff
	color14 #7dcfff
	
	# White
	color7  #c0caf5
	color15 #c0caf5
	
	# Cursor
	cursor #c0caf5
	cursor_text_color #1a1b26
	
	# Selection highlight
	selection_foreground #7aa2f7
	selection_background #28344a
	```

	Si ahora guardamos y cerramos la kitty, al volver a abrirla veremos como ya se están aplicando los cambios y tendremos una mejor estética.

	![[IMG_0012.png]]

	Nos mostrará esto como problemita, ya que actualmente no existe archivo de configuración para nuestra zsh Shell, por lo que utilizaremos el número ==0==, para que nos cree un archivo de configuración, el cual será bastante simple, pero le iremos agregando cosas. 
	
	Con esto listo, ahora instalaríamos un paquete nos va a servir para el tratamiento de imágenes, en este caso abrir una desde nuestra terminal.

	```
	sudo apt install imagemagick
	```

	Con esto instalado, nos descargamos cualquier imagen de internet y dentro de la carpeta donde se nos guardó esta imagen:

	```
	kitty +kitten icat image.jpg
	```

	Esto no abriría la imagen dentro de la misma terminal.

3. Ahora vamos a instalar feh, esto lo hariamos con un comando:

	```
	sudo apt install feh
	```

	Este no servirá para colocar nuestro fondo de pantalla. 
	
	Como fondo puedes seleccionar alguno a tu gusto o aplicar él el que utiliza [s4vitar](https://wallpapercave.com/download/4k-ultra-hd-neon-mask-boy-wallpapers-wp7885623). 
	
	Lo que haremos será crear un directorio ==Fondos== en nuestro directorio personal y nos traeremos para aquí el o los fondos. 
	
	De forma que si ejecutáramos:

	```
	feh --bg-fill Fondo.jpg
	```

	Nos colocaría la imagen seleccionada de fondo. 
	
	Ahora, para evitar tener que estar ejecutando este comando cada que entremos a nuestra máquina, lo que tendríamos que hacer es colocarlo al final de nuestro bspwmrc, pero de la siguiente manera:

	```
	/usr/bin/feh --bg-fill /home/<user>/Desktop/Fondos/Fondo.jpg
	```

	Con esto, podremos regresar a la pantalla de bloqueo con ==Windows + shift + q== y veremos como automáticamente se carga el fondo. 
	
	Por último, nos faltaría que nuestro usuario root tenga su propia configuración de la kitty, debido a que si desde la terminal actual abriéramos una nueva kitty como usuario root esta se vería como la teníamos antes. 
	
	Esto se debe a que el usuario root tiene su propio directorio personal, así como sus directorios para archivos de configuración, por lo que como usuario root dentro del directorio ==~/.config/kitty== nos traeremos toda la configuración del directorio ==/home/user/.config/kitty/==, de la siguiente manera:

	```
	cp /home/user/.config/kitty/* .
	```

	Con esto ya tendríamos la configuración lista, la configuración de la kitty para el usuario root y por ende si abriéramos ahora una nueva terminal kitty como usuario root, esta ya tendría la misma configuración.

## ¿Que es la *Polybar*?

1. #### *Polybar*

	La *polybar* es una herramienta muy utilizada en la personalización de entornos de escritorio en sistemas Linux, especialmente en aquellos que emplean gestores de ventanas livianos o "tiling windows manager" como *i3*, *bspwm* y otros. Es una barra de estado que se destaca por ser altamente configurable y modular.

	*Polybar* permite a los usuarios crear barras de estado que se adaptan precisamente a sus necesidades y estética del escritorio. Puedes configurar elementos como módulos de reloj, indicadores de batería, controles de volumen, monitores de sistema (como CPU, memoria, etc.), espacios de trabajo y muchos otros. Cada módulo en la barra puede ser personalizado en términos de funcionalidad y apariencia.

	La configuración de polybar se realiza a través de archivos de texto plano, lo que proporciona una gran flexibilidad. Los usuarios pueden escribir sus propios módulos utilzando scripts en diferentes lenguajes de programación o adaptar módulos existentes para personalizar su experiencia. Además polybar es capaz de lanzar y mostrar notificaciones o resultados de comandos específicos, lo que lo hace una herramienta extremadamente potente para aquellos que desean tener un control total sobre la información que se muestra en su entorno de escritorio.

## Despliegue de la Polybar

1. Para el despliegue de la polybar, nos iremos al directorio de descargas de nuestra máquina. 

   Aquí nos clonaremos el repositorio [bluesky](https://github.com/VaughnValle/blue-sky) de *VaughnValle* con el comando:

	```
	git clone https://github.com/VaughnValle/blue-sky.git
	```

	Lo que nos interesara de este repositorio son las configuraciones ya previamente realizadas, ya que tomaremos parte de ellas al configurar nuestros módulos. 
	
	Por lo que nos vamos a la carpeta del repositorio *blue-skye/* y después a *polybar/*, ya en esta estaríamos viendo todos los archivos de configuración para la polybar:

	![[IMG_0013.png]]

	Aquí además de archivos tendremos directorios, por lo que tendremos que copear todo de forma recursiva para que arrastre tanto directorios como archivos, hacia nuestro directorio *~/.config/polybar/:

	```
	cp -r * ~/.config/polybar/
	```

	De esta forma ya tendríamos toda esta configuración para nuestra polybar. 
	
	Ahora para lanzar nuestra polybar está el archivo *launch.sh*, que cuando se ejecute nos lanzará la polybar y para que este sea un proceso automatizado y evitar tener que ejecutarlo cada que iniciemos nuestro entorno, pues tendremos que colocar lo siguiente en nuestro archivo *bspwmrc*:

	```
	echo '~/.config/polybar/./launch.sh &' >> ~/.config/bspwm/bspwmrc
	```

	De esta manera agregaríamos la instrucción al final de nuestro archivo bspwmrc, en formato append. 
	
	Ahora como usuario root, de cara a las fuentes que tiene el directorio *fonts/*, nos metemos en este y vamos a copearlas a nuestro directorio */usr/share/fonts/truetype*

	```
	cp ./* /usr/share/fonts/truetype/
	```

	Finalmente, vamos a sincronizar y actualizar la caché de fuente, con el siguiente comando:

	```
	fc-cache -v
	```

	Con esto listo, ahora efectuaríamos la combinación de teclas *Windows + shift + r*, para recargar o actualizar nuestro bspwm y esto ahora nos cargaría la polybar. 
	
	Con esto listo, hasta ahora ya nos cargaría por defecto nuestro fondo, la polybar y las demás cosas que hemos agregado ciertas configuraciones, como la kitty. 
	
	Lo siguiente será utilizar picom para trabajar los sombreados, bordes y opacidad, lo cual dará una mejor estética.

## ¿Que es *Picom*?

1. #### *Picom*

	*Picom* es un compositor para sistemas de ventanas X, utilizado comúnmente en entornos de escritorio. Es un derivado de Compton, que a su vez se basó en xcompmgr-dana, y es ampliamente usado en configuraciones con gestores de ventanas que no incluyen su propio sistema de composición, especialmente en entornos minimalistas como *i3*, *bspwm* y otros.

	Picom se encarga de agregar efectos visuales que no solo mejoran la estética del escritorio, sino que también pueden ayudar a hacer la interfaz más amigable y menos cansada para la vista.

	Entre las funcionalidades que ofrece *Picom*, se encuentran las siguientes:

	* *Sombras*: Añade sombras a las ventanas, lo que ayuda a mejorar la percepción de profundidad en el escritorio. Las sombras pueden ser configuradas en términos de color, tamaño, desenfoque y opacidad.
	* *Bordeados y esquinas redondeadas*: permite redondear las esquinas de las ventanas, lo que suaviza la apariencia general del entorno de escritorio. También puede gestionar los bordes de las ventanas.
	* *Transparencia y difuminados*: Picom puede gestionar la transparencia de las ventanas, los menús y la terminal, permitiendo configurar distintos niveles de transparencia y efectos de desenfoque. Estos efectos de desenfoque se puede aplicar a áreas detrás de ventanas transparentes para mejorar la legibilidad y estética.
	* *Animaciones*: Aunque más limitado a comparación de otros compositores como compiz, Picom también puede manejar algunas animaciones básicas para minimizar y restaurar ventanas.
	* *Prevención de tearing*: Picom ayuda a eliminar o reducir el "tearing" de la pantalla, un problema común donde la imagen no se sincroniza correctamente durante el refresco de la pantalla, lo que resulta en una línea horizontal o varias que descomponen la imagen correctamente renderizada.

	La configuración de Picom se realiza a través de un archivo de configuración, donde los usuarios pueden detallar sus preferencias para cada uno de estos efectos. Esto lo hace altamente personalizable y muy popular entre los usuarios que buscan mejorar tanto el rendimiento como la apariencia de sus escritorios.

	Picom es altamente personalizable y se debe personalizar en base a los requerimientos de cada uno, así a las capacidades de nuestra máquina, debido a que esto podrias afectar al rendimiento.

## Configurando los bordeados, las sombras y los difuminados con *Picom*

1. Ahora tendremos que crear nuestro directorio para almacenar la configuracion de picom, el cual se creara en la ruta *~/.config/*:

	```
	mkdir picom
	```

	Ahora entramos en este directorio y creamos nuestro archivo de configuracion con touch:

	```
	touch picom.conf
	```

	Y pegamos en el, el siguiente contenido:

	```
	##############################################################################
	#                                  CORNERS                                   #
	##############################################################################
	# requires: https://github.com/sdhand/compton
	corner-radius = 20;
	rounded-corners-exclude = [
	  #"window_type = 'normal'",
	  #"class_g = 'firefox'",
	];
	
	round-borders = 20;
	round-borders-exclude = [
	  #"class_g = 'TelegramDesktop'",
	];
	
	# Specify a list of border width rules, in the format `PIXELS:PATTERN`, 
	# Note we don't make any guarantee about possible conflicts with the
	# border_width set by the window manager.
	#
	# example:
	#    round-borders-rule = [ "2:class_g = 'URxvt'" ];
	#
	round-borders-rule = [];
	
	##############################################################################
	#                                  SHADOWS                                   #
	##############################################################################
	
	# Enabled client-side shadows on windows. Note desktop windows 
	# (windows with '_NET_WM_WINDOW_TYPE_DESKTOP') never get shadow, 
	# unless explicitly requested using the wintypes option.
	#
	shadow = true
	
	# The blur radius for shadows, in pixels. (defaults to 12)
	shadow-radius = 15
	
	# The opacity of shadows. (0.0 - 1.0, defaults to 0.75)
	shadow-opacity = .5
	
	# The left offset for shadows, in pixels. (defaults to -15)
	shadow-offset-x = -15
	
	# The top offset for shadows, in pixels. (defaults to -15)
	shadow-offset-y = -15
	
	# Avoid drawing shadows on dock/panel windows. This option is deprecated,
	# you should use the *wintypes* option in your config file instead.
	#
	# no-dock-shadow = false
	
	# Don't draw shadows on drag-and-drop windows. This option is deprecated, 
	# you should use the *wintypes* option in your config file instead.
	#
	# no-dnd-shadow = false
	
	# Red color value of shadow (0.0 - 1.0, defaults to 0).
	# shadow-red = .18
	
	# Green color value of shadow (0.0 - 1.0, defaults to 0).
	# shadow-green = .19
	
	# Blue color value of shadow (0.0 - 1.0, defaults to 0).
	# shadow-blue = .20
	
	# Do not paint shadows on shaped windows. Note shaped windows 
	# here means windows setting its shape through X Shape extension. 
	# Those using ARGB background is beyond our control. 
	# Deprecated, use 
	#   shadow-exclude = 'bounding_shaped'
	# or 
	#   shadow-exclude = 'bounding_shaped && !rounded_corners'
	# instead.
	#
	# shadow-ignore-shaped = ''
	
	# Specify a list of conditions of windows that should have no shadow.
	#
	# examples:
	#   shadow-exclude = "n:e:Notification";
	#
	# shadow-exclude = []
	shadow-exclude = [
	    "class_g = 'firefox' && argb"
	];
	
	# Specify a X geometry that describes the region in which shadow should not
	# be painted in, such as a dock window region. Use 
	#    shadow-exclude-reg = "x10+0+0"
	# for example, if the 10 pixels on the bottom of the screen should not have shadows painted on.
	#
	# shadow-exclude-reg = "" 
	
	# Crop shadow of a window fully on a particular Xinerama screen to the screen.
	# xinerama-shadow-crop = false
	
	##############################################################################
	#                                  FADING                                    #
	##############################################################################
	
	# Fade windows in/out when opening/closing and when opacity changes,
	#  unless no-fading-openclose is used.
	#fading = true
	
	# Opacity change between steps while fading in. (0.01 - 1.0, defaults to 0.028)
	# fade-in-step = 0.028
	fade-in-step = 0.01;
	
	# Opacity change between steps while fading out. (0.01 - 1.0, defaults to 0.03)
	# fade-out-step = 0.03
	fade-out-step = 0.01;
	
	# The time between steps in fade step, in milliseconds. (> 0, defaults to 10)
	# fade-delta = 10
	
	# Specify a list of conditions of windows that should not be faded.
	# fade-exclude = []
	
	# Do not fade on window open/close.
	# no-fading-openclose = false
	
	# Do not fade destroyed ARGB windows with WM frame. Workaround of bugs in Openbox, Fluxbox, etc.
	# no-fading-destroyed-argb = false
	
	##############################################################################
	#                                   OPACITY                                  #
	##############################################################################
	
	# Opacity of inactive windows. (0.1 - 1.0, defaults to 1.0)
	inactive-opacity = 1.0
	
	# Opacity of window titlebars and borders. (0.1 - 1.0, disabled by default)
	frame-opacity = 1.0
	
	# Default opacity for dropdown menus and popup menus. (0.0 - 1.0, defaults to 1.0)
	opacity = 1.0
	
	# Let inactive opacity set by -i override the '_NET_WM_OPACITY' values of windows.
	# inactive-opacity-override = true
	inactive-opacity-override = false;
	
	# Default opacity for active windows. (0.0 - 1.0, defaults to 1.0)
	active-opacity = 1.0
	
	# Dim inactive windows. (0.0 - 1.0, defaults to 0.0)
	# inactive-dim = 0.0
	
	# Specify a list of conditions of windows that should always be considered focused.
	# focus-exclude = []
	focus-exclude = [ "class_g = 'Cairo-clock'" ];
	
	# Use fixed inactive dim value, instead of adjusting according to window opacity.
	# inactive-dim-fixed = 1.0
	
	# Specify a list of opacity rules, in the format `PERCENT:PATTERN`, 
	# like `50:name *= "Firefox"`. picom-trans is recommended over this. 
	# Note we don't make any guarantee about possible conflicts with other 
	# programs that set '_NET_WM_WINDOW_OPACITY' on frame or client windows.
	# example:
	#    opacity-rule = [ "80:class_g = 'URxvt'" ];
	#
	# opacity-rule = []
	
	# opacity-rule = [ "98:class_g = 'Polybar'" ]
	
	##############################################################################
	#                                    BLUR                                    #
	##############################################################################
	
	# Parameters for background blurring, see the *BLUR* section for more information.
	blur-method = "dual_kawase"
	blur-size = 2
	blur-strength = 3
	
	# Blur background of semi-transparent / ARGB windows. 
	# Bad in performance, with driver-dependent behavior. 
	# The name of the switch may change without prior notifications.
	#
	blur-background = true
	
	# Blur background of windows when the window frame is not opaque. 
	# Implies:
	#    blur-background 
	# Bad in performance, with driver-dependent behavior. The name may change.
	#
	#blur-background-frame = false
	
	
	# Use fixed blur strength rather than adjusting according to window opacity.
	#blur-background-fixed = false
	
	
	# Specify the blur convolution kernel, with the following format:
	# example:
	#   blur-kern = "5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
	#
	# blur-kern = ''
	# blur-kern = "3x3box";
	
	# Exclude conditions for background blur.
	# blur-background-exclude = []
	#blur-background-exclude = [
	#    "! name~=''",
	#    "name *= 'slop'",
	#    "window_type = 'dock'",
	#    "window_type = 'desktop'",
	#    "_GTK_FRAME_EXTENTS@:c"
	#];
	
	##############################################################################
	#                                    GENERAL                                 #
	##############################################################################
	
	# Daemonize process. Fork to background after initialization. Causes issues with certain (badly-written) drivers.
	# daemon = false
	
	# Specify the backend to use: `xrender`, `glx`, or `xr_glx_hybrid`.
	# `xrender` is the default one.
	#
	# backend = 'glx'
	backend = "glx";
	
	# Enable/disable VSync.
	# vsync = false
	vsync = false
	
	# Enable remote control via D-Bus. See the *D-BUS API* section below for more details.
	# dbus = false
	
	# Try to detect WM windows (a non-override-redirect window with no 
	# child that has 'WM_STATE') and mark them as active.
	#
	# mark-wmwin-focused = false
	mark-wmwin-focused = true;
	
	# Mark override-redirect windows that doesn't have a child window with 'WM_STATE' focused.
	# mark-ovredir-focused = false
	mark-ovredir-focused = true;
	
	# Try to detect windows with rounded corners and don't consider them 
	# shaped windows. The accuracy is not very high, unfortunately.
	#
	# detect-rounded-corners = false
	detect-rounded-corners = true;
	
	# Detect '_NET_WM_OPACITY' on client windows, useful for window managers
	# not passing '_NET_WM_OPACITY' of client windows to frame windows.
	#
	# detect-client-opacity = false
	detect-client-opacity = true;
	
	# Specify refresh rate of the screen. If not specified or 0, picom will 
	# try detecting this with X RandR extension.
	#
	# refresh-rate = 60
	# refresh-rate = 0
	
	# Limit picom to repaint at most once every 1 / 'refresh_rate' second to 
	# boost performance. This should not be used with 
	#   vsync drm/opengl/opengl-oml
	# as they essentially does sw-opti's job already, 
	# unless you wish to specify a lower refresh rate than the actual value.
	#
	# sw-opti = 
	
	# Use EWMH '_NET_ACTIVE_WINDOW' to determine currently focused window, 
	# rather than listening to 'FocusIn'/'FocusOut' event. Might have more accuracy, 
	# provided that the WM supports it.
	#
	# use-ewmh-active-win = false
	
	# Unredirect all windows if a full-screen opaque window is detected, 
	# to maximize performance for full-screen windows. Known to cause flickering 
	# when redirecting/unredirecting windows.
	#
	# unredir-if-possible = false
	
	# Delay before unredirecting the window, in milliseconds. Defaults to 0.
	# unredir-if-possible-delay = 0
	
	# Conditions of windows that shouldn't be considered full-screen for unredirecting screen.
	# unredir-if-possible-exclude = []
	
	# Use 'WM_TRANSIENT_FOR' to group windows, and consider windows 
	# in the same group focused at the same time.
	#
	# detect-transient = false
	detect-transient = true
	
	# Use 'WM_CLIENT_LEADER' to group windows, and consider windows in the same 
	# group focused at the same time. 'WM_TRANSIENT_FOR' has higher priority if 
	# detect-transient is enabled, too.
	#
	# detect-client-leader = false
	detect-client-leader = true
	
	# Resize damaged region by a specific number of pixels. 
	# A positive value enlarges it while a negative one shrinks it. 
	# If the value is positive, those additional pixels will not be actually painted 
	# to screen, only used in blur calculation, and such. (Due to technical limitations, 
	# with use-damage, those pixels will still be incorrectly painted to screen.) 
	# Primarily used to fix the line corruption issues of blur, 
	# in which case you should use the blur radius value here 
	# (e.g. with a 3x3 kernel, you should use `--resize-damage 1`, 
	# with a 5x5 one you use `--resize-damage 2`, and so on). 
	# May or may not work with *--glx-no-stencil*. Shrinking doesn't function correctly.
	#
	# resize-damage = 1
	
	# Specify a list of conditions of windows that should be painted with inverted color. 
	# Resource-hogging, and is not well tested.
	#
	# invert-color-include = []
	
	# GLX backend: Avoid using stencil buffer, useful if you don't have a stencil buffer. 
	# Might cause incorrect opacity when rendering transparent content (but never 
	# practically happened) and may not work with blur-background. 
	# My tests show a 15% performance boost. Recommended.
	#
	# glx-no-stencil = false
	
	# GLX backend: Avoid rebinding pixmap on window damage. 
	# Probably could improve performance on rapid window content changes, 
	# but is known to break things on some drivers (LLVMpipe, xf86-video-intel, etc.).
	# Recommended if it works.
	#
	# glx-no-rebind-pixmap = false
	
	# Disable the use of damage information. 
	# This cause the whole screen to be redrawn everytime, instead of the part of the screen
	# has actually changed. Potentially degrades the performance, but might fix some artifacts.
	# The opposing option is use-damage
	#
	# no-use-damage = false
	use-damage = false
	
	# Use X Sync fence to sync clients' draw calls, to make sure all draw 
	# calls are finished before picom starts drawing. Needed on nvidia-drivers 
	# with GLX backend for some users.
	#
	# xrender-sync-fence = false
	
	# GLX backend: Use specified GLSL fragment shader for rendering window contents. 
	# See `compton-default-fshader-win.glsl` and `compton-fake-transparency-fshader-win.glsl` 
	# in the source tree for examples.
	#
	# glx-fshader-win = ''
	
	# Force all windows to be painted with blending. Useful if you 
	# have a glx-fshader-win that could turn opaque pixels transparent.
	#
	# force-win-blend = false
	
	# Do not use EWMH to detect fullscreen windows. 
	# Reverts to checking if a window is fullscreen based only on its size and coordinates.
	#
	# no-ewmh-fullscreen = false
	
	# Dimming bright windows so their brightness doesn't exceed this set value. 
	# Brightness of a window is estimated by averaging all pixels in the window, 
	# so this could comes with a performance hit. 
	# Setting this to 1.0 disables this behaviour. Requires --use-damage to be disabled. (default: 1.0)
	#
	# max-brightness = 1.0
	
	# Make transparent windows clip other windows like non-transparent windows do,
	# instead of blending on top of them.
	#
	# transparent-clipping = false
	
	# Set the log level. Possible values are:
	#  "trace", "debug", "info", "warn", "error"
	# in increasing level of importance. Case doesn't matter. 
	# If using the "TRACE" log level, it's better to log into a file 
	# using *--log-file*, since it can generate a huge stream of logs.
	#
	# log-level = "debug"
	log-level = "warn";
	
	# Set the log file.
	# If *--log-file* is never specified, logs will be written to stderr. 
	# Otherwise, logs will to written to the given file, though some of the early 
	# logs might still be written to the stderr. 
	# When setting this option from the config file, it is recommended to use an absolute path.
	#
	# log-file = '/path/to/your/log/file'
	
	# Show all X errors (for debugging)
	# show-all-xerrors = false
	
	# Write process ID to a file.
	# write-pid-path = '/path/to/your/log/file'
	
	# Window type settings
	# 
	# 'WINDOW_TYPE' is one of the 15 window types defined in EWMH standard: 
	#     "unknown", "desktop", "dock", "toolbar", "menu", "utility", 
	#     "splash", "dialog", "normal", "dropdown_menu", "popup_menu", 
	#     "tooltip", "notification", "combo", and "dnd".
	# 
	# Following per window-type options are available: ::
	# 
	#   fade, shadow:::
	#     Controls window-type-specific shadow and fade settings.
	# 
	#   opacity:::
	#     Controls default opacity of the window type.
	# 
	#   focus:::
	#     Controls whether the window of this type is to be always considered focused. 
	#     (By default, all window types except "normal" and "dialog" has this on.)
	# 
	#   full-shadow:::
	#     Controls whether shadow is drawn under the parts of the window that you 
	#     normally won't be able to see. Useful when the window has parts of it 
	#     transparent, and you want shadows in those areas.
	# 
	#   redir-ignore:::
	#     Controls whether this type of windows should cause screen to become 
	#     redirected again after been unredirected. If you have unredir-if-possible
	#     set, and doesn't want certain window to cause unnecessary screen redirection, 
	#     you can set this to `true`.
	#
	wintypes:
	{
	  tooltip = { fade = true; shadow = true; shadow-radius = 0; shadow-opacity = 1.0; shadow-offset-x = -20; shadow-offset-y = -20; opacity = 0.8; full-shadow = true; }; 
	  dnd = { shadow = false; }
	  dropdown_menu = { shadow = false; };
	  popup_menu    = { shadow = false; };
	  utility       = { shadow = false; };
	}
	```

	Esto nos hara que nuestro sistema cobre una estetica mucho mejor ya que tiene ciertas configuraciones ya establecidas, sin embargo a pesar de ya tener el archivo de configuracion, al recargar no sucedera nada.

	Esto se debe a que picom se ejecutara a nivel de comando y aun no esta corriendo, por lo que se ejecuta de forma sencilla con *picom*, pero para que esto funcione siempre lo tendremos que agregar al final de nuestro archivo *bspwmrc* ejecutandoce en segundo plano, de la siguiente manera:

	```
	picom &
	```

	Una vez listo esto, ahora si al recargar el bspwm con *windows + shift + r*, nos cargaran estas configuraciones en el entorno y se vera muchisimo mejor.

	Algo que tambien se nota en nuestra terminal o cualquier ventana que lleguemos a abrir, es que tiene un pequeño pordeado al rededor, para evitar verlo podriamos eliminarlo agregando al final de nuestro *bspwmrc* lo siguiente:

	```
	bspc config border_width 0
	```

## ¿Que es la *zsh (Z shell)* y *Powerlevel10k*?

1. #### *zsh (Z shell)*

	ZSH, o Z Shell, es un interprete de comandos para sistemas Unix que se utiliza como una alternativa al tradicional shell bash. Ofrece muchas mejoras en términos de características, plugins y temas, lo que lo hace muy populas entre los usuarios avanzados y desarrolladores.

	Algunas de las características más notables de la ZSH incluyen:

	* *Autocompletado*: ZSH proporciona un sistema de autocompletado potente y versátil que puede predecir comandos basados en el contexto, incluyedo opciones y parámetros.
	* *Corrección de errores*: Ofrece sugerencias de corrección cuando se escribe un comando erróneamente.
	* *Gestión de scripts*: ZSH es compatible con todos los scripts de Bourne shell y Bash, y añade sus propias mejores en la programación de scripts.
	* *Personalización*: Se puede personalizar profundamente mediante temas y configuraciones que pueden cambiar su apariencia y comportamiento.

2. #### *Powerlevel10k*

	*Powerlevel10k* es un tema para ZSH diseñado para ser visualmente atractivo y altamente informativo.
	Esta diseñado para ser una versión más rápida y personalizada del popular tema *Powerlevel9k*.

	Algunas de las características que lo hacen destacar incluyen:

	* *Velocidad*: Es significativamente más rápido que otros temas para zsh, lo que reduce el tiempo de inicio del terminal y la latencia al escribir comandos.
	* *Personalizable*: Viene con un asistente de configuración que guía a los usuarios a través del proceso de configuración, permitiendo persinalizar el prompt dependiendo de las preferencias del usuario.
	* *Información contextual*: Muestra información útil en el prompt según el contexto, como el estado del repositorio git, el usuario actual, el tiempo de ejecución de comandos, y mucho más.
	* *Iconos y fuentes*: Utiliza fuentes de Nerd Fonts para mostrar iconos y otros elementos gráficos que hacen que la información sea fácil de leer y visualmente atractiva.

Juntos, *ZSH* y *Powerlevel10k*, ofrecen una experiencia de terminal rica y eficiente, mejorando tanto la funcionalidad como la apariencia del entorno de línea de comandos. Estas herramientas son particularmente populares entre los desarrolladores y los entusiastas de la personalización de los entornos de los sitemas Unix/Linux.

## Configurando la ZSH e instalando la Powerlevel10k

1. Ahora, antes de empezar a configurar, será necesario instalar los siguientes paquetes:

	```
	sudo apt install zsh-autocomplete zsh-autosuggestions zsh-syntax-highlighting
	```

	Estos son tres plug-ins que vamos a utilizar junto con otro llamado *zsh sudo*, al final la instalación de estos plug-ins lo que hará sea almacenarnos estos recursos en sus respectivas carpetas dentro del directorio /usr/share/, dentro de cada uno habrá un archivo *.zsh* que será el que tendremos que cargar como source para que aplique el plug-in y pueda ser utilizado. 
	
	Podremos visualizarlos si listamos el contenido de este directorio y filtramos por *zsh*:

	```
	ls -l /usr/share | grep "zsh"
	```


	Dentro de cada uno de estos directorios, de los plug-ins que hemos instalado, habrá un archivo *.zsh*, el cual es un script que cargaremos como source para que nos aplique cada plug-in y así podamos utilizarlo. 
	
	Antes de continuar con el tema *Powerlevel10k*, primero les agregaremos a los usuarios la Shell zsh, ya que actualmente operan con una bash. Esto lo notaremos si en terminal migramos de usuario constantemente:
	
	```
	sudo su
	usermod --shell /usr/bin/zsh root
	usermod --shell /usr/bin/zsh user
	exit
	```

	Recordemos cambiar *user* por su usuario no privilegiado.

	Solo restaría cerrar y abrir nuevamente la terminal.

	Ahora iremos al repositorio del [*Powerlevel10k*](https://github.com/romkatv/powerlevel10k) y en nuestro directorio de usuario al cual podremos ir con  el comando *cd* vamos a efectuar los comandos del apartado *Manual*:

	```
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source /home/user/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
	```

	Recordando igual cambiar *user* por su usuario no privilegiado. Esto es debido a que más adelante se le dará un enlace simbólico al usuario root desde aquí, por lo que si lo dejáramos representado con *~*, intentaría cargarlo desde su configuración de usuario y esta no existirá, lo cual nos daría error. Por eso es mejor manejarlo como ruta absoluta. 
	
	Ahora comenzaríamos con la configuración de nuestra zsh, para ello ejecutaríamos el comando *zsh*:

	```
	zsh
	```

	Esto será un menú por el que iremos avanzando, seleccionando la configuración que deseemos y además podremos visualizar los iconos gracias a que ya tenemos las *Hack Nerd Fonts*, las configuraciones que yo considero mejores con las siguientes:

	1.  Primero responderemos a 3 preguntas, usualmente es sí, a las 3, pero estas podrían llegar a cambiar y tendrás que responderlas a cómo visualices los iconos, a cómo te preguntan.

	2.  En el primero seleccionaremos el prompt clásico: *2*

		![[images/IMG_0014.png]]

	3. En el segundo seleccionaremos unicode:  *1*

		![[IMG_0015.png]]

	4.  En el tercero seleccionaremos dark:  *3*

		![[IMG_0016.png]]

	5. En el cuarto seleccionaremos no: *n*

		![[IMG_0017.png]]

	6.  En el separador seleccionaremos round:  *4*

		![[IMG_0018.png]]

	7. En el sexto seleccionaremos sharp:  *3*

		![[IMG_0019.png]]

	8. En el séptimo seleccionaremos blurred: *2*

		![[IMG_0020.png]]

	9. En el octavo seleccionaremos one line:  *1*

		![[IMG_0021.png]]

	10. En el noveno seleccionaremos sparce:  *2*

		![[IMG_0022.png]]

	11. En el que décimo seleccionaremos many icons: *2*

		![[IMG_0023.png]]

	12. En el undécimo seleccionaremos fluent: *2*

		![[IMG_0024.png]]

	13. En el duodécimo seleccionaremos yes: *y*

		![[IMG_0025.png]]

	14. En el decimotercero seleccionaremos verbose:  *1*

		![[IMG_0027.png]]

	15. En el decimocuarto seleccionaremos yes:  *y*

		![[IMG_0028.png]]

	Ahora solo tendríamos que esperar un momento y ya estaría toda la configuración de nuestro tema *Powerlevel10k* listo. 
	
	Con esto realizaremos algunas configuraciones para la barra que ahora nos muestra la zsh. Para esto accederemos al archivo *.p10k.zsh* el cual está en el directorio personal del usuario no privilegiado. 
	
	Una vez en el archivo, buscaremos el apartado que nos indicará todo lo que se mostrará del lado derecho en nuestra terminal, lo cual comentaremos con *#* al inicio. 
	
	Esto nos ayudará a no tener tantos plug-ins de ese lado y evitaría que llegase a ralentizarnos la terminal. Empezamos a comentar a partir de *status*:

	![[IMG_0029.png]]

	Vamos a comentar, desde ahí, hasta el final de esta sección, quedando desde el inicio al final de la sección de la siguiente manera:

	![[IMG_0030.png]]

	En cuanto a elementos de la izquierda, tendríamos lo siguiente:

	![[IMG_0031.png]]

	Aquí agregaremos los siguientes apartados:

	```
	context
	command_execution_time
	status
	```

	Quedando de la siguiente manera:

	![[IMG_0032.png]]

	Guardamos y cerramos. Ahora ya tendremos de una mejor manera representada nuestra barra en la terminal. 
	
	Con esto listo, ahora vamos a configurar el *powerlevel10k* para el usuario root, por lo que nos convertimos a root y con *cd* nos vamos a su directorio personal, para después traernos el *powerlevel10k*:

	```
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
	```

	Luego de esto, ejecutamos *zsh* y configuramos todo como lo hicimos para el usuario no privilegiado. 
	
	Ahora haremos lo mismo de comentar todo lo de la derecha para el usuario root en su archivo *.p10k.zsh* el cual estará en el directorio personal de root. 
	
	Con esto agregaríamos lo mismo en el lado izquierdo:

	```
	context
	command_execution_time
	status
	```

	Finalmente, lo que nos indica cuando nos hemos conectado como root es bastante largo y lo cambiaremos por algo identificativo como un icono. En lugar de ese texto, esto se encontrará en el apartado *ROOT TEMPLATE*, lo cual lo encontraremos rápidamente filtrando. 
	
	La idea será cambiar el contenido de la siguiente manera:

	![[IMG_0033.png]]

	Aquí eliminaremos el contenido de las comillas, dejando solo *''*, después del igual. 
	
	Cambiar el contenido de las comillas:

	![[IMG_0034.png]]

	Eliminando el contenido y agregando el icono de nuestra preferencia de los iconos disponibles en la página de [*Hack Nerd Fonts*](https://www.nerdfonts.com/cheat-sheet) para saber que estamos como root, en este caso utilizaremos: 󱗗

	![[IMG_0035.png]]

	Si quisiéramos que los directorios no los representen en negritas, bastaría con filtrar en el archivo *.p10k.zsh* por *DIR_ANCHOR* y colocarlo en false, para ambos usuario y estaría listo.

2. Para la zsh, utilizaremos un archivo de configuración para ambos usuario, por lo que tendremos que crear un enlace simbólico para que el archivo *.zshrc* del usuario root apunte al del usuario no privilegiado. En el directorio *root/*, ejecutaremos el siguiente comando para ello:

	```
	ln -s -f /home/user/.zshrc .zshrc
	```

	Sabremos si se hizo correctamente, ya que al listar el archivo se vería de la siguiente manera:

	![[IMG_0036.png]]

	Por ende ahora este tendría el mismo contenido que el del usuario no privilegiado. 
	
	Ahora vamos a ejecutar un comando, para agregar el plug-in *zsh-autocomplete*, si esto nos diera error o se quedase esperando una respuesta, cerramos con *ctrl + c* y ejecutaremos *compaudit* y a la ruta que nos dé, le vamos a cambiar tanto propietario como grupo al usuario root (el segundo comando). 
	
	Y finalmente ejecutaremos nuevamente el primer comando:

	```
	source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
	chown root:root /usr/local/share/zsh/site-functions/_bspc

	exit
	```

	Ahora realizaremos lo mismo para el autosuggestions, el cual será un tipo de autocolplete que nos mostrará posibles comandos de algo que empecemos a escribir, basado en el contexto y comandos ejecutados anteriormente.

	```
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 
	```

	Esto, al escribir un posible comando, nos pondrá por detrás, con letras un poco más opacas, un posible comando a utilizar, lo cual nos puede servir demasiado. 
	
	Con esto anterior que realizamos, es la forma de cargar los plug-ins que hemos instalado anteriormente, para que esto se aplique correctamente siempre. Tendremos que agregar esta instrucción en nuestro archivo *.zshrc*, verificando antes si el archivo existe para que no nos dé errores. 
	
	Por lo tanto, agregaríamos al final lo siguiente:

	```
	# ZSH autosuggestions Plugin
	if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
		source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	fi

	# ZSH syntax highlighthind Plugin
	if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
		source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi

	# ZSH autocomplete Plugin
	if [ -f /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
		source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
	fi
	```

	* *Autosuggestions plugin*: Este plug-in nos ayudará para darnos ayuda para comandos anteriores que hemos escrito y basándose en el contexto de lo que estamos haciendo, por lo que es una herramienta potente para autocompletar rápidamente comandos anteriores que hemos ejecutado y necesitamos ejecutar con cierta frecuencia.

	* *Syntax highlighthing plugin*: Este plug-in nos ayudará a reconocer la sintaxis de los comandos en bash y, por ende, nos lo representará con colores, dándole una mejor estética a nuestra terminal.

	* *Autocomplete plugin*: Este plug-in nos ayudará al momento de utilizar comandos con parámetros, ya que siempre y cuando en su panel de ayuda estén los parámetros a utilizar, este nos filtrará por los que estamos seleccionando y debajo del comando nos colocará lo que podremos hacer con el parámetro indicado.
	
	Además, si quisiéramos instalar otro plug-in existente con base en nuestros requerimientos, podremos hacerlo de la siguiente manera (se mostrará un ejemplo para agregar el ZSH SUDO):

	* *ZSH sudo plugin*: Este plug-in nos ayudará para que, al momento de estar escribiendo un comando en terminal, si al ir bastante avanzados en él, quisiéramos ejecutarlo como usuario privilegiado, bastaría con presionar 2 veces la tecla *esc* para que nos coloque *sudo* al inicio de todo el comando.

	Para agregar un nuevo plug-in, tendríamos que irnos primero como usuario privilegiado al directorio */usr/share* y aquí crearíamos el directorio *zsh-sudo* para después entrar en él. 
	
	Una vez dentro del directorio, buscaríamos [*zsh-sudo plug-in*](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/sudo/sudo.plugin.zsh) y seleccionaríamos [*raw*](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/sudo/sudo.plugin.zsh) para ver directamente el texto y poderlo descargar rápidamente hacia el directorio que previamente creamos. 
	
	Lo descargaríamos ejecutando el comando:

	```
	wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/sudo/sudo.plugin.zsh
	```

	Finalmente, a esto, de la misma manera que con los otros plug-ins, le aplicaríamos un *source* dentro de nuestro archivo *.zshrc*, de la siguiente manera:

	``` 
	# ZSH sudo plugin
	if [ -f /usr/share/zsh-sudo/sudo.plugin.zsh ]; then
		source /usr/share/zsh-sudo/sudo.plugin.zsh
	fi
	```

	De esta manera, si reiniciamos nuestra terminal, al ejecutar comandos y presionar *esc* dos veces, se nos colocaría *sudo* al inicio del comando. 
	
	Ahora, una de las cosas con las que cuenta la bash es su propio archivo que almacena comandos ejecutados incluso en sesiones anteriores de terminal, por lo que para habilitarlo y que se nos cree el archivo *.zsh_history* en el directorio personal, entonces tendremos que agregar en nuestro archivo *.zshrc* luego de la acción previamente establecida, lo siguiente:

	```
	# History
	HISTFILE=~/.zsh_history # define el archivo para almacenar el historial
	HISTSIZE=10000 # Le da un tamaño para poder almacenar una gran cantidad
	SAVEHIST=10000 # guarda o mantiene el historial
	setopt histignorealldups sharehistory # nos permite mandar una cadena vacia al
	# archivo del historial de comandos, lo cual lo vaciara.
	```

	Finalmente, vamos a agregar un sistema de autocompletado inteligente luego de todo lo que hemos agregado. 
	
	Este sistema de autocompletado nos ayudará mucho cuando, por ejemplo, escribamos mal un comando bash, como ejemplo el comando *whoami*. Si escribiéramos *whomi*, al presionar TAB, el sistema inteligente nos colocaría correctamente el comando. 
	
	Este sistema es un script o una serie de instrucciones, las cuales se encuentran en un [*Pastebin*](https://pastebin.com/H87J3nMj) y son las siguientes instrucciones:

	```
	# Use modern completion system
	
	autoload -Uz compinit
	
	compinit
	
	zstyle ':completion:*' auto-description 'specify: %d'
	zstyle ':completion:*' completer _expand _complete _correct _approximate
	zstyle ':completion:*' format 'Completing %d'
	zstyle ':completion:*' group-name ''
	zstyle ':completion:*' menu select=2
	eval "$(dircolors -b)"
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion:*' list-colors ''
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
	zstyle ':completion:*' menu select=long
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' use-compctl false
	zstyle ':completion:*' verbose true
	
	zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
	zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
	```

	Con esto, nuestro *.zshrc* final, quedaría de la siguiente manera:

	```
	# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
	# Initialization code that may require console input (password prompts, [y/n]
	# confirmations, etc.) must go above this block; everything else may go below.
	if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi
	
	# Created by newuser for 5.9
	source /home/sammy/powerlevel10k/powerlevel10k.zsh-theme
	
	# ZSH autosuggestions Plugin
	if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
		source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	fi
	
	# ZSH syntax highlighthind Plugin
	if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
		source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi
	
	# ZSH autocomplete Plugin
	if [ -f /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
		source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
	fi
	
	# ZSH sudo plugin
	if [ -f /usr/share/zsh-sudo/sudo.plugin.zsh ]; then
		source /usr/share/zsh-sudo/sudo.plugin.zsh
	fi
	
	
	# History
	HISTFILE=~/.zsh_history
	HISTSIZE=10000
	SAVEHIST=10000
	setopt histignorealldups sharehistory
	
	
	# Use modern completion system
	autoload -Uz compinit
	
	compinit
	
	zstyle ':completion:*' auto-description 'specify: %d'
	zstyle ':completion:*' completer _expand _complete _correct _approximate
	zstyle ':completion:*' format 'Completing %d'
	zstyle ':completion:*' group-name ''
	zstyle ':completion:*' menu select=2
	eval "$(dircolors -b)"
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion:*' list-colors ''
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
	zstyle ':completion:*' menu select=long
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' use-compctl false
	zstyle ':completion:*' verbose true
	
	zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
	zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
	
	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
	
	```

## ¿Que es *Batcat* y *Lsd*?

1. #### *Batcat*

	*Batcat* es la versión distribuida en Debian y Ubuntu del programa *bat*, una herramiente de línea de comandos que sirve como una versión mejorada del clásico comando *cat* de Unix. Batcat ofrece resultado de sintaxis para una gran variedad de lenguajes de programación y formatos de archivo, facilitando la lectura y comprensión del código directamente en la terminal. Además integra funcionalidades como la integración con git para mostrar diferencias en el código, numeración de lineas, y la capacidad de previsualizar el contenido de archivos en formato paginado.

	Esta herramienta es especialmente útil para desarrolladores y personas que trabajan frecuentemente con código fuente o scripts, ya que mejora significativamente la legibilidad y la eficiencia al explorar o revisar archivos en la terminal.
	</br>
2. #### *Lsd*

	*Lsd* (abreviatura de LSDeluxe) es un reemplazo moderno para el tradicional comando *ls* de Unix. Diseñado para mejorar la visualización de los archivos en la terminal. *Lsd* ofrece un resaltado de colores basado en el tipo de archivo y permisos, además de utilizar iconos para cada tipo de archivo, lo que hace que la navegación y comprensión de la estructura de los directorios sea mucho más intuitiva y visualmente agradable. Al igual que *bat*, *lsd* soporta fuentes de *Nerd Fonts* para mostrar iconos, y puede ser completamente personalizado mediante un archivo de configuración para adaptarse a las preferencias del usuario.

	Lsd también soporta características como el árbol de directorios directamente en la lista de archivos lo cual es útil para obtener una visión rápida de la jerarquía de directorios sin necesidad de comandos adicionales. Su funcionalidad y estética mejorada lo hacen popular entre los usuarios que desean una experiencia más rica y eficiente en la linea de comandos.


## Instalación de *Batcat* y *Lsd*

1. Iniciaremos con batcat y buscando [*batcat GitHub*](https://github.com/sharkdp/bat) para ir a su repositorio, de aquí nos iremos al apartado de releases y descargaremos el archivo *.deb* que sea *amd64*:

	![[IMG_0037.png]]

	Una vez descargado, nos dirigiremos al directorio de descargas y nos colocaremos como usuario root.

	Ahora instalaremos batcat:

	```
	dpkg -i batcat.deb
	```

	Con esto quedaría instalado y podríamos ver las diferencias entre cada uno al listar el contenido de un archivo con *cat* y con *bat*. 
	
	Ahora se definirá un apartado de *Custom alisases* dentro de nuestro *.zshrc*. Esto nos servirá para definir que nuestro *cat* ejecute directamente un *bat* y veamos todo con una mejor estética:

	```
	# Custom aliases
	#---------------------------------------

	#bat
	alias cat='bat' # bat con modo pagina
	alias catn='bat --style=plain' # similar al cat normal
	alias catn='bat --style=plain --pagin=never' # elimina el modo pagina en el output
	```


2. Ahora con Lsd y buscarepos [*lsd github*](https://github.com/lsd-rs/lsd) para ir a su repositorio, de aquí nos iremos al apartado de releases y descargaremos el archivo *.deb* que sea *amd64*:

	![[IMG_0038.png]]

	Una vez descargado, nos dirigiremos al directorio de descargas y nos colocaremos como usuario root.

	Ahora instalaremos lsd:

	```
	dpkg -i lsd.deb
	```

	Con esto quedaría instalado y podríamos ver las diferencias entre cada uno al listar el contenido de un directorio con *ls* y con *lsd*. 
	
	Al utilizar lsd notaremos que ciertas cosas que lista las pone en negritas, esto ya es preferencial, pero en este caso le quitaremos las negritas, esta es una instrucción que se almacena en la variable de entorno *$LS_COLORS* y lo que representa la indicación de las negritas es *01;*, lo cual estaremos eliminando y se hace fácilmente con el siguiente comando:

	```
	export LS_COLORS="$(echo $LS_COLORS | sed 's/=01;/=/g')"
	```

	Esto reemplazaría el contenido que tiene la indicación en negritas por el mismo, pero sin esa indicación, ya que se reemplazó empleando el comando *sed*. 
	
	Este es un cambio que se realiza momentáneamente, por lo tanto, para tenerlo siempre de esta manera, tendríamos que agregar esta instrucción en nuestro archivo *.zshrc*. 
	
	Dentro de nuestro apartado *Custom aliases*, vamos a agregar ahora la definición para los alias de *lsd*:

	```
	# Custom aliases
	#---------------------------------------

	#bat
	alias cat='bat' # bat con modo pagina
	alias catn='bat --style=plain' # similar al cat normal
	alias catn='bat --style=plain --pagin=never' # elimina el modo pagina en el output

	#ls
	alias ll='lsd -lh --group-dirs=first' # Muestra mayor informacion
	alias la='lsd -la --group-dirs=first' # Muestra ocultos
	alias l='lsd --group-dirs=first' # aplica un ls normal
	alias lla='lsd -lha --group-dirs=first' # Muestra mayor informacion y ocultos
	alias ls='lsd --group-dirs=first' # ls normal
	```


Una cosa importante es la variable de entorno *$PATH*, ya que en esta se almacenan los directorios en los cuales se buscaran los comandos o aplicaciones que estemos utilizando.

Si utilizamos el comando:

```
echo $PATH
```

Si lo hacemos para usuario root y no privilegiado, podremos notar que en root no se contempla la ruta absoluta de la kitty que estamos empleando, por ello en nuestro comando .zshrc en el directorio del usuario no privilegiado, agregaremos lo siguiente:

```
export PATH="/opt/kitty/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin"
```

Las rutas agregadas son del *PATH* del usuario no privilegiado, por ende si te diera problemas solo coloca las que tenga tu usuario no privilegiado. 

De esta manera, ahora, si quisiéramos ejecutar una kitty desde consola como usuario privilegiado, podríamos hacerlo sin problemas.


## ¿Problemas con *java* para el *Burpsuite*?

1. Si llegamos a tener problemas con burpsuite al intentar abrirlo, con la versión de java, podríamos intentar cambiando esta misma con las otras alternativas:

	```
	update-alternatives --config java
	sudo update-alternatives --config java
	```

	Aquí cambiaremos entre las versiones que se nos muestres. 
	
	Si esto no funciona, tendremos que obtener una versión específica de java, la cual podremos traer con un comando y esto nos ayuda a solucionarlo un [*artículo*](https://medium.com/@fidjolakoka/burpsuite-no-longer-launches-after-parrot-upgrade-d1c6b17cb70d). 
	
	Primeramente, tendremos que irnos al directorio de descargas y convertirnos en usuario privilegiado, para después traernos lo siguiente:

	```
	wget https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz
	```

	Luego vamos a extraer todo el contenido del archivo recién descargado:

	```
	tar xvf openjdk-21.0.2_linux-x64_bin.tar.gz
	```

	Ahora lo vamos a mover a otro folder:

	```
	sudo mv jdk-21.0.2/ /usr/lib/jvm/jdk-21
	```

	Ahora tendremos que abrir el archivo y editar la ruta */usr/lib/jvm/java-17-openjdk-$(dpkg-architecture -q DEB_HOST_ARCH)/bin/java* por */usr/lib/jvm/jdk-21/bin/java*, lo abriremos con:

	```
	sudo nano /usr/bin/burpsuite
	```

	Con esto ya estaría funcional.
	
## ¿Problemas con el tamaño de la ventana *burpsuite*?

1. En el archivo *.zshrc* vamos a agregar el siguiente apartado:

	```
	# Fix the java Problem
	export _JAVA_AWT_WM_NONREPARENTING=1
	```

2. Al final de nuestro archivo *bspwmrc* vamos a agregar:

	```
	wmname LG3D &
	```

3. Por último, vamos a crear un archivo para no tener problemas al ejecutar burpsuite desde el rofi y se nos apliquen los cambios del tamaño, lo podremos crear en el directorio *usr/bin*:

	```
	sudo su
	touch burpsuite-launcher
	chmod +x burpsuite-launcher
	```

	Con esto, finalmente, vamos a agregar lo siguiente en el archivo:

	```
	#!/bin/bash

	export _JAVA_AWT_WM_NONREPARENTING=1
	wmname LG3D &

	/usr/bin/burpsuite # ruta absoluta de burpsuite
	```

	Ya por último vamos a utilizar el atajo de teclado *Windows + shift + q* para reiniciar el bspwm y guardé todos los cambios, ahora estará todo funcional.

## Configurando la polybar

1. Para nuestra configuración en la polybar, realizaremos distintas cosas. Primeramente, tendremos que estar en su directorio, el cual es *~/.config/polybar*. Aquí estaremos trabajando realizando modificaciones en los archivos *launch.sh* y *current.ini*.

	*launch.sh* define o carga los elementos o barras que estamos cargando, que son como los bloques que muestran la información en la parte superior. 
	
	*current .ini* contiene la configuración para cada barra o elemento que se encuentre definido.

	Empezaremos con el archivo *current.ini*, en este vamos a cambiar de primeras los colores de fondo de nuestras tarjetas, tanto de la izquierda, como de la derecha. 
	
	Primeramente, filtraremos por *log*, esto nos llevará a la configuración de la barra o tarjeta de la izquierda, que cuenta con el icono. Las diversas opciones que tiene las podremos modificar si deseamos, para desplazar, modificar su tamaño, color o lo que muestre, etc.

	En el apartado *background* borraremos el color que está y en su lugar colocaremos ${color.bg}, al recargar la polybar, esto nos cambiaría su color de fondo al gris con el que todas las demás ya cuentan. 
	
	Si ahora observáramos el apartado *modules-center*, este tendrá *my-text-label*, entonces filtraremos por él, para llegar hasta al apartado de módulos y poder modificar el icono que se muestra cambiando el apartado de *content*, por un icono que deseemos de la página [*nerdfonts*](https://www.nerdfonts.com/cheat-sheet).

	Aquí podríamos llegar a tener problema con que no nos cargue algunos iconos, esto se debe a que antes del icono se está referenciando a una fuente de número *7*, la cual no se encuentra creada, por así decirlo, dentro de nuestro current.ini. Para ello, vamos a filtrar por *font-name* y al final, luego de la fuente 6, crearemos la fuente 7, con lo siguiente:

	```
	font-7 = "Hack Nerd Font Mono:size=22;5"
	```

	En el apartado size, nuestro valor de la izquierda será para regular el tamaño del icono, mientras que el de la derecha será para regular la altura. De esta manera, si al hacerlo más grande no queda centrado, podríamos centrarlo.
	</br>
2. Ahora crearemos una barra personalizada en la polybar, para ello iremos al archivo *launch.sh* 

    En este tomaremos la segunda barra creada para el apartado izquierdo y después de *polybar*, lo que sigue es su nombre, por lo tanto, lo borraremos y le pondremos como nombre *ethernet_bar*.
    
	Este nombre tendrá que ser creado como barra dentro del *current.ini*, para ello filtraremos por *secondary* y copearemos todo su contenido, para colocarlo sobre esa misma. 
	
	Como *width* le daremos un 10%. Si se llegara a necesitar más espacio para mostrar todo el contenido, se le daría más porcentaje.

	Ahora en el apartado *modules-center*, cambiaremos el de *date*, por uno que vamos a crear, a este le llamaremos *ethernet_status*. 
	
	De esta manera, nuestro apartado de definición de la barra, quedaría de esta manera:

	```
	[bar/ethernet_bar]
	inherit = bar/main
	width = 11.5%
	height = 40
	offset-x = 3.8%
	offset-y = 15
	background = ${color.bg}
	foreground = ${color.white}
	bottom = false
	padding = 1
	;padding-top = 2
	module-margin-left = 0
	module-margin-right = 0
	;modules-left = date sep mpd
	modules-center = ethernet_status 
	wm-restack = bspwm
	```

	Ahora, filtrando por *module/date*, copiaremos sus primeras dos líneas y definiremos nuestro módulo, al final de todos los existentes. 
	
	Este tendrá de nombre *ethernet_status*, de tipo será un *custom/script*, se ejecutara con un intervalo de cada 2 segundos, y con *exec* le indicaremos la ruta absoluta donde se encontrara nuestro script, en este caso será *~/.config/bspwm/scripts/ethernet_status.sh*, de esta manera nuestro módulo quedaría así:

	```
	[module/ethernet_status]
	type = custom/script
	interval = 2
	exec = ~/.config/bspwm/scripts/ethernet_status.sh
	```

	Ahora, en cuanto a nuestro script respecta, este nos mostrará la IP privada de la máquina, y tendrá el siguiente contenido:

	```
	#!/bin/sh
	
	if [  "$(/usr/sbin/ifconfig ens33 | grep "inet " | awk '{print $2}')" ]; then
	  echo "%{F#00FF00}󱚸 %{F#ffffff}$(/usr/sbin/ifconfig ens33 | grep "inet " | awk '{print $2}')%{u-}"
	else
	  echo "%{F#FF0000}󰤭 %{F#ffffff} NO WIFI%{u-}"
	fi
	```

	Aquí tendremos que asegurarnos de que la ruta absoluta de *ifconfig* sí es la indicada y de que además nuestro nombre de interfaz de red también sea *ens33*. 
	
	Ahora mismo ya estaría lista nuestra barra de la IP privada, y en todo momento podríamos visualizar nuestra IP privada.
	</br>

3. Ahora crearemos una nueva barra, primero la definiremos dentro de nuestro *launch.sh*, copiando la línea de la última que definimos y le cambiamos el nombre a *vpn_bar*, esto nos será de ayuda cuando, por ejemplo, nos conectemos a máquinas de *HackTheBox*, para ver en todo momento su IP. 

	Para nuestro *current.ini*, copeamos todo el contenido de la barra anteriormente definida y le cambiaremos el nombre a *vpn_bar*, aquí lo que cambiaremos será la posición en x, ya que actualmente se encontraría justo debajo de la barra *ethernet_status*, en x pondríamos un *15.6%*, esto cambiara dependiendo de como se acomoden mejor tus barras, para que no queden empalmadas.

	El *module-center* ahora quitaríamos ethernet_status y colocaríamos *vpn_status*, luego filtraríamos por el módulo recientemente creado, copiaríamos todo su contenido y modificaríamos la ruta absoluta para un nuevo script, el cual nos mostrará la información al conectarnos por VPN. 
	
	De esta manera, tendríamos de contenido:

	* *vpn bar*:
		```
		[bar/vpn_bar]
		inherit = bar/main
		width = 11.5%
		height = 40
		offset-x = 15.6%
		offset-y = 15
		background = ${color.bg}
		foreground = ${color.white}
		bottom = false
		padding = 1
		;padding-top = 2
		module-margin-left = 0
		module-margin-right = 0
		;modules-left = date sep mpd
		modules-center = vpn_status 
		wm-restack = bspwm
		```

	* *vpn module*:
		```
		[module/vpn_status]
		type = custom/script
		interval = 2
		exec = ~/.config/bspwm/scripts/vpn_status.sh
		```
	* *vpn script*:
		```
		#!/bin/sh
		 
		IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')
		 
		if [ "$IFACE" = "tun0" ]; then
		    echo "%{F#1bbf3e}󰆧 %{F#ffffff}$(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}')%{u-}"
		else
		    echo "%{F#1bbf3e} %{u-} Disconnected"
		fi
		```
4. Vamos a cambiar el color de fondo de nuestro botón para apagar o reiniciar la máquina. Para ello, nos iremos a nuestro *current.ini*, en este vamos a filtrar por *bar/primary* y en background, cambiaremos *white* por *bg*. De esta manera ya tendríamos todas las barras con el mismo color de fondo.


## Creando nuevos módulos en la *polybar*

1. Vamos a definir una barra, la cual nos mostrará cualquier IP que almacenemos en un archivo, gracias a unas funciones que estaremos definiendo. 

   Para esto, podríamos editar la barra de volumen ya definida, que es la primera en el apartado *right bar*. Le cambiaremos el nombre a *target_to_hack*

	Después, en nuestro archivo *current.ini*, vamos a definir nuestra tarjeta. Para esto podríamos copiarnos la secondary y pegarlo arriba de esa. Cambiaremos el nombre a *target_to_hack*, le daremos un width de 15% y su posición en x, será de *81.7%*. Estos podrán variar a cómo mejor se nos vaya a acomodar. 
	
	En cuanto al módulo que crearemos, le daremos como module-center *victim_to_hack*. Posteriormente, crearíamos este módulo, filtrando por vpn_status, seguido de los que hemos creado anteriormente, copiándonos de estos mismos, ya que tendrá la misma estructura.

	Aquí el script que le daremos será el *target_to_hack.sh*, y este script lo crearemos en el directorio *~/.config/bspwm/scripts*. Posteriormente, le damos permisos de ejecución, como a los anteriores. 
	
	De esta manera, hasta aquí, lo definido tendrá como contenido lo siguiente:

	* *bar/target_to_hack*:

		```
		[bar/target_to_hack]
		inherit = bar/main
		width = 15%
		height = 40
		offset-x = 81.7%
		offset-y = 15
		background = ${color.bg}
		foreground = ${color.white}
		bottom = false
		padding = 1
		;padding-top = 2
		module-margin-left = 0
		module-margin-right = 0
		;modules-left = date sep mpd
		modules-center = victim_to_hack 
		wm-restack = bspwm
		```

	* *module/victim_to_hack*:
		```
		[module/victim_to_hack]
		type = custom/script
		interval = 2
		exec = ~/.config/bspwm/scripts/target_to_hack.sh
		```

	* *target_to_hack.sh*:
		```
		#!/bin/bash
	 
		ip_address=$(/bin/cat /home/user/.config/bin/target | awk '{print $1}')
		machine_name=$(/bin/cat /home/user/.config/bin/target | awk '{print $2}')
		 
		if [ "$ip_address" ] && [ "$machine_name" ]; then
		    echo "%{F#e51d0b}󰯐 %{F#ffffff}$ip_address%{u-} - $machine_name"
		else
		    echo "%{F#e51d0b} %{u-}%{F#ffffff} No target"
		fi
		```

	Recordemos cambiar el usuario por el de ustedes. 
	
	Ahora, el script lista contenido de un archivo, el cual tiene como ruta absoluta *~/.config/bin/target*. En el directorio *.config*, no tenemos directorio *bin/* y, por ende tampoco el archivo *target*. Por ello los crearemos.

	Ya con esto no nos daría ningún error. 
	
	Ahora en nuestro archivo *.zshrc*, creamos un apartado *# custom functions*, aquí definiremos las funciones que nos ayudarán a agregar el contenido y eliminarlo del archivo *target*:

	```
	# Custom funstions

	# Set Target to hack
	function settarget(){
	    ip_address=$1
	    machine_name=$2
	    echo "$ip_address $machine_name" > /home/user/.config/bin/target
	}

	# Clear Target to hack
	function cleartarget(){
	    echo '' > /home/user/.config/bin/target
	}
	```

	Recordando colocar a su usuario en la ruta absoluta. 
	
	Con esto, si reiniciamos la zsh y ejecutamos *settarget tentacle 10.10.10.224*, funcionaría perfectamente, al igual que *cleartarget*.

3. Por último, en la polybar cambiaremos los colores de los espacios de trabajo, para en todo momento visualizar correctamente en dónde estamos trabajando y cuáles otros espacios se encuentran ocupados.

	Abriremos el archivo *workspace.ini* y filtraremos por *occupied*. Ahora cambiaremos el *active-foreground*, de su color blue, a un *red*. Esto nos ayudará a distinguir con mayor facilidad cuál es nuestra ventana actual de trabajo. 
	
	Y además, en el apartado *occupied-foreground*, cambiaremos el white a un yellow, para visualizar con facilidad qué espacios están ocupados.

4. Finalmente, instalaremos la *fzf*, este es una herramienta que nos puede servir como buscador para encontrar archivos rápidamente o listar el historial de comandos y movernos con una interfaz bastante moderna.

	Para ello, nos buscaremos [*fzf github*](https://github.com/junegunn/fzf) y nos dirigiremos a su repositorio. Aquí nos indican dos comandos a efectuar, que los haremos desde el directorio principal de cada usuario. Será por separado tanto para root como para usuario no privilegiado.
	
	```
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
	```

	Esto hace que al querer ejecutar un comando, si presionamos *ctrl + r*, nos hará una búsqueda dentro del historial de comandos, de comandos similares que hemos ejecutado anteriormente. 
	
	O si quisiéramos utilizar *cat* para algún posible archivo, bastaría con presionar *ctrl + t* y con palabras que lleguen a tener esa ruta absoluta, nos mostraría rutas similares.


## ¿Que son *NVchad* y *Neovim*?

1. #### *Neovim*

	*Neovim* es un editor de texto extensible basado en Vim, diseñado para mejorar la eficiencia en la edición de código y la experiencia del usuario. Se desarrolló como una bifurcación de Vim, con el objetivo de modernizar el código base, introducir mejoras en la arquitectura y facilitar la contribución de la comunidad. Neovim añade caracteristicas como una API mejorada para plug-ins y soporte integrado para ejecutar procesos de fondo asíncronos, lo que permite una experiencia más fluida y rica en características sin bloquear la interfaz del usuario mientras se ejecutan tareas complejas.
	</br>

2. #### *NVChad*

	*NVChad* es un framework de configuración para Neovim que ofrece una experiencia de usuario mejorada y una suite de características prediseñadas. Es conocido por su interfaz de usuario estéticamente agradable y por su enfoque en la simplicidad y la eficiencia. NVChad viene preconfigurado con una serie de plug-ins cuidadosamente seleccionados y configuracioens optimizadas que abordan tanto a la funcionalidad como a la visualización. Esto incluye soporte para temas de color, gestión de buffers mejorada, autocompletado inteligente, y mucho más, todo ello manteniendo un rendimiento rápido. NVChad está diseñado para ser fácil de instalar y configurar, ofreciendo a los usuarios una plataforma robusta sobre la cual pueden construir o adaptar según sus necesidades específicas.

Ambas herramientas están diseñadas para completarse entre sí, donde Neovim proporciona el entorno base y NVChad aprovecha y amplía sus capacidades, facilitando una experiencia de usuario altamente personalizada y eficiente para programadores y editores de texto.

## Configuración e integración de *NVChad* en *Neovim*

1. Primeramente, vamos a eliminar Neovim, que será alguno de los dos siguientes:

	```
	sudo apt remove nvim
	sudo apt remove neovim
	```

	Con esto buscaremos el repositorio con [*NVChad GitHub*](https://github.com/NvChad/NvChad) y nos iremos al apartado de [*install*](https://nvchad.com/docs/quickstart/install/). Ahora, como usuario no privilegiado en el directorio personal, ejecutaremos los siguientes comandos:

	```
	mkdir ~/.config/nvim
	git clone https://github.com/NvChad/starter ~/.config/nvim
	```

	Esto nos almacenará el repositorio en *~/.config/nvim*. 
	
	Ahora nos iremos al repositorio de [*nvim*](https://github.com/neovim/neovim), aquí nos iremos al aparato de releases y en el más reciente, descargaremos el archivo *.tar.gz*:

	![[IMG_0039.png]]

	Con esto, como usuario root crearemos una carpeta en el directorio */opt/* para el Neovim:

	```
	sudo su
	cd /opt/
	mkdir nvim
	cd !$
	```

	Ahora nos traeremos a este directorio el archivo del Neovim del directorio de descargas:

	```
	mv /home/user/Downloads/nvim.tar.gz .
	```

	Recordando cambiar el usuario por el suyo y el nombre del nvim por el que tiene el almacenado en el directorio de descargas. Luego vamos a descomprimir el archivo *.tar.gz*:

	```
	tar -xf nvim.tar.gz
	rm nvim.tar.gz
	```

	Ahora ya tendríamos todo el contenido dentro de una carpeta *nvim-linux64*, aquí internamente, si nos vamos a la sub carpeta *bin/*, aquí es donde se encuentra nuestro *nvim*, por ende tendremos que contemplar también esta ruta en el *PATH*, entonces la cargaremos en nuestro archivo *.zshrc* en nuestra línea donde exportamos el PATH, lo agregaremos:

	```
	export PATH="/opt/kitty/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/opt/nvim/nvim-linux64/bin"
	```

	Ahora ejecutaremos en terminal *nvim* como usuario no privilegiado, esto comenzará a instalarnos el *Neovim* y nos aplicaría un tema de NVChad. 
	
	Cuando todo se halla completado, solo tendremos que presionar *:q!* y darle enter. Si no nos saca rápidamente, con hacerlo en repetidas ocasiones bastará, ya que nos sacará de las otras ventanitas abiertas dentro del nvim.

	Ahora, una de las cosas que se ve dentro de nuestro *nvim* es que al final de cada línea se nos queda un *$*. Este lo eliminaremos con una línea específica en el archivo *init.lua*, el cual está en el directorio *~/.config/nvim*.

	```
	vim.opt.listchars = "tab:»·,trail:·"	
	```

	Esta indicación hace que ya no se muestre este símbolo. Lo pegaremos justo después de las primeras dos instrucciones, en la primera línea libre que veamos. Guardamos y cerramos. 
	
	Ahora, al abrir algún archivo, ya no se mostraría este símbolo.
	</br>

2. Instalaremos *locate*, lo cual es una utilidad que nos ayudara a encontrar de forma rápida archivos del sistema.

	```
	sudo apt install locate -y
	```

	Una vez instalado, ejecutaremos:

	```
	sudo updatedb
	```

	Parecerá que hay un problema si llega a mostrar que no se tiene el permiso de acceder a algunas rutas absolutas. Con esto realmente no hay problema, ya que con desmontarlos con *umount* bastaría. En este caso son dos rutas y bastaría con efectuar los siguientes comandos:

	```
	umount /run/user/1000/doc
	umount /run/user/1000/gvfs
	```

	Verifica que sean las mismas rutas que a ti te dio. En caso de que no, simplemente acomódalo para las rutas a las cuales te salía que no tenías permiso. Con esto listo, ahora cuando volvamos a realizar un *sudo updatedb* ya no habrá ningún problema.

	El *updatedb* lo que hace es cómo cargar todos los archivos, para que al utilizar *locate* pueda encontrar lo que buscamos sin ningún problema.

	Un ejemplo sería buscar todos los archivos *init.lua* que se encuentran en el sistema operativo, esto se haría simplemente con:

	```
	locate init.lua
	```

	Lo cual los listará.
	</br>

3. Los lenguajes no preinstalados los reconocerá *nvim*, nos daremos cuenta, ya que en la parte inferior nos aparecerá un mensaje, pero solucionarlo bastaría con preisonar *:* y escribir MasonInstallAll. 

   Si lo hiciéramos para el archivo init.lua, al volverlo a abrir ya no habría ningún problema.
   </br>

4. Cosas que se pueden realizar con nvim:

	Las combinaciones de teclas que se representen con *->* en nvim se hacen por separado, ya que nvim va registrando las teclas que presionemos, para tomarlo como un tipo de comando y realizar las acciones que necesitemos.
   
	*  *Seleccionar tema para nvim*: Si presionamos *esc* y luego *espacio -> t -> h*, esto nos abrirá un menú de temas, ya que en nvim con nvchad, podremos seleccionar el tema que más nos agrade.

	* *Navegar entre subdirectorios*: Al presionar *esc* y luego *ctrl + n*, como estamos empleando nvchad, a la izquierda nos estaría abriendo las carpetas y sub carpetas del directorio en el que estemos trabajando y podremos navegar y abrir archivos.
	
	* *Creación de nuevos archivos*: Al entrar al menú que nos permite navegar entre subdirectorios, si presionamos la tecla *a*, en la parte inferior se nos pone el directorio actual y ahí podríamos escribir el nombre del archivo. Al darle enter, este se nos crearía.
	
	* *Eliminación de archivos:* Al estar en el menú que nos permite navegar entre los archivos, siempre habrá uno seleccionado, podremos cambiar entre ellos con las flechas si así lo deseamos, si presionamos la tecla *d*, nos preguntará si estamos seguros de eliminar el archivo que estaba seleccionado y con presionar *y*, estaríamos borrándolo.

	* *Renombrar archivos:* Si presionamos la tecla *r*, nos pondrá en la parte inferior su nombre actual, podremos borrarlo y cambiarlo. Al dar enter se realizará el cambio.

	* *Copear y pegar archivos:* Si presionamos la tecla *c*, nos copiaría el archivo seleccionado. Podremos movernos entre directorios y si quisiéramos pegarlo 2 subdirectorios dentro, bastaría con colocarnos en él mediante el uso de las flechas y presionar *p*; de esta forma haríamos una copia.
   
	* *Navegar entre archivos de la sesión actual*: Cuando tengamos múltiples archivos abiertos, podríamos navegar entre ellos con solo utilizar el teclado, presionando *esc* y después *espacio -> f -> b*, aquí nos mostrará todos los archivos abiertos actualmente, además de una previsualización. Para abrir uno deseado, solo daríamos enter.

	* *Búsquedas en subdirectorios*: Podremos realizar búsqueda de archivos del directorio actual, así como de sus subdirectorios. Para ello simplemente haremos un *esc* y después *espacio -> f -> f*, esto nos abrirá un buscador y aquí podremos buscar por lo que deseemos.

	* *Abrir terminales*: Podríamos abrir una terminal dentro del nvim, con presionar *esc* y después *espacio -> v* para abrirla de forma vertical o, en su lugar, *espacio -> h* para abrirla de forma horizontal.

	  Ya si quisiéramos salir de esta misma, bastaría con presionar *esc*.
	  </br>

5. Además, nvim cuenta con modos de visualización que pudiéramos requerir con base en el tipo de archivo que estemos abriendo.

	* *vsp*: si presionamos *esc* y luego escribimos *:vsp*, esto nos crearía una copia visual exacta del archivo con el que estemos trabajando, lo cual se abriría de forma vertical y a un lado del actual, de esta manera podríamos navegar en el segundo, sin perder de vista algo especifico que tengamos en el primero. Para salir bastaría con presionar *esc* y después escribir *:q!* y darle al enter.

	* *sp*: es lo mismo que el anterior, pero en lugar de abrirlo con *:vsp*, lo abriríamos con *:sp*. Esto lo abriría de forma horizontal y debajo.

6. NVChad cuenta con una hoja donde podremos visualizar los comandos. Para poder verla o abrirla, bastaría con presionar *esc* y después *espacio -> c -> h*. Podremos salir de esta con presionar la letra *q*.


## Configurando el tema para el *rofi*

1. Rofi de primeras se ve un poco feo, para ello agregaremos un tema nosotros.

	Para ello, en nuestro directorio *~/.config/* crearemos el directorio *rofi/* como usuario no privilegiado:

	```
	mkdir ~/.config/rofi
	```

	Nos metemos en este directorio y ahora crearíamos un directorio *themes*:

	```
	cd !$
	mkdir themes
	cd !$
	```

	Dejaríamos este panel en el directorio themes y abriríamos un nuevo panel con *ctrl + shift + enter*. En este nos dirigiríamos a la ruta /opt/ como usuario root y nos clonaríamos un repositorio:

	```
	git clone https://github.com/newmanls/rofi-themes-collection.git
	```

	Aquí nos meteríamos al directorio que cree y dentro de este al directorio *themes/*:

	```
	cd rofi-themes-collection/themes
	```

	Aquí adentro notaremos que tendremos muchos archivos *.rasi*, y lo que haremos es copiarlo al directorio previamente creado:

	```
	cp ./* /home/user/.config/rofi/themes/
	```

	Realizamos un *Windows + shift + r* para recargar la configuración y ahora, si ejecutamos *rofi-theme-selector*, esto nos permitirá seleccionar entre algún tema para el rofi. 
	
	En este apartado, presionamos una vez la tecla hacia arriba y aquí estarán los temas que hemos metido. Podremos ir presionando enter en cada tema hasta encontrar el que nos guste más y, una vez lo tengamos seleccionado, solo tendremos que presionar *alt + a*.

	Ahora, al abrir rofi, ya tendrá una mejor estética.

## Bloqueando la pantalla con *i3lock*


1. Primeramente, tendremos que instalar *i3lock*, para ello lo haríamos con apt:

	```
	sudo apt install i3lock
	```

	Ahora buscaríamos el repositorio de [*i3lock-fancy*](https://github.com/meskarune/i3lock-fancy), así que nos meteríamos al directorio /opt/ y como usuario root nos clonaríamos el repositorio:

	```
	git clone https://github.com/meskarune/i3lock-fancy.git
	```

	Nos metemos al directorio que cree, en este caso *i3lock-fancy* y efectuamos el siguiente comando:

	```
	make install
	```

	Con esto, para comprobar que haya sido instalado, utilizamos:

	```
	which i3lock-fancy
	```

	Si esto nos regresa su ruta absoluta, quiere decir que todo ha salido bien y ya lo tenemos instalado. 
	
	Ahora podríamos ejecutar *i3lock-fancy*, para ello antes tendríamos que regresar al usuario no privilegiado, esto debido a que root como tal, no tiene contraseña y por ello no podríamos ingresar de nuevo si lo intentáramos.

	```
	i3lock-fancy
	```

	De esta manera se bloquearía y, al colocar nuestra contraseña, iría todo bien. 
	
	Con esto en nuestro archivo *sxhkdrc*, al final del todo agregaríamos un nuevo atajo de teclado, para bloquear rápidamente nuestra máquina si así lo deseáramos:

	```
	# i3lock-fancy
	super + shift + x
		/usr/bin/i3lock-fancy
	```

	Una vez guardado, actualizamos nuestra configuración de sxhkdrc con *Windows + esc* y ahora estaría funcionando correctamente.

## Último detalle con nvim

1. Esto será totalmente al gusto de cada uno, pero nvim cuenta con una ventana emergente la cual te ofrece sugerencias al ir escribiendo el código. Esto podría ser más molesto en ciertas ocasiones.

	Por ende, para eliminar esto y no moleste, al igual que podría serlo el *zsh-autocomplete*, tendríamos que abrir el siguiente archivo:
	
	```
	nvim ~/.local/share/nvim/lazy/NvChad/lua/nvchad/plugins/init.lua
	```
	
	Aquí filtraríamos presionando */* y escribiendo *cmp*; de este modo, nos llevaría al inicio de este apartado y borraríamos desde donde se abre la llave hasta donde se cierra. 
	
	Esto lo realizaríamos presionando colocándonos al inicio de este apartado, luego presionamos *esc* y después *v* para entrar en modo visual, hacemos la selección desde donde se abre el primer corchete hasta donde se cierra ese mismo, que lo notaremos porque estará en la misma posición, pero líneas más abajo y una vez seleccionadas las líneas presionamos *d*, esto las eliminaría.
	
	Finalmente, guardamos con *:wq* y nos cerraría también el nvim. Con esto listo, si volviéramos a abrir el nvim, ya no tendríamos este mismo problema.
	</br>

2. Ahora, todo lo que hemos hecho para nvim, solo estará para el usuario no privilegiado, para que root también tenga todo de la misma manera. Primeramente, nos convertiríamos en root y nos iríamos a su directorio personal.

	Con esto nos tendríamos que crear el directorio nvim en .config, sé la siguiente manera:

	```
	mkdir ~/.config/nvim
	cd !$
	```

	Y ahora nos traemos todo el contenido, del mismo directorio, pero del usuario no privilegiado, hacia este:
	
	```
	cp -r /home/user/.config/nvim/* .
	```

	Con esto listo, cerramos la terminal y abrimos una nueva. Ahora vamos a ejecutar nvim y esperamos a que se realice toda la configuración. 
	
	Para arreglar el mismo problema de algunos lenguajes no instalados, entraremos como root al directorio */root/.config/nvim/* y abriremos el archivo *init.lua*, ahora presionando *:* escribiremos *MasonInstallAll*, dejamos que se instale todo y ahora si cerramos y abrimos nuevamente ya no tendríamos este problema.

	Ahora, como usuario root eliminamos también el tipo de ayuda que nos proporciona al ir escribiendo nuestro código, lo cual está en la ruta:

	```
	nvim ~/.local/share/nvim/lazy/NvChad/lua/nvchad/plugins/init.lua
	```

	Recordemos hacerlo como root, repitiendo lo que hicimos para el usuario no privilegiado.

## Configuración en Firefox


1. Primeramente, en configuración vamos a filtrar por el historial y vamos a configurarlo para que no guarde ni recuerde el historial.
	</br>

2. Ahora, un problema que llega a pasar es que cuando llegamos a resolver una máquina y a nivel de dominio tenemos *mantis.htb*, se suele dar el problema que en lugar de entrar a la página esperada, lo busque en el buscador del navegador, para evitar esto, tendremos que irnos al buscador de nuestro navegador y escribir *about\:config* y tendremos lo siguiente:

	![[IMG_0041.png]]

	Ahora, en el buscador que nos brinda, buscaremos lo siguiente:

	```
	browser.fixup.domainsuffixwhitelist.htb
	```

	![[IMG_0042.png]]

	Aquí le daremos al *+*, de esta manera como por defecto estará en true, ya estaremos seguros de que cuando intentemos utilizar *mantis.htb* ya intentará resolverlo y no lo buscara en el buscador:

	![[IMG_0043.png]]
	</br>

3. Buscaremos y agregaremos la extensión *Wappalyzer extensión* y le daremos permisos para correr en ventanas privadas.

	Esta extensión es un plug-in que al ejecutarlo en una página, nos detectara las tecnologías que esta misma emplea. Lo cual vendrá bien de cara a la etapa de reconocimiento cuando se resuelven máquinas.

4. Ahora buscaríamos por *foxiproxy addon*, lo cual será otra extensión que nos servirá para enviar las solicitudes al *burpsuite*.

	Vamos a generar un ejemplo con esto, en un espacio de trabajo abriremos el *burpsuite*, podríamos hacerlo con rofi, recordando que lo que nos lo lanzaría de forma correcta es el script que configuramos *burpsuite-launcher*, entrando le damos a *next* e *iniciar*. 
	
	De aquí nos iríamos a *proxy* y en proxy a *proxy settings*:

	![[IMG_0044.png]]

	Aquí vemos que tenemos un proxy en el equipo local por el puerto 8080 ya configurado. 
	
	De esta forma, presionamos en foxyproxy y en el apartado de opciones, dándonos una ventana así:

	![[IMG_0045.png]]

	Aquí nos iríamos a *proxies* y crearíamos uno nuevo con *Add*, colocándole lo siguiente:

	![[IMG_0046.png]]

	Le damos a guardar y ya con esto, si lo activáramos, presionando en la extensión:

	![[IMG_0047.png]]

	Ahora, al realizar una búsqueda, por ejemplo *google.es*, esto se enviaría mediante el *burpsuite*, aquí interceptaría la petición y burpsuite se encargaría de enviarla a su destino, de la siguiente manera:

	![[IMG_0048.png]]

	El navegador queda en espera, aquí le daremos a *Forward* y después a *Intercept is on* para dejar que la petición siga fluyendo. 
	
	Esto de primeras nos dará un error en nuestro navegador, para solucionarlo tendremos que buscar por http://burp/ y le daremos a *CA Certificate*, lo cual será para viajar e interceptar de forma segura por páginas https.

	Esto lo almacenaremos en el directorio de descargas y luego en el navegador nos iremos a configuraciones, buscamos por *certificates* y finalmente en el apartado *autorithies* cargamos el recién descargado y vamos a seleccionar únicamente la primera casilla, para después guardarlo.

	![[IMG_0049.png]]

	De esta forma, si volviésemos a intentarlo, ahora sí iría todo bien y podríamos interceptar búsquedas, hacer investigaciones y entre otras cosas para las que podríamos utilizar esta herramienta.
## Repaso por los atajos de teclado definidos

| Nombre                                                  | Atajo                              |
| ------------------------------------------------------- | ---------------------------------- |
| Abrir terminal                                          | Windows + enter                    |
| Cerrar aplicación                                       | Windows + q                        |
| Abrir rofi                                              | Windows + d                        |
| Preselectores                                           | ctrl + windows + alt + flecha      |
| Preselectores preestablecidos                           | ctrl + windows + numero            |
| Resize en ventanas                                      | windows + alt + flecha             |
| Mover una ventana a la posición de otra                 | windows + shift + flecha           |
| Mover ventana a uno de los 9 espacios del escritorio    | windows + shift + numero_espacio   |
| Desacoplar ventana                                      | windows + s                        |
| Mover una ventana desacoplada                           | windows + click_izquierdo          |
| Resize a una ventana desacoplada                        | windows + click_derecho            |
| Acoplar nuevamente una ventana                          | windows + t                        |
| Maximizar una ventana                                   | windows + f                        |
| Regresar al tamaño que tenía                            | windows + t                        |
| Bloquear pantalla (solo como usuario no privilegiado)   | windows + shift + x                |
| Abrir un nuevo panel en la kitty                        | ctrl + shift + enter               |
| Cerrar un panel en la kitty                             | ctrl + shift + w                   |
| Resize en paneles de la kitty      \|\|       salir     | ctrl + shift + r       \|\|      q |
| Zoom a un panel en la kitty                             | ctrl + shift + z                   |
| Crear nuevo espacio de trabajo en la kitty              | ctrl + shift + t                   |
| Renombrar un espacio de trabajo en la kitty             | ctrl + shift + alt + t             |
| Cerrar un espacio de trabajo en la kitty                | ctrl + shift + q                   |
| Alternar espacios de trabajo en la kitty a la izquierda | ctrl + shift + ,                   |
| Alternar espacios de trabajo en la kitty a la derecha   | ctrl + shift + .                   |
| Moverse entre espacios de trabajo de la kitty           | ctrl + shift + flecha izq/derecha  |
| Buscar por archivos específicos                         | ctrl + t (desde terminal)          |
| Buscar sobre el histórico de comandos por similares     | ctrl + r (desde terminal)          |

