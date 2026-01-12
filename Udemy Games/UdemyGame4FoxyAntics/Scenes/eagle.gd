extends EnemyBase

@export var fly_speed: Vector2 = Vector2(70, 30)
var fly_direction: Vector2 = Vector2.ZERO

@onready var direction_timer: Timer = $DirectionTimer
@onready var player_detector: RayCast2D = $PlayerDetector
@onready var shooter: Shooter = $Shooter


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	animated_sprite_2d.play("fly")
	direction_timer.start()
	fly_to_player()

func fly_to_player() -> void:
	flip_eagle()
	var x_dir: float = 1.0 if animated_sprite_2d.flip_h else -1.0
	fly_direction = Vector2(x_dir, 1) * fly_speed

func flip_eagle() -> void:
	animated_sprite_2d.flip_h = _player_ref.global_position.x > global_position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity = fly_direction
	move_and_slide()
	shoot()

func shoot() -> void:
	if player_detector.is_colliding():
		shooter.shoot_at_player()

func _on_direction_timer_timeout() -> void:
	fly_to_player()
	
