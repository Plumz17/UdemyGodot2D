
extends Node

const MAIN = preload("uid://lpy424ie2nbl")
const LEVEL_BASE = preload("uid://davqgorvo0ait")
const LEVELS: Array[PackedScene] = [preload("uid://dhjhfi1a242nh"), preload("uid://bhtisn3oe0o5q")]

const SCORES_PATH = "user://high_scores.tres"


var high_scores: HighScores = HighScores.new()
var current_level: int = -1

# score to carry over between levels
var cached_score: int:
	set (value):
		cached_score = value
	get:
		return cached_score


func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()


func _ready() -> void:
	load_high_scores()


func _exit_tree():
	save_high_scores()


func load_main():
	current_level = -1
	cached_score = 0
	get_tree().change_scene_to_packed(MAIN)


func load_next_level():
	current_level += 1
	if current_level >= LEVELS.size(): current_level = 0
	get_tree().change_scene_to_packed(LEVELS[current_level])


func load_high_scores():		
	if ResourceLoader.exists(SCORES_PATH):
		high_scores = load(SCORES_PATH)


func save_high_scores():
	ResourceSaver.save(high_scores, SCORES_PATH)


# try this each time game is over / level complete
func try_add_new_score(score: int):
	high_scores.add_new_score(score)
	save_high_scores()	
	cached_score = score
