extends CharacterBody3D

# Variables que puedes ajustar para cambiar cómo se siente el juego
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSIBILIDAD_RATON = 0.003

# Obtenemos la gravedad por defecto del proyecto
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Hacemos una referencia a nuestro nodo Camera3D
@onready var camara = $Camera3D

func _ready():
	# Cuando el juego empieza, ocultamos y capturamos el cursor del ratón
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	# Detectamos si el evento es un movimiento del ratón
	if event is InputEventMouseMotion:
		# Rotamos el cuerpo entero hacia los lados (Eje Y)
		rotate_y(-event.relative.x * SENSIBILIDAD_RATON)
		# Rotamos SOLO la cámara hacia arriba y abajo (Eje X)
		camara.rotate_x(-event.relative.y * SENSIBILIDAD_RATON)
		
		# Limitamos la cámara para que no puedas dar vueltas de campana con el cuello
		camara.rotation.x = clamp(camara.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
	# Para poder salir del juego pulsando ESC
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta):
	# Aplicamos la gravedad si no estamos tocando el suelo
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Manejamos el salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Obtenemos la dirección del movimiento (por defecto usa flechas, pero podemos cambiarlo a WASD)
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Calculamos hacia dónde debemos movernos basándonos en hacia dónde estamos mirando
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Esta función mágica hace que el personaje se mueva y se deslice por las paredes
	move_and_slide()
