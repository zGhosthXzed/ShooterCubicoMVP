extends CharacterBody3D

# Variables para ajustar el movimiento
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSIBILIDAD_RATON = 0.003

# Obtenemos la gravedad por defecto del proyecto
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Referencias a los nodos
@onready var camara = $Camera3D
@onready var raycast = $Camera3D/RayCast3D

func _ready():
	# Forzamos la captura y ocultamiento del cursor al iniciar el juego
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	# Rotación de la cámara con el movimiento del ratón
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * SENSIBILIDAD_RATON)
		camara.rotate_x(-event.relative.y * SENSIBILIDAD_RATON)
		camara.rotation.x = clamp(camara.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
	# Lógica de disparo con el clic izquierdo
	if Input.is_action_just_pressed("disparar"):
		if raycast.is_colliding():
			var objetivo = raycast.get_collider()
			if objetivo.has_method("recibir_dano"):
				objetivo.recibir_dano()

	# Liberar el ratón o salir del juego pulsando ESC
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Aplicamos gravedad si no estamos en el suelo
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Manejamos el salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimiento con WASD
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
