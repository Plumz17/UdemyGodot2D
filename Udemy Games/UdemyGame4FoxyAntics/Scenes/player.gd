extends CharacterBody2D
class_name Player
const JUMP = preload("uid://bahjhbodc431o")
const DAMAGE = preload("uid://udiikexqyklc")



@export var gravity: float = 690
@export var jump_force: float = -270
@export var run_speed: float = 150 
@export var terminal_velocity: float = 350
@export var fallen_off_y: float = 200
@export var hurt_jump_velocity: Vector2 = Vector2(0.0, -130)
@export var camera_min: Vector2 = Vector2(-1000, 1000)
@export var camera_max: Vector2 = Vector2(1000, -1000)

@onready var camera: Camera2D = $Camera
@onready var hurt_timer: Timer = $HurtTimer
@onready var shooter: Shooter = $Shooter
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var _is_hurt: bool = false
var _is_invincible: bool = false
var _lives: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_camera()
	call_deferred("late_init")

func setup_camera() -> void:
	camera.limit_bottom = camera_min.y
	camera.limit_left = camera_min.x
	camera.limit_top = camera_max.y
	camera.limit_right = camera_max.x

func late_init() -> void:
	SignalHub._emit_on_player_hit(_lives, false)

func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var dir: Vector2 = Vector2.LEFT if sprite_2d.flip_h else Vector2.RIGHT
		shooter.shoot(dir)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	get_input()
	velocity.y = clamp(velocity.y, jump_force, terminal_velocity)
	move_and_slide()
	update_debug_label()
	fallen_off()

func play_effect(effect: AudioStream) -> void:
	audio_stream_player_2d.stream = effect
	audio_stream_player_2d.play()

func get_input() -> void:
	if _is_hurt:
		return
	velocity.x = Input.get_axis("left", "right") * run_speed
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
		play_effect(JUMP)
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0


func update_debug_label() -> void:
	var ds: String = ""
	ds += "FL:%s,LV:%s\n" % [is_on_floor(), _lives]
	ds += "V:%.1f,%.1f\n" % [velocity.x, velocity.y]
	ds += "P:%.1f,%.1f" % [global_position.x, global_position.y]
	label.text = ds

func fallen_off() -> void:
	if global_position.y > fallen_off_y:
		reduce_lives(_lives)

func reduce_lives(reduction: int) -> bool:
	_lives -= reduction
	SignalHub._emit_on_player_hit(_lives, true)
	if _lives <= 0:
		print("DEAD")
		set_physics_process(false)
		return false
	return true

func apply_hit() -> void:
	if _is_invincible:
		return
	if reduce_lives(1) == false:
		return
	
	go_invincible()
	apply_hurt_jump()
	
func go_invincible() -> void:
	if _is_invincible:
		return
	_is_invincible = true
	var tween: Tween = create_tween()
	for i in range(3):
		tween.tween_property(sprite_2d, "modulate", Color("ffffff", 0), 0.5)
		tween.tween_property(sprite_2d, "modulate", Color("ffffff", 1.0), 0.5)
	tween.tween_property(self, "_is_invincible", false, 0)
	
	
func apply_hurt_jump() -> void:
	_is_hurt = true
	velocity = hurt_jump_velocity
	hurt_timer.start()
	play_effect(DAMAGE)

func _on_hitbox_area_entered(area: Area2D) -> void:
	call_deferred("apply_hit")


func _on_hurt_timer_timeout() -> void:
	_is_hurt = false
