extends CharacterBody2D
class_name Player

@export var gravity: float = 690
@export var jump_force: float = -270
@export var run_speed: float = 150 
@export var terminal_velocity: float = 350
@export var fallen_off_y: float = 800
@onready var shooter: Shooter = $Shooter

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var dir: Vector2 = Vector2.LEFT if sprite_2d.flip_h else Vector2.RIGHT
		shooter.shoot(dir)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("left", "right") * run_speed
	velocity.y += gravity * delta
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0
	velocity.y = clamp(velocity.y, jump_force, terminal_velocity)
	move_and_slide()
	update_debug_label()
	fallen_off()


func update_debug_label() -> void:
	var ds: String = ""
	ds += "Floor:%s\n" % is_on_floor()
	ds += "V:%.1f,%.1f\n" % [velocity.x, velocity.y]
	ds += "P:%.1f,%.1f" % [global_position.x, global_position.y]
	label.text = ds

func fallen_off() -> void:
	if global_position.y > fallen_off_y:
		queue_free()
