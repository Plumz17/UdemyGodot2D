extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		SignalHub.emit_on_create_bullet(Vector2(200, 100), Vector2.DOWN, 200, BulletBase.BulletType.Player)
		SignalHub.emit_on_create_bullet(Vector2(315, 100), Vector2.DOWN, 200, BulletBase.BulletType.Enemy)
		SignalHub.emit_on_create_bullet(Vector2(400, 100), Vector2.DOWN, 200, BulletBase.BulletType.Bomb)

#Kfunc _ready() -> void:
	#Engine.time_scale = 0.2
