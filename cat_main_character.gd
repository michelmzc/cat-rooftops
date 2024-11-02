extends CharacterBody2D

"""
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
""" 

#Programación de las animaciones
@onready var _animated_sprite = $AnimatedSprite2D 
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("walking right")
	if Input.is_action_just_released("ui_right"):
		_animated_sprite.play("standing right")
	if Input.is_action_pressed("ui_left"):
		_animated_sprite.play("walking left") 
	if Input.is_action_just_released("ui_left"): 
		_animated_sprite.play("standing left") 
