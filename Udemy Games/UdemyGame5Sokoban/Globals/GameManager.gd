extends Node

const LEVEL = preload("uid://btnyp2mdj6oyp")
const MAIN = preload("uid://cby0c8kk2t6dn")

var current_level: String = "1"

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
	
func load_level_scene(ln: String) -> void:
	current_level = ln
	print(current_level)
	get_tree().change_scene_to_packed(LEVEL)

func get_current_level() -> String:
	return current_level
