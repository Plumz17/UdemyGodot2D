extends PathFollow2D
class_name EnemyBase

@export var points: int = 10
@export var crash_damage: int = 10
@onready var booms: Node2D = $Booms
@onready var health_bar: HealthBar = $HealthBar


var _speed: float = 50

func make_booms() -> void:
	for b in booms.get_children():
		SignalHub.emit_on_create_explosion(
			b.global_position, 
			Explosion.BOOM
		)

func _process(delta: float) -> void:
	progress += delta * _speed
	if progress_ratio > 0.99:
		queue_free()
		
func die() -> void:
	make_booms()
	queue_free()


func _on_health_bar_died() -> void:
	ScoreManager.increment_score(points)
	die()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is BulletBase:
		health_bar.take_damage(area.get_damage())
