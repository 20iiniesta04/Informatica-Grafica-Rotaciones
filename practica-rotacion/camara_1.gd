extends Camera3D

# Referencia al rayo láser
@onready var ray = $RayCast3D

func _input(event):
	# 1. SEGURIDAD: Si esta cámara no está activa, no hace nada.
	if not current:
		return

	# 2. Detectar clic izquierdo
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		# Calcular la posición del rayo
		var mouse_pos = get_viewport().get_mouse_position()
		var from = project_ray_origin(mouse_pos)
		var to = from + project_ray_normal(mouse_pos) * 1000.0
		
		# Mover el rayo y disparar
		ray.global_position = from
		ray.target_position = ray.to_local(to)
		ray.force_raycast_update()
		
		# 3. ¿Hemos tocado algo?
		if ray.is_colliding():
			var objeto = ray.get_collider()
			
			# SOLO INTERACCIÓN:
			# Si el objeto tiene la función "interactuar" (como tu muñeco Pim), la ejecutamos.
			if objeto.has_method("interactuar"):
				objeto.interactuar()
			else:
				print("Tocado: ", objeto.name, " (No tiene luz/interacción)")
