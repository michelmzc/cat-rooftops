extends CharacterBody2D

func _init():
	print("Hello Godot World")

#Programación de las animaciones
@onready var _animated_sprite = $AnimatedSprite2D 

#velocidad a la que se mueve el Character
#velocidad de movimiento expresado en pixels por segundo
var speed = 200

"""
Godot llamará a la función _process en cada cuadro y le pasará un argumento llamado delta, 
 este es el tiempo transcurrido desde el último frame. Se utiliza para que la velocidad sea
 independiente de los fotogramas

Observe cómo _process(), al igual que _init(), comienzan con un guión bajo al principio. 
Por convención, las funciones virtuales de Godot, es decir, las funciones integradas 
que puede anular para comunicarse con el motor, comienzan con un guión bajo.
"""
func _process(delta):
	
	var velocity  = Vector2.ZERO 
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("walking right") 
		velocity = Vector2.RIGHT * speed
		 
	if Input.is_action_just_released("ui_right"):
		_animated_sprite.play("standing right")
	
	if Input.is_action_pressed("ui_left"):
		_animated_sprite.play("walking left")
		velocity = Vector2.LEFT * speed 
	
	if Input.is_action_just_released("ui_left"): 
		_animated_sprite.play("standing left") 
	
	position += velocity * delta
	
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
