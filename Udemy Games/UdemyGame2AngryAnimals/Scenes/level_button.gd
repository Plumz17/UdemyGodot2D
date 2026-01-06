extends TextureButton

@export var level_number: String = "1"
@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel

func _ready() -> void:
	level_label.text = level_number
	score_label.text = str(ScoreManager.get_level_best(level_number))

func _on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)

func _on_mouse_exited() -> void:
	scale = Vector2(1.0, 1.0)


func _on_pressed() -> void:
	var file_name: String = "res://Scenes/level_%s.tscn" % level_number
	if FileAccess.file_exists(file_name):
		ScoreManager.level_selected = level_number
		get_tree().change_scene_to_file(file_name)
	else:
		print("File doesn't exists")
