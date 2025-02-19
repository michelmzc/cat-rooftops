extends CharacterBody2D

@export var speed: float = 500 #velocidad horizontal a la que se mueve el Character, pixeles/segundos
@export var jump_force: float = -600  # fuerza del salto vertical
@export var gravity: float = 1800 # la gravedad

@onready var _animated_sprite = $AnimatedSprite2D # inclución de las animaciones

var is_jumping = false

"""
Godot llamará a la función _process en cada cuadro y le pasará un argumento llamado delta, 
 este es el tiempo transcurrido desde el último frame. Se utiliza para que la velocidad sea
 independiente de los fotogramas
	
Observe cómo _process(), al igual que _init(), comienzan con un guión bajo al principio. 
Por convención, las funciones virtuales de Godot, es decir, las funciones integradas 
que puede anular para comunicarse con el motor, comienzan con un guión bajo.
"""

func _physics_process(delta):
	
	# aplicar gravedad 	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# movimiento automático a la derecha
	velocity.x = speed
	
	# salto con tecla o toque móvil
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
		is_jumping = true
		_animated_sprite.play("jump")
	
	move_and_slide() # aplicar movimiento on colisiones	
		
	if is_on_floor() and is_jumping:
		_animated_sprite.play("run")
		is_jumping = false
		
	

"""
# Señales
# función integrada de un nodo. El motor llama automáticamente cuando un nodo está completamente instanciado.
func _ready():
	# la función get_node() comprueba los hijos del nodo y los obtiene por su nombre.
	# referencia al Timer. Referencia al nodo relativo al actual
	var timer = get_node("Timer")
	# en señal timeout ejecutamos funcion _on_timer_timeout
	# Por convención, en GDScript nombramos esos métodos callback como "_on_nombre_nodo_nombre_señal"
	timer.timeout.connect(_on_timer_timeout)
	
# cuando se ejecute la función, cambiara su visibilidad
func _on_timer_timeout():
	visible = not visible



""" 
