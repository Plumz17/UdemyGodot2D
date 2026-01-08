extends CharacterBody2D
class_name Player

@export var gravity: float = 690
@export var jump_force: float = -270
@export var run_speed: float = 120

@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("left", "right") * run_speed
	velocity.y += gravity * delta
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0
	move_and_slide()
