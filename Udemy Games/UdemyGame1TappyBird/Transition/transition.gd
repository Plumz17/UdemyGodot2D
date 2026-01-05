extends CanvasLayer

class_name Transition
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_anim() -> void:
	animation_player.play("fade")

func switch_scene() -> void:
	GameManager.change_to_next()
