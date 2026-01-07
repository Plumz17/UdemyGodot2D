extends Node

signal on_level_selected(level_number: int)
signal on_exit_button_pressed
signal on_tile_selected(memory_tile: MemoryTile)
signal on_game_over(moves_taken: int)

func emit_on_level_selected(level_number: int) -> void:
	on_level_selected.emit(level_number)
	
func emit_on_exit_button_pressed() -> void:
	on_exit_button_pressed.emit()

func emit_on_tile_selected(memory_tile: MemoryTile) -> void:
	on_tile_selected.emit(memory_tile)

func emit_on_game_over(moves_taken: int) -> void:
	on_game_over.emit(moves_taken)
