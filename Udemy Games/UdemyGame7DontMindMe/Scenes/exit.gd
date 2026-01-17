extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func _enter_tree() -> void:
	SignalHub.on_show_exit.connect(on_show_exit)

func on_show_exit() -> void:
	show()
	monitoring = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SignalHub.emit_exit()
