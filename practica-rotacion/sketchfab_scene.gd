extends Node3D

# Referencia a la cámara fija (hija directa del nodo raíz)
@onready var camara_1 = $Camara1

# Referencia a la cámara rotatoria
# IMPORTANTE: Como Camara2 está dentro del "SoporteCamara" para poder girar,
# la ruta debe incluir al padre.
@onready var camara_2 = $Pivote/Camara2

func _ready():
	# Al arrancar el juego, activamos la fija por defecto (opcional)
	camara_1.current = true
	camara_2.current = false

func _process(delta):
	# Si pulsas la tecla 1 -> Activa Camara1
	if Input.is_action_just_pressed("tecla_camara1"):
		camara_1.current = true
		camara_2.current = false
		print("Cambio a Cámara 1 (Fija)")
		
	# Si pulsas la tecla 2 -> Activa Camara2
	if Input.is_action_just_pressed("tecla_camara2"):
		camara_1.current = false
		camara_2.current = true
		print("Cambio a Cámara 2 (Rotatoria)")
