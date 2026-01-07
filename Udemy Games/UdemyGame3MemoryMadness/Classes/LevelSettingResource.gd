extends Resource

class_name LevelSettingResource

@export var level_number: int
@export var rows: int
@export var cols: int

func get_rows():
	return rows
	
func get_cols():
	return cols

func get_level_number():
	return level_number
	
func get_target_pairs():
	return (rows * cols) / 2
