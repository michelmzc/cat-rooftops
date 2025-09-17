extends Node

@onready var player = $GameWorld/Player 
@onready var hud = $HUD
@onready var platform_manager = $PlatformManager
@onready var camera = $Camera2D

# en un comienzo el juego esta pausado, con esta variable comienza el juego
var game_running = false

func _on_hud_start_game() -> void:
	game_running = true
	player.start_game()
	camera.running = true

func _ready() -> void:
	hud.end_game.connect(_on_end_game)
	
func _on_end_game():
	get_tree().paused = true
