extends Node

const MAIN = preload("uid://ceywvvn26rr4j")
const GAME = preload("uid://cx5qukjvtt8jk")

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
	
func load_game_scene() -> void:
	get_tree().change_scene_to_packed(GAME)
