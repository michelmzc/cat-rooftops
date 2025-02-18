extends Node

@export var platform_scene: PackedScene # prefab de una plataforma
@export var platform_spacing: float = 390.0 # distancia entre plataformas (puede variar)
@export var start_platforms: int = 5 # número de plataformas iniciales

# Variables para generación procedimental de plataformas
@export var spawn_position: Vector2 = Vector2(600,300) #posicion inicial del spawn
@export var min_horizontal_gap: float = 100  # distancia mínima horizontal entre las plataformas
@export var max_horinzontal_gap: float = 200 # distancia máxima vertical entre plataformas 
@export var min_vertical_gap: float = 100 # distancia mínima vertical 
@export var max_vertical_gap: float = 240 # distancia máxima vertical    
@export var min_height: float = 600 # altura mínima de las plataformas
@export var max_height: float = 200 # altura máxima de las plataformas

var last_platform_x = -50 # posición X de la última plataforma generada
var last_platform_y = 550
var player = null 

func _ready():
	player =  get_node("../Player") 
	generate_starting_platforms()
	

func _process(delta):
	#if last_platform_x - player.position.x < 500:
	#	spawn_platform()
	
	#si hay menos de 10 plataformas, haremos spawn
	if get_child_count() < 10: 
		spawn_platform()
		
	for platform in get_children():
		if platform.position.x < player.position.x - 600:
			platform.queue_free() #elimina la plataforma que quedó atrás
	
func generate_starting_platforms():
	for platform in range(start_platforms):
		spawn_platform(last_platform_x, 550)
		
		
func spawn_platform(position_x=0, position_y=0):
	#si no pasamos argumentos activamos generación procedimental
	if position_x == 0 and position_y == 0:
		var platform = platform_scene.instantiate()
		var new_x = last_platform_x + randf_range(min_horizontal_gap, max_horinzontal_gap) #generar distancia aleatoria
		var new_y = last_platform_y 
		if last_platform_y >= min_height:
			new_y = last_platform_y - randf_range(min_vertical_gap, max_vertical_gap)
		else:
			new_y = last_platform_y + randf_range(min_vertical_gap, max_vertical_gap)
		
		platform.position = Vector2(new_x, new_y) #ubicar la nueva plataforma
		add_child(platform) #agregamos la plataforma a la escena
		
		last_platform_x = new_x
		last_platform_y = new_y
		
	else:	
		var new_plaftorm = platform_scene.instantiate()
		new_plaftorm.position = Vector2(position_x, position_y) #512 #randf_range(250, 400)
		add_child(new_plaftorm)
		last_platform_x = new_plaftorm.position.x + platform_spacing #actualiza la última plataforma generada
		last_platform_y = position_y 
		
