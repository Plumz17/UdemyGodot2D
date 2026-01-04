extends Control
class_name GameUI
@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel
@onready var score_label: Label = $MarginContainer/ScoreLabel

@onready var timer: Timer = $MarginContainer/Timer
@onready var sound: AudioStreamPlayer2D = $Sound

var _points: int = 0

func _ready() -> void:
	SignalHub.on_plane_died.connect(on_plane_died)
	SignalHub.on_point_scored.connect(on_plane_scored)
	update_score_label()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene()
	if event.is_action_pressed("power") and press_space_label.visible:
		GameManager.load_main_scene() 

func on_plane_died() -> void:
	game_over_label.show()
	timer.start() 
	sound.play()
	ScoreManager.high_score = _points

func on_plane_scored() -> void:
	_points += 1
	update_score_label()
	
func update_score_label() -> void:
	score_label.text = "%03d" % _points

func _on_timer_timeout() -> void:
	print("Timer Start!")
	game_over_label.hide()
	press_space_label.show()
	
