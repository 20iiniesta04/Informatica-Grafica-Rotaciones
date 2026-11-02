extends BoneAttachment3D

@export var velocidad_rotacion_deg := 60.0 # Velocidad en grados/segundo
var limite_x = deg_to_rad(90.0) 

func _process(delta):
	
	# Rotación en el eje X (Arriba/Abajo)
	if Input.is_action_pressed("brazo_arriba"):
		print("Detectada accion: brazo_arriba")
		# Rotar en X: subir
		rotation.z += deg_to_rad(velocidad_rotacion_deg * delta)
	if Input.is_action_pressed("brazo_abajo"):
		# Rotar en X: bajar
		rotation.z -= deg_to_rad(velocidad_rotacion_deg * delta)

	# Rotación en el eje Y (Adelante/Atrás)
	if Input.is_action_pressed("brazo_adelante"):
		# Rotar en Y: adelante
		rotation.y += deg_to_rad(velocidad_rotacion_deg * delta)
	if Input.is_action_pressed("brazo_atras"):
		# Rotar en Y: atras
		rotation.y -= deg_to_rad(velocidad_rotacion_deg * delta)

	# Restricciones (Opcional)
	rotation.x = clamp(rotation.x, -limite_x, limite_x)
