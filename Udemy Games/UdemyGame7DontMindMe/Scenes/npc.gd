extends CharacterBody2D
@onready var nav_agent: NavigationAgent2D = $NavAgent
@onready var debug_label: Label = $DebugLabel
@onready var player_detect: RayCast2D = $PlayerDetect
@onready var gasp_sound: AudioStreamPlayer2D = $GaspSound
@onready var warning: Sprite2D = $Warning
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shoot_timer: Timer = $ShootTimer
@onready var laser_sound: AudioStreamPlayer2D = $LaserSound
const BULLET = preload("uid://bebejhu4raino")


const SPEED: Dictionary[EnemyState, float] = {
	EnemyState.Patrolling: 60,
	EnemyState.Chasing: 100,
	EnemyState.Searching: 80
}
const FOV: Dictionary[EnemyState, float] = {
	EnemyState.Patrolling: 60,
	EnemyState.Chasing: 120,
	EnemyState.Searching: 100
}

enum EnemyState {Patrolling, Chasing, Searching}
@export var patriol_points: NodePath

var _waypoints: Array[Vector2] 
var _current_wp: int = 0
var _current_state: EnemyState = EnemyState.Patrolling
var _player_ref: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_wp()
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !_player_ref:
		queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		nav_agent.target_position = get_global_mouse_position()

func is_player_visible() -> bool:
	return player_detect.get_collider() is Player

func get_fov_angle() -> float:
	var dtp: Vector2 = global_position.direction_to(_player_ref.global_position)
	var atp: float = transform.x.angle_to(dtp)
	return rad_to_deg(atp)

func can_see_player() -> bool:
	return abs(get_fov_angle()) <= FOV[_current_state] and is_player_visible()

func create_wp() -> void:
	for wp in get_node(patriol_points).get_children():
		_waypoints.append(wp.global_position)

func navigate_wp() -> void:
	if _waypoints.is_empty():
		return
	nav_agent.target_position = _waypoints[_current_wp]
	_current_wp = (_current_wp + 1) % _waypoints.size()

func update_movement() -> void:
	if nav_agent.is_navigation_finished():
		return
	
	var npp: Vector2 = nav_agent.get_next_path_position()
	rotation = global_position.direction_to(npp).angle()
	velocity = transform.x * SPEED[_current_state]
	move_and_slide()

func process_behaviour() -> void:
	match _current_state:
		EnemyState.Patrolling:
			process_patrolling()
		EnemyState.Chasing:
			process_chasing()
		EnemyState.Searching:
			process_searching()

func process_patrolling() -> void:
	if nav_agent.is_navigation_finished():
		navigate_wp()

func process_chasing() -> void:
	nav_agent.target_position = _player_ref.global_position

func process_searching() -> void:
	if nav_agent.is_navigation_finished():
		set_state(EnemyState.Patrolling)

func set_state(new_state: EnemyState) -> void:
	if _current_state == new_state:
		return
	if _current_state == EnemyState.Searching:
		warning.hide()
	if new_state == EnemyState.Searching:
		warning.show()
	elif new_state == EnemyState.Chasing:
		gasp_sound.play()
		animation_player.play("alert")
	elif new_state == EnemyState.Patrolling:
		animation_player.play("RESET")
	
	_current_state = new_state

func detect_player() -> void:
	if can_see_player():
		set_state(EnemyState.Chasing)
	elif _current_state == EnemyState.Chasing:
		set_state(EnemyState.Searching)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	detect_player()
	process_behaviour()
	update_movement()
	update_raycast()
	set_debug_label()

func update_raycast() -> void:
	player_detect.look_at(_player_ref.global_position)

func set_debug_label() -> void:
	debug_label.rotation = -debug_label.rotation
	var s: String = "Fin:%s,ST:%s\n" % [nav_agent.is_navigation_finished(), EnemyState.keys()[_current_state]]
	s += "VIS:%s, FOV: %.0f\n" % [is_player_visible(), get_fov_angle()]
	s += "SEE:%s" % can_see_player()
	debug_label.text = s

func shoot() -> void:
	if _current_state != EnemyState.Chasing:
		return
	var nb: Bullet = BULLET.instantiate()
	nb.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", nb)
	laser_sound.play()

func _on_shoot_timer_timeout() -> void:
	shoot()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		SignalHub.emit_on_player_died()
