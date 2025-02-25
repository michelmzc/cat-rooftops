extends Node

@export var mob_scene: PackedScene
var score 

func game_over():
	$ScoreTimer.stop() 
	$MobTimer.stop()
	$HUD.show_game_over() 
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0 	
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start() 

func _on_score_timer_timeout():
	score += 1 
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	# crear una nueva instancia de la escena Mob
	var mob = mob_scene.instantiate() 
	
	# escogemos una ubicación aleatoria en Path2D 
	var mob_spawn_location = $MobPath/MobSpawnLocation 
	mob_spawn_location.progress_ratio = randf() 
	
	# establecer la posición del mob repecto a la ubicación aleatoria 
	mob.position = mob_spawn_location.position
	
	# establecer la dirección del mob perpendicular a la dirección del Path
	var direction = mob_spawn_location.rotation + PI/2
	
	# agregar aleatoriedad a la dirección
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction 
	
	# escoger la velocidad para el mob 
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0) 
	mob.linear_velocity = velocity.rotated(direction) 
	
	# instancias el mob agregandolo a la escena principal
	add_child(mob)	 
	
func _ready():
	pass
	#new_game()
