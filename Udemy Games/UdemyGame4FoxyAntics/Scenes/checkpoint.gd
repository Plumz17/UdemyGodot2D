extends Area2D

var _boss_killed: bool = false


func _enter_tree() -> void:
	SignalHub.connect("on_boss_killed", on_boss_killed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_boss_killed() -> void:
	_boss_killed = true
	print(_boss_killed)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open":
		set_deferred("monitoring", true)


func _on_area_entered(area: Area2D) -> void:
	SignalHub._emit_on_level_complete(true)
