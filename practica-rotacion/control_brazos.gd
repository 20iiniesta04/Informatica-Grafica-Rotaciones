extends Node3D

@export var activador_global := "ui_select" # Ejemplo: la tecla Enter
var animacion_activa := true

func _ready():
	# Aseguramos que los BoneAttachments tienen su proceso habilitado inicialmente
	for child in get_children():
		if child is BoneAttachment3D:
			child.set_process(animacion_activa)

func _process(delta):
	if Input.is_action_just_pressed(activador_global):
		animacion_activa = !animacion_activa
		
		# Desactiva o activa el _process de los BoneAttachments hijos
		for child in get_children():
			if child is BoneAttachment3D:
				child.set_process(animacion_activa)
		
		print("Animación de brazos activa: ", animacion_activa)
