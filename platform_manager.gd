extends Node

@export var platform_scene: PackedScene # prefab de una plataforma
@export var platform_spacing: float = 390.0 # distancia entre plataformas (puede variar)
@export var start_platforms: int = 3 # número de plataformas iniciales

# Variables para generación procedimental de plataformas
@export var spawn_position: Vector2 = Vector2(600,300) #posicion inicial del spawn
@export var spawn_distance: float = 700

@export var min_horizontal_gap: float = 590 # distancia mínima horizontal entre las plataformas
@export var max_horizontal_gap: float = 600 # distancia máxima vertical entre plataformas 

@export var min_vertical_gap: float = 80  # distancia mínima vertical 
@export var max_vertical_gap: float = 100 # distancia máxima vertical    

@export var min_height: float = 0 #64 # altura mínima de las plataformas
@export var max_height: float = 500  #448 # altura máxima de las plataformas

var last_platform_x = -500 # posición X de la última plataforma generada
var last_platform_y = 550
var player = null 

func _ready():
	player =  get_node("../Player") 
	generate_starting_platforms()
	

func _process(delta):
	if player == null:
		return # evitar errores si el jugado aún no está asignado
	
	var player_x = player.position.x 
	# buscar la última plataforma de manera segura
	var last_platform = null 
	if get_child_count() > 0:
		last_platform = get_child(get_child_count() - 1) # última plataforma generada
	
	if last_platform == null or last_platform.position.x < player_x + spawn_distance:
		spawn_platform()		
	
	for platform in get_children():
		if platform.position.x < player.position.x - 600:
			platform.queue_free() #elimina la plataforma que quedó atrás
	
	
func generate_starting_platforms():
	for platform in range(start_platforms):
		spawn_platform(last_platform_x, 550)
		
		
func spawn_platform(position_x=0, position_y=0):
	# si pasamos argumentos activamos generación precisa
	if position_x != 0 and position_y != 0:
		var new_plaftorm = platform_scene.instantiate()
		new_plaftorm.position = Vector2(position_x + platform_spacing , position_y)
		add_child(new_plaftorm)
		last_platform_x = new_plaftorm.position.x  #actualiza la última plataforma generada
		last_platform_y = position_y 
	
	# si no pasamos argumentos activamos generación procedimental
	elif position_x == 0 and position_y == 0:
		var platform = platform_scene.instantiate()
		var new_x = last_platform_x + randi_range(min_horizontal_gap, max_horizontal_gap) #generar distancia aleatoria
		var new_y = 0
		if last_platform_y >= max_height:
			new_y = last_platform_y - randi_range(min_vertical_gap, max_vertical_gap)
		else:
			new_y = last_platform_y + randi_range(min_vertical_gap, max_vertical_gap)
		
		platform.position = Vector2(new_x, new_y) #ubicar la nueva plataforma
		add_child(platform) #agregamos la plataforma a la escena
		
		last_platform_x = new_x
		last_platform_y = new_y
	print(last_platform_x," ",last_platform_y)
		
