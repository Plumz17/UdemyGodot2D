extends Control
class_name GameUI

@onready var level_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/LevelLabel
@onready var moves_label: Label = $MarginContainer/VBoxContainer/HBoxContainer2/MovesLabel
@onready var best_label: Label = $MarginContainer/VBoxContainer/HBoxContainer3/BestLabel
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var new_best_label: Label = $NinePatchRect/MarginContainer/VBoxContainer/VBoxContainer/NewBestLabel
@onready var moves_taken_label: Label = $NinePatchRect/MarginContainer/VBoxContainer/VBoxContainer/MovesTakenLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lvl: String =GameManager.get_current_level()
	level_label.text = lvl
	if GameManager.has_level_score(lvl):
		best_label.text = str(GameManager.get_best_score(lvl))
	else:
		best_label.text = "-"

func set_moves_label(moves: int) -> void:
	moves_label.text = str(moves)

func show_game_over(moves: int, is_new_best: bool) -> void:
	nine_patch_rect.visible = true
	moves_taken_label.text = "You took %d moves!" % moves
	if is_new_best:
		new_best_label.visible = true
		
