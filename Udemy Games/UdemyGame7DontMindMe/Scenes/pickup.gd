extends Area2D
class_name Pickup
@onready var sound: AudioStreamPlayer2D = $Sound

const GROUP_NAME: String = "pickup"
# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	SignalHub.emit_on_pickup_collected()
	set_deferred("monitoring", false)
	hide()
	sound.play()


func _on_sound_finished() -> void:
	queue_free()
