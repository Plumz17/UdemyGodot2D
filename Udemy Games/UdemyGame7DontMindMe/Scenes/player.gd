extends CharacterBody2D
class_name Player

const SPEED: float = 150.0
const GROUP_NAME: String = "player"
# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var movement: Vector2 = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	velocity = movement * SPEED
	if !velocity.is_zero_approx():
		rotation = velocity.angle()
	move_and_slide()
	
