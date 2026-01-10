extends Node2D

const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER: preload("uid://ca83txi56yw7x"),
	Constants.ObjectType.BULLET_ENEMY: preload("uid://uqk3neig2rff"),
	Constants.ObjectType.EXPLOSION: preload("uid://blwpi0qwysa8h"),
	Constants.ObjectType.PICKUP: preload("uid://chi6sfm2uovqv")
}

func _enter_tree() -> void:
	SignalHub.connect("on_create_bullet", on_create_bullet)
	SignalHub.connect("on_create_object", on_create_object)
	
func on_create_bullet(pos:Vector2, dir:Vector2, speed: float, ob_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var nb: Bullet = OBJECT_SCENES[ob_type].instantiate()
	nb.setup(pos, dir, speed)
	call_deferred("add_child", nb)
	
func on_create_object(pos:Vector2, ob_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(ob_type):
		return
	var ne: Node2D = OBJECT_SCENES[ob_type].instantiate()
	ne.global_position = pos
	call_deferred("add_child", ne)
