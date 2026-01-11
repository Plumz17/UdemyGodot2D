extends PathFollow2D

@export var ball_speed: float = 50
@export var ball_spin_speed: float = 360

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += ball_speed * delta
	rotation_degrees += ball_spin_speed * delta
