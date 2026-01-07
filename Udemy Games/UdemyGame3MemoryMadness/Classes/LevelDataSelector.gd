extends Object
class_name LevelDataSelector

const LEVELS_DATA: LevelDataResource = preload("uid://byenv0nnlojag")

static func get_level_setting(index: int) -> LevelSettingResource:
	return LEVELS_DATA.get_level_data(index)
