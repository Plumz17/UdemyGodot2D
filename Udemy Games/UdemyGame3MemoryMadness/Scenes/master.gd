extends Control

@onready var music: AudioStreamPlayer = $Music
@onready var main: Control = $main
@onready var game: Control = $game



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_exit_button_pressed()

func _enter_tree() -> void:
	SignalHub.on_level_selected.connect(on_level_selected)
	SignalHub.on_exit_button_pressed.connect(on_exit_button_pressed)


func show_game(b: bool) -> void:
	game.visible = b
	main.visible = !b
	
func on_level_selected(level_number: int) -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_IN_GAME)
	show_game(true)

func on_exit_button_pressed() -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_MAIN_MENU)
	show_game(false)
