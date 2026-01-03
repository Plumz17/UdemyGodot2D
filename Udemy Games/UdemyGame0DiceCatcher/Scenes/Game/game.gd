extends Node2D

@onready var dice: Dice = $Dice

const DICE = preload("uid://clisgsqikiq1l")
const GAME_OVER = preload("uid://h67if50lteb4")
const MARGIN: float = 80.0
const STOPPABLE_GROUP: String = "stoppable"


@onready var timer: Timer = $Pausable/Timer
@onready var fox: Fox = $Fox
@onready var score_label: Label = $ScoreLabel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var pausable: Node = $Pausable


var _points = 0

func _ready() -> void:
	get_tree().paused = false
	_update_score_label()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func spawn_dice() -> void:
	var new_dice: Dice = DICE.instantiate()
	var vpr: Rect2 = get_viewport_rect()
	var new_x: float = randf_range(
		vpr.position.x + MARGIN, vpr.end.x - MARGIN
	)
	new_dice.position = Vector2(new_x, -MARGIN)
	new_dice.game_over.connect(_on_dice_game_over)
	pausable.add_child(new_dice)

func pause_all() -> void:
	timer.stop()
	var to_stop: Array[Node] = get_tree().get_nodes_in_group(STOPPABLE_GROUP)
	for item in to_stop:
		item.set_physics_process(false)

func _on_dice_game_over() -> void:
	audio_stream_player.stream = GAME_OVER
	audio_stream_player.play()
	#pause_all()
	get_tree().paused = true


func _on_timer_timeout() -> void:
	spawn_dice()

func _update_score_label() -> void:
	score_label.text = "%04d" % _points

func _on_fox_point_scored() -> void:
	_points += 1
	_update_score_label()
	
