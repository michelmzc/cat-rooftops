extends CanvasLayer

#notifica al nodo MainScene que el botón ha sido presionado
signal start_game

func show_message(text):
	$UI/MessageLabel.text = text
	$UI/MessageLabel.show()
	$UI/MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# esperar hasta que termine el contador de MessageTimer
	await $UI/MessageLabel.timeout
	
	$UI/MessageLabel.text = "Cat Rooftops"
	$UI/MessageLabel.show()
	# hacer un one-shot timer y esperar a que finalice
	await get_tree().create_timer(1.0).timeout
	$UI/StartButton.show()

func update_score(score):
	$UI/ScoreLabel.text = str(score)

func _on_start_button_pressed() -> void:
	$UI/StartButton.hide()
	$UI/MessageLabel.hide()
	$UI/ScoreLabel.show()
	$UI/ScoreTimer.start()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$UI/MessageLabel.hide()
