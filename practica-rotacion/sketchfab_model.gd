extends Node3D # O el tipo de nodo que sea Sketchfab_model

@onready var esqueleto: Skeleton3D = $d2106fc687844c499d1fa3e7b792e9ee_fbx/RootNode/Armature/Object_4/Skeleton3D 
# ^ Asegúrate de que esta ruta (Path) es correcta para tu Skeleton3D

func _process(delta):
	# ¡Función clave! Llama a 'ForceUpdateTransfers' en cada frame.
	# Esto le dice al esqueleto que debe actualizar la malla inmediatamente.
	esqueleto.force_update_all_bone_transforms()
