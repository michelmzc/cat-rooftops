extends Node

@export var platform_scene: PackedScene # prefab de una plataforma
@export var platform_spacing: float = 390.0 # distancia entre plataformas (puede variar)
@export var start_platforms: int = 5 # número de plataformas iniciales

var last_platform_x = -128 # posición X de la última plataforma generada

var player = null 

func _ready():
	player =  get_node("../Player") 
	generate_starting_platforms()

func _process(delta):
	#if last_platform_x - player.position.x < 500:
	#	spawn_platform()
	
	for platform in get_children():
		if platform.position.x < player.position.x - 600:
			platform.queue_free() #elimina la plataforma que quedó atrás
	
func generate_starting_platforms():
	for platform in range(start_platforms):
		spawn_platform(last_platform_x, 550)
		
		
func spawn_platform(position_x, position_y):
	var new_plaftorm = platform_scene.instantiate()
	new_plaftorm.position = Vector2(position_x, position_y) #512 #randf_range(250, 400)
	add_child(new_plaftorm)
	last_platform_x = new_plaftorm.position.x + platform_spacing #actualiza la última plataforma generada
	
