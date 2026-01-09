extends Node2D
class_name Shooter
@onready var shoot_timer: Timer = $ShootTimer
@onready var sound: AudioStreamPlayer2D = $Sound

@export var speed: float = 50.0
@export var bullet_key: Constants.ObjectType = Constants.ObjectType.BULLET_PLAYER
@export var shoot_delay: float = 0.7
var _can_shoot: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func shoot(direction: Vector2) -> void:
	if !_can_shoot:
		return
	print("SHOOT: ", direction)
	_can_shoot = false
	shoot_timer.start()


func _on_shoot_timer_timeout() -> void:
	_can_shoot = true
