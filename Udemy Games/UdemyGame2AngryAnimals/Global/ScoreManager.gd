extends Node

const SCORE_PATH: String = "user://animal.tres"
var _level_scores: LevelScoreResource

var level_selected: String = "1":
	get:
		return level_selected
	set(level):
		level_selected = level

func _ready() -> void:
	load_scores()

func set_score_for_level(level:String, score: int) -> void:
	_level_scores.update_level_score(level, score)
	save_scores()

func get_level_best(level: String) -> int:
	return _level_scores.get_level_best(level)

func load_scores() -> void:
	if ResourceLoader.exists(SCORE_PATH):
		_level_scores = load(SCORE_PATH)
	if !_level_scores:
		_level_scores = LevelScoreResource.new()

func save_scores() -> void:
	ResourceSaver.save(_level_scores, SCORE_PATH)
