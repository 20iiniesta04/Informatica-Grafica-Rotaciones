extends Skeleton3D

# --- PROPIEDADES DE CONTROL ---
@export var velocidad_rotacion_deg := 250.0
var rotacion_actual := Vector3.ZERO
var brazo_izquierdo_id: int 
var brazo_derecho_id: int
var rotacion_pierna_izq := Vector3.ZERO
var rotacion_pierna_der := Vector3.ZERO
var pierna_izquierda_id: int
var pierna_derecha_id: int
var rotacion_cabeza := Vector3.ZERO
var cabeza_id: int
var rotacion_ojos := Vector3.ZERO
var ojo_izquierdo_id: int
var ojo_derecho_id: int

# --- Limites ----
const LIMITE_HOMBRO_LATERAL = deg_to_rad(90.0)
const LIMITE_HOMBRO_FRONTAL = deg_to_rad(90.0)
const LIMITE_CABEZA_YAW = deg_to_rad(45.0)
const LIMITE_OJO_YAW = deg_to_rad(45.0)
const LIMITE_PIERNA_X = deg_to_rad(45.0)


# --- NOMBRES DE LOS HUESOS ---
const BONE_NAME_BRAZO_IZQ = "Left shoulder_07"
const BONE_NAME_BRAZO_DER = "Right shoulder_023"
const BONE_NAME_PIERNA_IZQ = "Left leg_039"
const BONE_NAME_PIERNA_DER = "Right leg_042"
const BONE_NAME_CUELLO = "Neck_03"
const BONE_NAME_OJO_IZQ = "Eye_L_06"
const BONE_NAME_OJO_DER = "Eye_R_05"

func _ready():
	# Obtener el ID numérico de los huesos
	brazo_izquierdo_id = find_bone(BONE_NAME_BRAZO_IZQ)
	brazo_derecho_id = find_bone(BONE_NAME_BRAZO_DER)
	pierna_izquierda_id = find_bone(BONE_NAME_PIERNA_IZQ)
	pierna_derecha_id = find_bone(BONE_NAME_PIERNA_DER)
	cabeza_id = find_bone(BONE_NAME_CUELLO)
	ojo_izquierdo_id = find_bone(BONE_NAME_OJO_IZQ)
	ojo_derecho_id = find_bone(BONE_NAME_OJO_DER)
	
	rotacion_pierna_izq.x = deg_to_rad(180.0)
	rotacion_pierna_der.x = deg_to_rad(180.0)
	
	
	if brazo_izquierdo_id == -1 or brazo_derecho_id == -1:
		print("ERROR: No se encontraron los huesos. Verifica los nombres.")
		set_process(false)

func _process(delta):
	var cambio_rotacion = deg_to_rad(velocidad_rotacion_deg * delta)
	
	# Accion brazos
	if Input.is_action_pressed("brazo_arriba"):
		rotacion_actual.z -= cambio_rotacion 
	if Input.is_action_pressed("brazo_abajo"):
		rotacion_actual.z += cambio_rotacion
		
	if Input.is_action_pressed("brazo_adelante"):
		rotacion_actual.y += cambio_rotacion
	if Input.is_action_pressed("brazo_atras"):
		rotacion_actual.y -= cambio_rotacion
		
	rotacion_actual.z = clamp(rotacion_actual.z, -LIMITE_HOMBRO_LATERAL, LIMITE_HOMBRO_LATERAL)
	rotacion_actual.y = clamp(rotacion_actual.y, -LIMITE_HOMBRO_FRONTAL, LIMITE_HOMBRO_FRONTAL)
		
		
	#accion piernas
	if Input.is_action_pressed("mov_piernas1"):
		rotacion_pierna_izq.x += cambio_rotacion
		rotacion_pierna_der.x -= cambio_rotacion

	if Input.is_action_pressed("mov_piernas2"):
		rotacion_pierna_izq.x -= cambio_rotacion
		rotacion_pierna_der.x += cambio_rotacion
		
	#rotacion_pierna_izq.x = clamp(rotacion_pierna_izq.x, -LIMITE_PIERNA_X, LIMITE_PIERNA_X)
	#rotacion_pierna_der.x = clamp(rotacion_pierna_der.x, -LIMITE_PIERNA_X, LIMITE_PIERNA_X)
		
	# Accion cabeza
	if Input.is_action_pressed("cabeza_izquierda"):
		rotacion_cabeza.y -= cambio_rotacion
		
	if Input.is_action_pressed("cabeza_derecha"):
		rotacion_cabeza.y += cambio_rotacion
		
	rotacion_cabeza.y = clamp(rotacion_cabeza.y, -LIMITE_CABEZA_YAW, LIMITE_CABEZA_YAW)
		
	 # Accion ojos
	if Input.is_action_pressed("ojos_arriba"):
		rotacion_ojos.x -= cambio_rotacion
	if Input.is_action_pressed("ojos_abajo"):
		rotacion_ojos.x += cambio_rotacion
	if Input.is_action_pressed("ojos_izquierda"):
		rotacion_ojos.y -= cambio_rotacion
	if Input.is_action_pressed("ojos_derecha"):
		rotacion_ojos.y += cambio_rotacion

	rotacion_ojos.x = clamp(rotacion_ojos.x, -LIMITE_OJO_YAW, LIMITE_OJO_YAW)
	rotacion_ojos.y = clamp(rotacion_ojos.y, -LIMITE_OJO_YAW, LIMITE_OJO_YAW)
	
	# 3. CONVERSIÓN Y APLICACIÓN DIRECTA AL HUESO
	
	# Brazo Izquierdo
	var rot_quat_izq = Quaternion.from_euler(rotacion_actual)
	set_bone_pose_rotation(brazo_izquierdo_id, rot_quat_izq) # <-- TABULACIÓN CORREGIDA
	
	# Brazo Derecho (Simetría: Invertimos Y y Z)
	var rot_simetrica = Vector3(rotacion_actual.x, -rotacion_actual.y, -rotacion_actual.z)
	var rot_quat_der = Quaternion.from_euler(rot_simetrica)
	set_bone_pose_rotation(brazo_derecho_id, rot_quat_der)
	
	#Piernas
	var rot_quat_izq_pierna = Quaternion.from_euler(rotacion_pierna_izq)
	set_bone_pose_rotation(pierna_izquierda_id, rot_quat_izq_pierna)
	
	var rot_quat_der_pierna = Quaternion.from_euler(rotacion_pierna_der)
	set_bone_pose_rotation(pierna_derecha_id, rot_quat_der_pierna)
	
	# Cabeza
	if cabeza_id != -1:
		var rot_quat_cabeza = Quaternion.from_euler(rotacion_cabeza)
		set_bone_pose_rotation(cabeza_id, rot_quat_cabeza)
		
	# Ojos
	var rot_quat_ojos = Quaternion.from_euler(rotacion_ojos)
	set_bone_pose_rotation(ojo_izquierdo_id, rot_quat_ojos)
	set_bone_pose_rotation(ojo_derecho_id, rot_quat_ojos)
	
	# Forzar la actualización
	force_update_all_bone_transforms()
