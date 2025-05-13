extends Node

@onready var player = $GameWorld/Player 
@onready var camera = $Camera2D

@export var camera_offset_x: float = 300.0 # desplazamos la cámara a la izquierda

  
func _process(delta):
	# hacer que la cámara siga al jugador solo en el eje X
	camera.position.x = player.position.x + camera_offset_x


func _on_hud_start_game() -> void:
	pass # Replace with function body.
