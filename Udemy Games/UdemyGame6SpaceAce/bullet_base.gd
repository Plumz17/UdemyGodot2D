extends Projectile
class_name BulletBase

enum BulletType {Player, Enemy, Bomb}
var _direction: Vector2 = Vector2.UP
var _speed: float = 20.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += _direction * _speed * delta

func setup(dir: Vector2, spd: float) -> void:
	_direction = dir
	_speed = spd

func blow_up() -> void:
	SignalHub.emit_on_create_explosion(position, Explosion.EXPLODE)
	super()
