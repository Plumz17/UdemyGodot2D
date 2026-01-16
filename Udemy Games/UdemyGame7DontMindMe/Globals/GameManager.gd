extends Node
const LEVEL = preload("uid://wv8007jjj2ws")
const MAIN = preload("uid://buktaetvfdpkf")

func load_level_scene() -> void:
	get_tree().change_scene_to_packed(LEVEL)
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
