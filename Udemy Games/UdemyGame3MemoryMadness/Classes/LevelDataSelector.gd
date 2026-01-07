extends Object
class_name LevelDataSelector

const LEVELS_DATA: LevelDataResource = preload("uid://byenv0nnlojag")

#region statics
static func get_level_setting(index: int) -> LevelSettingResource:
	return LEVELS_DATA.get_level_data(index)

static func get_level_selection(level_num: int) -> LevelDataSelector:
	var ls: LevelSettingResource = get_level_setting(level_num)
	if ls == null:
		return 
	ImageManager.shuffle_image()
	var selected_images: Array[Texture2D]
	for i in range(ls.get_target_pairs()):
		selected_images.append(ImageManager.get_image(i))
		selected_images.append(ImageManager.get_image(i))
	selected_images.shuffle()
	return LevelDataSelector.new(ls, selected_images)
#endregion

var _selected_images: Array[Texture2D]
var _level_setting: LevelSettingResource

func _init(level_setting: LevelSettingResource, selected_images: Array[Texture2D]) -> void:
	_level_setting = level_setting
	_selected_images = selected_images
	
func get_selected_images() -> Array[Texture2D]:
	return _selected_images
	
func get_target_pairs() -> int:
	return _level_setting.get_target_pairs()

func get_num_cols() -> int:
	return _level_setting.get_cols()
