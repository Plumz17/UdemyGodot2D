extends Control
@onready var moves_label: Label = $NinePatchRect/VBoxContainer/MovesLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_exit_button_pressed.connect(on_exit_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_game_over(moves_taken: int) -> void:
	moves_label.text = "You took %d moves" % moves_taken
	show()

func on_exit_button_pressed() -> void:
	hide()
