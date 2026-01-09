extends EnemyBase

var _seen_player: bool = false
var _can_jump: bool = false

@onready var jump_timer: Timer = $JumpTimer
@export var jump_velocity_l = Vector2(-100, -150)
@export var jump_velocity_r = Vector2(100, -150)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += _gravity * delta
	attempt_jump()
	move_and_slide()
	flip_frog()
	if is_on_floor():
		velocity.x = 0
		animated_sprite_2d.play("idle")

func flip_frog() -> void:
	animated_sprite_2d.flip_h = _player_ref.global_position.x > global_position.x
	
func attempt_jump() -> void:
	if !is_on_floor() or !_can_jump or !_seen_player:
		return
	velocity = jump_velocity_r if animated_sprite_2d.flip_h else jump_velocity_l
	_can_jump = false
	start_timer()
	animated_sprite_2d.play("jump")
	
	
func start_timer() -> void:
	var rand_time: float = randf_range(2, 3)
	jump_timer.start(rand_time)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if !_seen_player:
		_seen_player = true
		start_timer()

func _on_jump_timer_timeout() -> void:
	_can_jump = true
