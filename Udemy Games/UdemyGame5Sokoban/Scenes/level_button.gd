extends NinePatchRect
class_name LevelButton
@onready var label: Label = $Label
var _level_number: String
@onready var check_mark: TextureRect = $CheckMark

func _ready() -> void:
	label.text = _level_number
	check_mark.visible = GameManager.has_level_score(_level_number)

func setup(lvl: int) -> void:
	_level_number = str(lvl)

	


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		GameManager.load_level_scene(_level_number)
