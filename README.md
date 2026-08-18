# 🎯 Shooter Cúbico Competitivo (MVP)

Un videojuego de disparos competitivo con mecánicas *hitscan*, diseño de niveles simétrico y una estética *low-poly* limpia, desarrollado en **Godot 4**.

## 📸 Vistas del Proyecto

Aquí se muestra el progreso del diseño de niveles modular y el entorno de pruebas:

<img width="1353" height="705" alt="e1" src="https://github.com/user-attachments/assets/51e2b58c-f393-4cb0-b107-db215ccd3e06" />


*Vista superior geométrica del mapa en el editor de Godot, mostrando la simetría y construcción mediante nodos CSG.*

<img width="1163" height="724" alt="e2" src="https://github.com/user-attachments/assets/bcc1750a-41f4-41f6-b9d5-34d032d4f7cd" />

*Vista en primera persona del entorno low-poly en ejecución, probando los blancos reactivos rojos y los contrastes de materiales.*

## 🛠️ Herramientas Utilizadas

* **Motor de Juego:** Godot 4 (Nodos CSG para *greyboxing* rápido y diseño de nivel nativo).
* **Lenguaje de Programación:** GDScript.
* **Control de Versiones:** Git.
* **Gestión de Repositorios:** GitHub Desktop.

## 📂 Estructura del Proyecto

El proyecto está dividido modularmente para permitir que los desarrolladores trabajen en paralelo sin generar conflictos en las escenas (`.tscn`):

* `mundo.tscn`: Escena principal que contiene el diseño de nivel *low-poly*, las coberturas, la iluminación global y el ciclo de día/noche.
* `jugador.tscn`: Controlador FPS, cámara de jugador y sistema de disparo *hitscan* mediante raycasting (`RayCast3D`).
* `blanco.tscn`: Entidades estáticas y objetivos de prueba reactivos al daño, instanciados en el mundo (algunos con movimiento usando rutas `Path3D`).
* **Materiales Compartidos:** Uso de recursos `.tres` (como `Material_Suelo`, `Material_Paredes`) para mantener la coherencia visual y optimizar el rendimiento.

## 🔄 Metodología de Trabajo

Somos un equipo de 3 desarrolladores siguiendo un flujo de trabajo estricto para evitar conflictos de fusión (*merge conflicts*) en los archivos de Godot:

1.  **Sincronización Obligatoria:** Siempre realizamos un `Fetch origin` seguido de un `Pull` en GitHub Desktop antes de comenzar a editar cualquier nodo en el motor.
2.  **Desarrollo Modular por Roles:**
    * **Desarrollador 1:** Encargado de la base mecánica del jugador, cámara y registro del disparo (*hitscan*).
    * **Desarrollador 2:** Encargado de programar la lógica de las entidades y blancos de prueba.
    * **Desarrollador 3:** Encargado del diseño de niveles simétrico con mallas primitivas (CSGCombiner3D/CSGBox3D), iluminación y configuración de rutas para enemigos móviles.
3.  **Commits Modulares y Atómicos:** Realizamos *commits* enfocados y descriptivos únicamente sobre las partes que nos corresponden modificar.
4.  **Composición por Instancias:** El juego se ensambla instanciando las escenas individuales (`jugador.tscn` y `blanco.tscn`) dentro del mapa principal (`mundo.tscn`), en lugar de editar todo dentro de un mismo árbol de nodos.

## 🎮 Características Actuales (Fase de Pruebas)

* **Geometría:** Construcción de mapas usando bloques CSG con físicas activadas (`Use Collision = true`) y sustracciones booleanas.
* **Precisión Hitscan:** Pruebas de trazado de rayos instantáneos en una galería de tiro contra blancos fijos y móviles.
* **Atmósfera:** Ciclo de día/noche dinámico impulsado por GDScript (`ciclo_solar.gd`) afectando a un `DirectionalLight3D` y `ProceduralSkyMaterial`.
