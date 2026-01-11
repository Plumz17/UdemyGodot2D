extends Node2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hitbox: Area2D = $Visuals/Hitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate_collisions() -> void:
	hitbox.set_deferred("monitorable", true)
	hitbox.set_deferred("monitoring", true)

func _on_trigger_area_entered(area: Area2D) -> void:
	animation_tree["parameters/conditions/on_trigger"] = true
