extends Node

@onready var player = $GameWorld/Player 
@onready var platforms = $GameWorld/Platforms
@onready var camera = $Camera2D

# en un comienzo el juego esta pausado, con esta variable comienza el juego
var game_running = false

func _on_hud_start_game() -> void:
	game_running = true
	player.start_game()
	camera.runing = true
