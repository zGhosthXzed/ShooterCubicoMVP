extends StaticBody3D

# Esta función la llamará el láser del jugador cuando impacte
func recibir_dano():
	print("¡Un blanco fue destruido!")
	# queue_free() es la función de Godot para eliminar un nodo del juego
	queue_free()
