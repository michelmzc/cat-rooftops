extends CharacterBody2D

@export var running: bool = false
@export var max_speed: int = 500 #velocidad horizontal a la que se mueve el Character, pixeles/segundos

@export var jump_force: float = -600  # fuerza del salto vertical
@export var gravity: float = 1800 # la gravedad

@onready var _animated_sprite = $AnimatedSprite2D # inclución de las animaciones

var acceleration_time = 3.0 # segundos de aceleración inical
var current_speed = 0
var elapsed_time = 0.0
var anim_min_speed_scale = 0.5 
var anim_max_speed_scale = 1.0

var is_jumping = false

"""
Godot llamará a la función _process en cada cuadro y le pasará un argumento llamado delta, 
 este es el tiempo transcurrido desde el último frame. Se utiliza para que la velocidad sea
 independiente de los fotogramas
	
Observe cómo _process(), al igual que _init(), comienzan con un guión bajo al principio. 
Por convención, las funciones virtuales de Godot, es decir, las funciones integradas 
que puede anular para comunicarse con el motor, comienzan con un guión bajo.
"""
func start_game():
	running = true
	_animated_sprite.play("run")
	  
func _physics_process(delta):
	if running:
		# aceleración progresiva
		if elapsed_time < acceleration_time:
			elapsed_time += delta
			# incrementa velocidad linealmente según tiempo transcurrido
			current_speed = lerp(100, max_speed, elapsed_time / acceleration_time)
		else: 
			current_speed = max_speed
			
		# aplicar gravedad 	
		if not is_on_floor():
			velocity.y += gravity * delta
		
		# movimiento horizontal automático a la derecha
		velocity.x = current_speed
		
		# salto con tecla o toque móvil
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = jump_force
			is_jumping = true
			_animated_sprite.play("jump")
		
		move_and_slide() # aplicar movimiento on colisiones	
		
		# volver a correr tras el salto
		if is_on_floor() and is_jumping:
			_animated_sprite.play("run")
			is_jumping = false
	else:
		# animación idle/pausa
		_animated_sprite.speed_scale = 1

func _process(delta):
	if running:
		# animación suavizada con el framerate de la pantalla
		var t = min(elapsed_time / acceleration_time, 1.0)
		_animated_sprite.speed_scale = lerp(anim_min_speed_scale, anim_max_speed_scale, t)


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
