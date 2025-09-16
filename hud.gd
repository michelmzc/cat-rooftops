extends CanvasLayer

#notifica al nodo MainScene que el botón ha sido presionado
signal start_game

@onready var start_button: Button = $UI/StartButton
@onready var score_timer: Timer  = $UI/ScoreTimer
@onready var score_label: Label = $UI/ScoreLabel
@onready var message_timer: Timer = $UI/MessageTimer
@onready var message_label: Label = $UI/MessageLabel


func show_message(text):
	message_label.text = text
	message_label.show()
	message_timer.start()
	
func show_game_over():
	show_message("Game Over")
	# esperar hasta que termine el contador de MessageTimer
	await message_timer.timeout
	
	message_label.text = "Cat Rooftops"
	message_label.show()
	# hacer un one-shot timer y esperar a que finalice
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_score(score):
	score_label.text = str(score)

func _on_start_button_pressed() -> void:
	start_button.hide()
	message_label.hide()
	score_label.show()
	score_timer.start()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	message_label.hide()
