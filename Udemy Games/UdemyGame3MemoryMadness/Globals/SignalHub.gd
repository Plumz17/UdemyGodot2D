extends Node

signal on_level_selected(level_number: int)
signal on_exit_button_pressed

func emit_on_level_selected(level_number: int) -> void:
	on_level_selected.emit(level_number)
	
func emit_on_exit_button_pressed() -> void:
	on_exit_button_pressed.emit()
