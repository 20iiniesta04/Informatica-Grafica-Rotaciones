extends Node3D

# Velocidad de giro (radianes por segundo). 
# Prueba con 0.5 para lento o 2.0 para rápido.
var velocidad = 1.0

func _process(delta):
	# Hacemos rotar el soporte en el eje Y (el vertical)
	rotate_y(velocidad * delta)
