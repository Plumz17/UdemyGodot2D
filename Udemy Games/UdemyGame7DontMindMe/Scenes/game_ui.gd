extends Control
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var time_label: Label = $MarginContainer/TimeLabel
@onready var exit_label: Label = $MarginContainer/ExitLabel
@onready var go_label: Label = $ColorRect/GOLabel
@onready var color_rect: ColorRect = $ColorRect

var time: float = 0
var total: int
var current_pickup: int = 0

func _enter_tree() -> void:
	SignalHub.on_pickup_collected.connect(on_pickup_collected)
	SignalHub.on_player_died.connect(on_player_died)
	SignalHub.on_exit.connect(on_exit)

func _ready() -> void:
	get_tree().paused = false
	total = get_tree().get_node_count_in_group(Pickup.GROUP_NAME)
	score_label.text = "%d/%d" % [current_pickup, total]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.load_main_scene()

func on_pickup_collected() -> void:
	current_pickup += 1
	score_label.text = "%d/%d" % [current_pickup, total]
	if current_pickup == total:
		SignalHub.emit_on_show_exit()
		exit_label.show()

func _process(delta: float) -> void:
	time += delta
	time_label.text = "%.1f" % time

func on_player_died() -> void:
	go_label.text = "GAME OVER!"
	stop_game()

func on_exit() -> void:
	go_label.text = "YOU WON! you took %.1f seconds" % time
	stop_game()
	
func stop_game() -> void:
	color_rect.show()
	get_tree().paused = true 
	set_process(false)
