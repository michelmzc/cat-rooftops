extends Node

@export var platform_scene: PackedScene # prefab de una plataforma
@export var platform_spacing: float = 295.0 # distancia entre plataformas (puede variar)
@export var start_platforms: int = 5 # número de plataformas iniciales

var last_platform_x = 100 # posición X de la última plataforma generada

var player = null 


func _ready():
	player =  get_node("../Player") 
	generate_starting_platforms()

func _process(delta):
	if last_platform_x - player.position.x < 500:
		spawn_platform()
	
	for platform in get_children():
		if platform.position.x < player.position.x - 500:
			platform.queue_free() #elimina la plataforma que quedó atrás
	
func generate_starting_platforms():
	for i in range(start_platforms):
		spawn_platform() 
		
func spawn_platform():
	var new_plaftorm = platform_scene.instantiate()
	new_plaftorm.position = Vector2(last_platform_x + platform_spacing, 512) #randf_range(250, 400)
	add_child(new_plaftorm)
	last_platform_x = new_plaftorm.position.x #actualiza la última plataforma generada
	
