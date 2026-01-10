extends Node2D
class_name Explosion
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()

func _ready() -> void:
	audio_stream_player_2d.play()
