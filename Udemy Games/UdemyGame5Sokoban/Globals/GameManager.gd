extends Node

const LEVEL = preload("uid://btnyp2mdj6oyp")
const MAIN = preload("uid://cby0c8kk2t6dn")

var current_level: String = "1"
var high_score_res: HighScoresResource

func _enter_tree() -> void:
	high_score_res = HighScoresResource.load_scores()

func has_level_score(lvl: String) -> bool:
	return high_score_res.has_level_score(lvl)

func level_completed(lvl: String, score:int) -> bool:
	return high_score_res.add_score(lvl, score)

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
	
func load_level_scene(ln: String) -> void:
	current_level = ln
	print(current_level)
	get_tree().change_scene_to_packed(LEVEL)

func get_current_level() -> String:
	return current_level

func get_best_score(lvl: String) -> int:
	return high_score_res.get_best_score(lvl)
