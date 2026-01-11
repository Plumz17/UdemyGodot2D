extends Node2D

@export var lives: int = 3
@export var points: int = 5

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hitbox: Area2D = $Visuals/Hitbox
@onready var shooter: Shooter = $Visuals/Shooter
@onready var sprite_2d: Sprite2D = $Visuals/Sprite2D
@onready var state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var visuals: Node2D = $Visuals

var _player_ref: Player
var _invincible: bool = false

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if _player_ref == null:
		queue_free()


func shoot() -> void:
	var dir: Vector2 = shooter.global_position.direction_to(_player_ref.global_position)
	shooter.shoot(dir)

func activate_collisions() -> void:
	hitbox.set_deferred("monitorable", true)
	hitbox.set_deferred("monitoring", true)
	
func take_damage() -> void:
	if _invincible == true:
		return
	_invincible = true
	state_machine.travel("hit")
	tween_hit()
	reduce_lives()

func reduce_lives() -> void:
	lives -= 1
	if lives <= 0:
		SignalHub.emit_signal("on_scored", points)
		queue_free()

func set_invincible(b : bool) -> void:
	_invincible = b

func tween_hit() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(visuals, "position", Vector2.ZERO, 1.8)

func _on_trigger_area_entered(area: Area2D) -> void:
	animation_tree["parameters/conditions/on_trigger"] = true


func _on_hitbox_area_entered(area: Area2D) -> void:
	take_damage()
