extends RigidBody2D


func _ready():
	# obtenemos la lista de nombres de animación
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# tomamos un número al azar entre 0 y 2. Es el total -1.
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()]) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
