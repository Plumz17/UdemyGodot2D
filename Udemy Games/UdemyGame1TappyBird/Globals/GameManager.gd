extends Node

const MAIN = preload("uid://ceywvvn26rr4j")
const GAME = preload("uid://cx5qukjvtt8jk")
const TRANSITION = preload("uid://djqv3dm3iy7dw")

var next_scene: PackedScene
var trans: Transition

func _ready() -> void:
	trans = TRANSITION.instantiate()
	add_child(trans)
	
func start_transition(to_scene: PackedScene) -> void:
	next_scene = to_scene
	trans.play_anim()

func change_to_next() -> void:
	get_tree().change_scene_to_packed(next_scene)

func load_main_scene() -> void:
	start_transition(MAIN)
	
func load_game_scene() -> void:
	start_transition(GAME)
