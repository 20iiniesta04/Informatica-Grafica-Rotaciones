extends StaticBody3D

@onready var luz = $OmniLight3D

func _ready():
	# (Opcional) Que empiece apagada para dar la sorpresa
	if luz:
		luz.visible = false

# Esta función la llama tu cámara cuando haces clic
func interactuar():
	if luz:
		luz.visible = !luz.visible # Invierte el estado (On/Off)
		print("Has tocado a Pim. Luz: ", luz.visible)
