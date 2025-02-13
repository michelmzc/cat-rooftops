extends Node

@onready var player = $GameWorld/Player 

@onready var camera = $Camera2D

func _process(delta):
	# hacer que la cámara siga al jugador solo en el eje X
	camera.position.x = player.position.x
