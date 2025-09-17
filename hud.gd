extends CanvasLayer

#notifica al nodo MainScene que el botón ha sido presionado
signal start_game
signal end_game

@onready var start_button: Button = $UI/StartButton
@onready var score_timer: Timer  = $UI/ScoreTimer
@onready var score_label: Label = $UI/ScoreLabel
@onready var message_timer: Timer = $UI/MessageTimer
@onready var message_label: Label = $UI/MessageLabel

var elapsed_time: int = 0

func show_message(text):
	message_label.text = text
	message_label.show()
	message_timer.start()
	
func show_game_over() -> void:
	show_message("Game Over")
	# esperar hasta que termine el contador de MessageTimer
	await message_timer.timeout
	
	message_label.text = "Cat Rooftops"
	message_label.show()
	# hacer un one-shot timer y esperar a que finalice
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_score(score) -> void:
	score_label.text = str(score)

func _on_start_button_pressed() -> void:
	start_button.hide()
	message_label.hide()
	score_label.show()
	score_timer.start()
	elapsed_time = 0
	start_game.emit()

func _on_message_timer_timeout() -> void:
	message_label.hide()

	
func _on_score_timer_timeout() -> void:
	elapsed_time += 1
	score_label.text = str(elapsed_time)
	
	if elapsed_time >= 30:
		score_timer.stop()
		_show_tutorial_complete()
		
func _show_tutorial_complete() -> void:
	score_label.hide()
	message_label.text = "Tutorial Completed!"
	message_label.show()
	# detener el juego
	end_game.emit()
