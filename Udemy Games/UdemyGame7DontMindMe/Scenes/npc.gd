extends CharacterBody2D
@onready var nav_agent: NavigationAgent2D = $NavAgent
@onready var debug_label: Label = $DebugLabel

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		nav_agent.target_position = get_global_mouse_position()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	set_debug_label()

func set_debug_label() -> void:
	var s: String = "Fin:%s\n" % nav_agent.is_navigation_finished()
	s += "TG_REA:%s\n" % nav_agent.is_target_reached()
	s += "CAN_REA:%s\n" % nav_agent.is_target_reachable()
	s += "TAR:%s" % nav_agent.target_position
	debug_label.text = s
