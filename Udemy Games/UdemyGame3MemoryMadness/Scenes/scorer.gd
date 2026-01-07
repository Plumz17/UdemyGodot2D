extends Node
class_name Scorer

static var SelectionEnabled: bool = true
var _selections: Array[MemoryTile]
@onready var sound: AudioStreamPlayer = $Sound
@onready var reveal_timer: Timer = $RevealTimer
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _enter_tree() -> void:
	SignalHub.on_tile_selected.connect(on_tile_selected)
	SignalHub.on_exit_button_pressed.connect(on_exit_button_pressed)

func get_moves_made_str() -> String:
	return str(_moves_made)
	
func get_pairs_made_str() -> String:
	return "%d/%d" % [_pairs_made, _target_pairs]


func check_game_over() -> void:
	if _pairs_made == _target_pairs:
		SelectionEnabled = false 
		SignalHub.emit_on_game_over(_moves_made)
	else:
		SelectionEnabled = true

func clear_new_game(target_pairs: int) -> void:
	SelectionEnabled = true
	_selections.clear()
	_target_pairs = target_pairs
	_moves_made = 0
	_pairs_made = 0

func on_tile_selected(memory_tile: MemoryTile) -> void:
	if memory_tile not in _selections:
		_selections.append(memory_tile)
		SoundManager.play_tile_click(sound)
		process_pair()
		
func on_exit_button_pressed() -> void:
	reveal_timer.stop()

func check_for_pair() -> void:
	_moves_made += 1
	if _selections[0].matches_other_tile(_selections[1]):
		_selections[0].kill_on_success()
		_selections[1]. kill_on_success()
		_pairs_made += 1
		SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)

func process_pair() -> void:
	if _selections.size() != 2:
		return
	SelectionEnabled = false
	reveal_timer.start()
	check_for_pair()
		

func _on_reveal_timer_timeout() -> void:
	for s in _selections:
		s.reveal(false)
	_selections.clear()
	check_game_over()
	
