extends Camera2D

@export var running: bool = false
@export var target_node_path: NodePath
@export var camera_offset_x: int = 350 # desplazamos la cámara a la izquierda
@export var camera_offset_y: int = -250 # offset vertical
@export var offset_time = 3.0 # duración en segundos para llegar al offset izquierdo
@export var smoothing_speed: float = 5.0

var target 
var elapsed_time = 0.0

func _ready():
	target = get_node(target_node_path)

func _process(delta):
	if not running or target == null:
		return 
	
	# offset horizontal suavizado
	elapsed_time = min(elapsed_time + delta, offset_time)
	var t = elapsed_time / offset_time
	var offset_x = lerp(0, camera_offset_x, t)
	
	# offset horizontal y vertical
	var desired_position = Vector2(
		target.global_position.x + offset_x,
		target.global_position.y + camera_offset_y
	)

	global_position = global_position.lerp(desired_position, smoothing_speed * delta)
