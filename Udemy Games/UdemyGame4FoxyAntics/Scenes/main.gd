extends Control
const LEVEL_BASE = preload("uid://davqgorvo0ait")
@onready var grid_container: GridContainer = $MarginContainer/GridContainer
const HIGHSCORE_DISPLAY = preload("uid://poxnd5w80iwh")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		GameManager.load_next_level()

func set_scores() -> void:
	for score: HighScore in GameManager.high_scores.get_scores_list():
		var new_hd: HighScoreDisplayItem = HIGHSCORE_DISPLAY.instantiate()
		new_hd.setup(score)
		grid_container.add_child(new_hd)

func _ready() -> void:
	get_tree().paused = false
	set_scores()
	
