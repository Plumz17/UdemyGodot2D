extends Area2D
class_name Bullet

const SPEED: float = 250
var dir: Vector2 = Vector2.ZERO
const BOOM = preload("uid://d1gi6mr3jft2f")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p: Player = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !p:
		queue_free()
	else:
		dir = global_position.direction_to(p.global_position) * SPEED
		look_at(p.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += dir * delta


func _on_screen_notifier_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	make_boom()
	if body is Player:
		SignalHub.emit_on_player_died()
	queue_free()

func make_boom() -> void:
	var b = BOOM.instantiate()
	b.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", b)
