extends Node2D

@export var platform_scene: PackedScene # prefab de una plataforma
@export var platform_spacing: float = 300.0 # distancia entre plataformas (puede variar)

var last_platform_x = 400 # posición X de la última plataforma generada

func _process(delta):
	if last_platform_x - $Player.positon.x < 500:
		spawn_platform()
	
	for platform in get_children():
		if platform.position.x < $Player.position.x - 300:
			platform.queue_free() #elimina la plataforma que quedó atrás
			
func spawn_platform():
	var new_plaftorm = platform_scene.instantiate()
	new_plaftorm.position = Vector2(last_platform_x + platform_spacing, randf_range(250, 400))
	add_child(new_plaftorm)
	last_platform_x = new_plaftorm.position.x #actualiza la última plataforma generada
