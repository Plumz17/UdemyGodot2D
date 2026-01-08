extends EnemyBase

@onready var ray_cast_2d: RayCast2D = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += _gravity * delta
	velocity.x = speed if animated_sprite_2d.flip_h == true else -speed
	move_and_slide()
	flip_snail()
	
func flip_snail() -> void:
	if is_on_wall() == true or ray_cast_2d.is_colliding() == false:
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		ray_cast_2d.position.x = -ray_cast_2d.position.x
