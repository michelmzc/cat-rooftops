extends Area2D

signal hit # señal para cuando sea colisionado por un enemigo

"""
Usar la palabra reservada 'export' en la variable 'speed' nos permite establecer su valor en el inspector.
Si se cambia el valor en el script sobrescribira el valor del inspector.
"""
@export var speed = 400 # que tan rapido el jugador se movera en pixeles/segundos
var screen_size # tamaño de la ventana del juego 


"""
La función _ready() se llama cuando un nodo entra en la ecena. Buen momento para averigual el tamaño de 
la ventana del juego.
"""
func _ready():
	screen_size = get_viewport_rect().size
	hide() #ocultar al comienzo del juego 
	
func _process(delta):
	var velocity = Vector2.ZERO # el vector de movimiento del jugador 
	if Input.is_action_just_pressed("move_right"):
		velocity.x += 1 
	if Input.is_action_just_pressed("move_left"):
		velocity.x -= 1 
	if Input.is_action_just_pressed("move_down"): 
		velocity.y += 1 
	if Input.is_action_just_pressed("move_up"):
		velocity.y -= 1 
	"""
	 $ es la abreviatura de get_node(). Así que, en el código anterior, $AnimatedSprite2D.play() es lo mismo que
	 get_node("AnimatedSprite2D").play(). En GDScript, $ retorna el nodo en la ruta relativa del nodo actual, 
	 o retorna null si el nodo no se encuentra. Como AnimatedSprite2D es hijo del nodo actual, podemos utilizar 
	 $AnimatedSprite2D.
	"""
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed 
		$AnimatedSprite2D.play()
	else: 
		$AnimatedSprite2D.stop()
	"""
	 Podemos usar clamp() para prevenir que abandone la pantalla. Aplicar clamp quiere decir que vamos a 
	 restringir un valor a un determinado rango.
	
	El parámetro delta en la función _process() se refiere al frame length -la cantidad de tiempo que le 
	tomo al frame anterior para completarse. Usando este valor aseguras que tu movimiento sera consistente 
	incluso si el frame rate cambia .
	"""	
	position += velocity * delta 
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0: 
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false 
		$AnimatedSprite2D.flip_h = velocity.x < 0 
	elif velocity.y  != 0:
		$AnimatedSprite2D.animation = "up" 
		$AnimatedSprite2D.flip_v = velocity.y > 0 

func _on_body_entered(body):
	hide() # el jugador desaparece despues de ser colisionado
	hit.emit() 
	# necesitamos deshabilitar la colisión del jugador para que activemos solo una vez la señal hit
	# el uso de set_deferred() nos permite hacer que Godot desactivar de forma segura
	$CollisionShape2D.set_deferred("disabled", true)

# función que llamamos para reiniciar cuando comenzamos un juego
func start(pos):
	position = pos 
	show()
	$CollisionShape2D.disabled = false 
