extends EnemyBase

@export var shoots_at_player: bool = false
@export var aims_at_player: bool = false

@export var bullet_type: BulletBase.BulletType = BulletBase.BulletType.Enemy
@export var bullet_speed: float = 120.0
@export var bullet_direction: Vector2 = Vector2.DOWN
@export var bullet_wait_time: float = 3.0
@export var bullet_wait_time_var: float = 0.5
@export var power_up_chance: float = 0.9

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound


var _player_ref: Player


func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !_player_ref:
		queue_free()
	SpaceUtils.play_random_animation(animated_sprite_2d)
	start_shoot_timer()
		
func start_shoot_timer() -> void:
	SpaceUtils.set_and_start_timer(timer, bullet_wait_time, bullet_wait_time_var)
	
func _on_timer_timeout() -> void:
	shoot()

func shoot() -> void:
	if !shoots_at_player:
		return
	var dest: Vector2
	if !shoots_at_player and is_instance_valid(_player_ref):
		dest = _player_ref.global_position.normalized()
	else:
		dest = bullet_direction
	SignalHub.emit_on_create_bullet(global_position, dest, bullet_speed, bullet_type)
	sound.play()
	start_shoot_timer()

func die() -> void:
	if randf() < power_up_chance:
		SignalHub.emit_on_create_powerup_random(global_position)
	super.die()
