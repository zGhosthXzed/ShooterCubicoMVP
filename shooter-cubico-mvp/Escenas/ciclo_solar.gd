extends DirectionalLight3D

# Velocidad de rotación del sol (grados por segundo)
var velocidad_tiempo = 15.0 

func _process(delta):
	# Rota el sol en el eje X continuamente
	rotation_degrees.x -= velocidad_tiempo * delta
