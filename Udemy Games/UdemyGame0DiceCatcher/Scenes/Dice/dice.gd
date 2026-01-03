extends Area2D

class_name Dice

signal game_over
const SPEED: float = 200
const ROTATION_SPEED: float = PI
@onready var sprite_2d: Sprite2D = $Sprite2D
var rotation_direction: float = 1

func _ready() -> void:
	if randf() < 0.5: rotation_direction *= -1

func _physics_process(delta: float) -> void:
	position.y += SPEED * delta
	sprite_2d.rotation += ROTATION_SPEED * delta * rotation_direction
	check_game_over()
	
func check_game_over() -> void:
	if get_viewport_rect().end.y < position.y:
		#set_physics_process(false)
		game_over.emit()
		queue_free()
