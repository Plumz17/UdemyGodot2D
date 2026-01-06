extends Node
signal on_animal_died
signal on_attempt_made
signal on_cup_destroyed(remaining_cups: int)

func emit_on_animal_died():
	on_animal_died.emit()

func emit_on_attempt_made():
	on_attempt_made.emit()

func emit_on_cup_destroyed(remaining_cups: int):
	on_cup_destroyed.emit(remaining_cups)
