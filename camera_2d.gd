extends Camera2D

@export var runing: bool = false
@export var target_node_path: NodePath
@export var camera_offset_x: int = 300 # desplazamos la cámara a la izquierda
@export var offset_time = 3.0 # duración en segundos para llegar al offset izquierdo

var target 
var elapsed_time = 0.0

func _ready():
	target = get_node(target_node_path)

func _process(delta):
	if target == null:
		return 
	if runing == false:
		return
	elapsed_time += delta
	var t = clamp(elapsed_time / offset_time, 0, 1)
	var offset_x = lerp(0, camera_offset_x, t)
	
	# posicion deseado jugador + offset x 
	var desired_position = Vector2(target.global_position.x + offset_x, global_position.y)

	# suavizar movimiento de cámara 
	global_position = global_position.lerp(desired_position, 0.1)
