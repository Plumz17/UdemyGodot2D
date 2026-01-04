extends Node

@onready var pipes_holder: Node = $PipesHolder
@onready var lower_spawner: Marker2D = $LowerSpawner
@onready var upper_spawner: Marker2D = $UpperSpawner
@onready var timer: Timer = $Timer
const PIPES = preload("uid://k3ix1nlta8b")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_pipes():
	var spawn_y: float = randf_range(upper_spawner.position.y, lower_spawner.position.y)
	var new_pipes: Pipes = PIPES.instantiate()
	new_pipes.position = Vector2(upper_spawner.position.x, spawn_y) 
	pipes_holder.add_child(new_pipes)

func _on_timer_timeout() -> void:
	spawn_pipes()
