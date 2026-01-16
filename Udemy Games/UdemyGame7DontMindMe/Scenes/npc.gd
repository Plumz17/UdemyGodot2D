extends CharacterBody2D
@onready var nav_agent: NavigationAgent2D = $NavAgent
@onready var debug_label: Label = $DebugLabel
const SPEED: float = 100.0
enum EnemyState {Patrolling, Chasing, Searching}

@export var patriol_points: NodePath

var _waypoints: Array[Vector2] 
var _current_wp: int = 0
var _current_state: EnemyState = EnemyState.Patrolling

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		nav_agent.target_position = get_global_mouse_position()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_wp()

func create_wp() -> void:
	for wp in get_node(patriol_points).get_children():
		_waypoints.append(wp.global_position)

func navigate_wp() -> void:
	if _waypoints.is_empty():
		return
	nav_agent.target_position = _waypoints[_current_wp]
	_current_wp = (_current_wp + 1) % _waypoints.size()

func update_navigation() -> void:
	if nav_agent.is_navigation_finished():
		return
	
	var npp: Vector2 = nav_agent.get_next_path_position()
	rotation = global_position.direction_to(npp).angle()
	velocity = transform.x * SPEED
	move_and_slide()

func update_movement() -> void:
	match _current_state:
		EnemyState.Patrolling:
			process_patrolling()

func process_patrolling() -> void:
	if nav_agent.is_navigation_finished():
		navigate_wp()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_movement()
	update_navigation()
	set_debug_label()

func set_debug_label() -> void:
	debug_label.rotation = -debug_label.rotation
	var s: String = "Fin:%s,ST:%s\n" % [nav_agent.is_navigation_finished(), EnemyState.keys()[_current_state]]
	s += "TG_REA:%s\n" % nav_agent.is_target_reached()
	s += "CAN_REA:%s\n" % nav_agent.is_target_reachable()
	s += "TAR:%s" % nav_agent.target_position
	debug_label.text = s
