
[![N|Solid](https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg)](https://laravel.com)
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://github.com/DeuxMachin/TI3_2023)
# CINAP UCT

## Objetivo del proyecto.

El objetivo principal del proyecto es desarrollar una aplicación móvil para el **CINAP** de la Universidad Católica de Temuco. En donde facilite la comunicación y el acceso a docentes a los servicios institucionales, que les permita solicitar apoyo a los asesores pedagógicos y acceder a información y recursos relevantes para mejorar su práctica docente.

## Índice
1. [Objetivos](#Objetivo) 
2. [Instalación y uso](#Instalacion_y_uso) 
3. [Sección 3](#sección-3)

## Descripción del proyecto.

Consiste principalmente en el desarrollo de una aplicación móvil para el *Centro de innovación en aprendizaje docencia y tecnologías educativas* o ***CINAP*** de la ***Universidad Católica de Temuco***, con el objetivo de facilitar la comunicación y el acceso a servicios institucionales para los docentes, así como brindarles herramientas para mejorar su práctica educativa. La aplicación contará con funcionalidades clave como la solicitud de apoyo pedagógico, acceso a recursos didácticos y materiales de apoyo, instancias de formación y una comunidad docente para fomentar la interacción y colaboración entre los docentes. Además, se implementarán medidas de seguridad y protección de datos para garantizar la confidencialidad de la información personal de los docentes.

## Demostración del Proyecto

| Bienvenida para los usuarios que estén entrando | Menú de inicio para usuarios |
|---|---|
| [![Inicio.png](https://i.postimg.cc/0jBLHwVk/Inicio.png)](https://postimg.cc/302SkdMV)|[![Home.png](https://i.postimg.cc/ZRVkpg3y/Home.png)](https://postimg.cc/zbbP1xxJ)|

| Zona de agendamiento, sin seleccionar "Asesor" | Asesor seleccionado al momento de agendar |
|---|---|
| [![Agendar.png](https://i.postimg.cc/tCgqSd4j/Agendar.png)](https://postimg.cc/8sqgs6vK) |[![Agendar2.png](https://i.postimg.cc/0QfvZrgj/Agendar2.png)](https://postimg.cc/TLpB3d3v) |

| Selección de agendamiento | Disponibilidad para los asesores |
|---|---|
|[![Agendar3.png](https://i.postimg.cc/ncwH6sXQ/Agendar3.png)](https://postimg.cc/2VhRWSFz)| [![Agendar4.png](https://i.postimg.cc/SsqqWCvH/Agendar4.png)](https://postimg.cc/gwMfpXdK)|

| ChatBot | Vista de foro |
|---|---|
| [![Bot.png](https://i.postimg.cc/SR1hF5xp/Bot.png)](https://postimg.cc/MfB419Bs) | [![Foro.png](https://i.postimg.cc/zGbJ5Jh2/Foro.png)](https://postimg.cc/xXQr3VtL) |

| Vista al seleccionar opciones en el foro | Crear publicación |
|---|---|
|[![Foro1.png](https://i.postimg.cc/bw7qwKHy/Foro1.png)](https://postimg.cc/RWLkPpDy)| [![Foro2.png](https://i.postimg.cc/zGg16xm9/Foro2.png)](https://postimg.cc/68tSGLp0) |

| Vista para editar o eliminar publicaciones | Vista foro respuestas |
|---|---|
| [![Foro3.png](https://i.postimg.cc/MHTCDDb3/Foro3.png)](https://postimg.cc/8J2XkLYL) |[![Foro4.png](https://i.postimg.cc/4dJkKZKg/Foro4.png)](https://postimg.cc/wtbbPCcf) |

## Principales funcionalidades del proyecto.

El proyecto busca presentar una plataforma en línea diseñada específicamente para el personal docente de la ***Universidad Católica de Temuco***. Acá se detallaran sus principales funcionalidades de manera que cualquier persona, sin conocimientos informáticos, pueda entenderlas:

1. ***Acceso Exclusivo****: Los profesores pueden ingresar únicamente con sus correos institucionales, lo que garantiza un entorno seguro y privado.

2. ***Panel de Inicio Personalizado:*** Al entrar, los docentes encuentran un panel de inicio personalizado con sus cursos relevantes y acceso rápido a páginas institucionales.

3. ***Sistema de Asesorías y Cursos:*** Existe una sección dedicada donde los docentes pueden buscar y matricularse en cursos o sesiones de asesoría que son pertinentes para su enseñanza y desarrollo profesional.

4. ***Agendamiento de Citas:*** Los miembros de la facultad pueden programar citas con los asesores que elijan. Al hacer clic en el perfil de un asesor, son dirigidos a un calendario donde pueden seleccionar fechas disponibles, elegir la hora y especificar la duración necesaria para la sesión.

5. ***Asistencia Automatizada:*** Un chatbot está disponible para responder consultas básicas, como horarios de oficina o información de contacto, mejorando la eficiencia de la comunicación y proporcionando soporte instantáneo.

6. ***Página de Perfil Personal:*** Hay una página de perfil donde los docentes pueden ver su nombre e información de cuenta, asegurándose de que están conscientes de la cuenta con la que están actualmente conectados.

7. ***Foro Interactivo:*** Un foro interactivo permite a todos los usuarios conectados crear, responder y participar en discusiones. Esta característica fomenta la interacción comunitaria y el apoyo entre pares.

8. ***Gestión de Contenido:*** En la sección 'Mis Publicaciones', los usuarios pueden gestionar sus contribuciones al foro editando o eliminando sus publicaciones, dándoles control sobre el contenido que comparten.

Como función principal se busca dar una solución centralizada para el desarrollo académico y profesional del personal docente en la ***Universidad Católica de Temuco***, ofreciendo una gama de herramientas para la comunicación, el aprendizaje y la colaboración.




## Como instalar y usar el proyecto.

### 1)  Herramientas Requeridas/Utilizadas 🔧:
#### Requisitos Previos

- **Flutter SDK** (versión 3.13.4): Descargable desde [Flutter](https://flutter.dev/).
- **Android Studio** (versión 3.1.19): Necesario para el emulador y herramientas de desarrollo.
- **Visual Studio Code**: Recomendado para edición y depuración del código.
- **Firebase**: Utilizado para backend y servicios en la nube.
- **APIs de Google**: Para funcionalidades específicas que requieran servicios de Google.

#### Configuración del Entorno

1. **Instalar Android Studio**: Descarga desde el sitio oficial y sigue las instrucciones de instalación.
2. **Instalar y Configurar Flutter**: Descarga Flutter SDK y añade la ruta del directorio `flutter\bin` a la variable `Path` en las variables de entorno del sistema.
3. **Verificar Instalación**: Ejecuta `flutter doctor` en la terminal para asegurarte de que todas las herramientas necesarias estén correctamente instaladas.
4. **Crear Proyecto Flutter**: Usa `flutter create nombre_del_proyecto` en la terminal para iniciar un nuevo proyecto.

#### Ejecución del Proyecto

- **Con Android Studio**: Abre el emulador y ejecuta `flutter run` en la terminal del proyecto.
- **Con Visual Studio Code**: Abre el proyecto y el emulador, luego usa el comando `flutter run`.
#### 2.1) Instalación de Android Estudio.
-  Se deberá realizar la descarga en el sitio oficial, donde uno deberá seleccionar la opción de descarga que se le acomode.
- Para poder configurar android studio se deberá seguir las instrucciones de instalación.
#### 2.2) Instalación y configuración de Flutter.
- Descargar Flutter de la pagina oficial y instalar el SDK para el sistema operativo que se vaya a utilizar.
- Se deberá realizar una extracción de los archivos y al Realizar esto se configurara el PATH, así obtendremos un correcto uso. 
- Para Windows. Buscaremos "Variables de Entorno", "Editar las variables de entorno del sistema".
- Agrega la ruta del directorio `flutter\bin` a la variable `Path`.
- Se verificaran los requisitos que trae flutter para confirmar su correcto funcionamiento, usando el comando `flutter doctor`. Esto se hace para verificar que se encuentran todas las herramientas instaladas.
- En la terminal o línea de comandos, en el directorio donde se vaya a crear el proyecto. Ejecuta el comando `flutter create nombre_del_proyecto`. Esto generará una carpeta llamada `nombre_del_proyecto` con todos los archivos iniciales de un proyecto Flutter.
Datos Importantes:
Antes de iniciar el proyecto se deberá tener un emulador de dispositivos móviles, debido a esto se debe tener un emulador como *Android Studio* o alguna otra variante.
#### 2.3) Inicio de Flutter
- Existen dos manera de poder ejecutar el proyecto, ***mediante Android Studio y otra gracias a Visual Studio Code*** .
- Estando en visual con el proyecto abierto lo primero que se deberá realizar es abrir el emulador de dispositivo móvil. Abajo a la derecha de visual saldrá una opción para abrir un emulador.
 - Al realizar esto y que haya cargado nuestro emulador, iniciaremos el comando `flutter run`.

### 3) Archivos Importantes en Flutter

1. **`pubspec.yaml`**: Gestiona la configuración del proyecto y sus dependencias. Es esencial para definir las versiones de Flutter, paquetes externos y recursos como imágenes o fuentes.
2. **Directorio `lib/`**: Contiene el código Dart principal, incluyendo archivos para pantallas, widgets personalizados y modelos de datos.
3. **Archivos de Plataforma (`AndroidManifest.xml`, `Info.plist`)**: Claves para la configuración específica de cada plataforma, como permisos y configuraciones del sistema operativo.
4. **Directorios `assets/` y `images/`**: Almacenan recursos como imágenes y fuentes, cuyo uso se define en `pubspec.yaml`.
5. **`main.dart`**: El punto de entrada de la aplicación Flutter, donde se inicia y define la clase principal.
6. **`.gitignore`**: Indispensable para controlar qué archivos se excluyen en el repositorio git, evitando subir archivos sensibles o innecesarios.

## Créditos y Derechos.
-  **Edward Contreras** - Scrum Master - [DeuxMachin](https://github.com/DeuxMachin)
-  **Joaquín Aguilar** - Desarrollador - [Juaker1](https://github.com/Juaker1)
-  **Patricio Arratia** - Desarrollador - [patoskixd](https://github.com/patoskixd)
-  **Diego Alveal** - Desarrollador - [dalvealinf](https://github.com/dalvealinf)
- **Ignacio Cancino** - Desarrollador  - [Ignacio-Cancino1](https://github.com/Ignacio-Cancino1)


