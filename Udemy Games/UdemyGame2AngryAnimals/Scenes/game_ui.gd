extends Control

var _attempts: int = -1
@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel
@onready var attempt_label: Label = $MarginContainer/VBoxContainer/AttemptLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var v_box_container_2: VBoxContainer = $MarginContainer/VBoxContainer2


func _ready() -> void:
	SignalHub.on_attempt_made.connect(update_attempt_ui)
	SignalHub.on_cup_destroyed.connect(show_game_over_ui)
	level_label.text = "Level %s" % ScoreManager.level_selected
	update_attempt_ui()

func update_attempt_ui() -> void:
	_attempts += 1
	attempt_label.text = "Attempt %d" % _attempts
	
func show_game_over_ui(remaining_cups: int) -> void:
	if remaining_cups == 0:
		audio_stream_player_2d.play()
		v_box_container_2.show()
		ScoreManager.set_score_for_level(ScoreManager.level_selected, _attempts)
	
