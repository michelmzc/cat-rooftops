extends CanvasLayer

# notifica al nodo 'main' que el boton ha sido presionado
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show() 
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# esperar hasta que el MessageTimer haya terminado de contar
	await $MessageTimer.timeout 
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# hacer un timer one-shot y esperar que finalice
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit() 

func _on_message_timer_timeout():
	$Message.hide()
