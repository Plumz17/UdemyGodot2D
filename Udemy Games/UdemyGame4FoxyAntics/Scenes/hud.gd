extends Control

const GAME_OVER = preload("uid://drx8tuxv3ngcy")
const YOU_WIN = preload("uid://desvdww38m61u")


@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hb_hearts: HBoxContainer = $MarginContainer/HBHearts
var _score: int = 0
var _hearts: Array
var _can_continue: bool = false
@onready var color_rect: ColorRect = $ColorRect
@onready var vb_game_over: VBoxContainer = $ColorRect/VBGameOver
@onready var vb_level_complete: VBoxContainer = $ColorRect/VBLevelComplete
@onready var complete_timer: Timer = $CompleteTimer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		GameManager.load_main()
	if _can_continue and event.is_action_pressed("jump"):
		if vb_game_over.visible:
			GameManager.load_main()
		else:
			GameManager.load_next_level()

func _ready() -> void:
	_hearts = hb_hearts.get_children()
	_score = GameManager.cached_score
	_on_scored(0)

func _enter_tree() -> void:
	SignalHub.on_scored.connect(_on_scored)
	SignalHub.on_player_hit.connect(_on_player_hit)
	SignalHub.on_level_complete.connect(on_level_complete)

func _exit_tree() -> void:
	GameManager.try_add_new_score(_score)

func _on_scored(points: int) -> void:
	_score += points
	score_label.text = "%05d" % _score   

func _on_player_hit(lives: int, shake: bool) -> void:
	for index in range(_hearts.size()):
		_hearts[index].visible = lives > index
	if lives <= 0:
		on_level_complete(false)

func on_level_complete(complete: bool) -> void:
	color_rect.show()
	if complete:
		vb_level_complete.show()
		audio_stream_player.stream = YOU_WIN
		audio_stream_player.play()
	else:
		vb_game_over.show()
		audio_stream_player.stream = GAME_OVER
		audio_stream_player.play()
	get_tree().paused = true
	complete_timer.start()

func _on_complete_timer_timeout() -> void:
	_can_continue = true
