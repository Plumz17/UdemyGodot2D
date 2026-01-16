extends Node


signal on_player_hit(v: int)
signal on_player_health_bonus(v: int)
signal on_score_updated(v: int)
signal on_create_explosion(position: Vector2, anim_name: String)
signal on_create_powerup(position: Vector2, powerup_type: PowerUp.PowerUpType)
signal on_create_powerup_random(position: Vector2)
signal on_create_bullet(position: Vector2, direction: Vector2, speed: float, bullet_type: BulletBase.BulletType)
signal on_create_homing_missile(pos: Vector2)
signal on_player_died


func emit_on_player_hit(v: int) -> void:
	on_player_hit.emit(v)

func emit_on_player_health_bonus(v: int) -> void:
	on_player_health_bonus.emit(v)

func emit_on_score_updated(v: int):
	on_score_updated.emit(v)

func emit_on_create_explosion(position: Vector2, anim_name: String) -> void:
	on_create_explosion.emit(position, anim_name)

func emit_on_create_powerup(position: Vector2, powerup_type: PowerUp.PowerUpType) -> void:
	on_create_powerup.emit(position, powerup_type)
	
func emit_on_create_powerup_random(position: Vector2) -> void:
	on_create_powerup_random.emit(position)

func emit_on_create_bullet(position: Vector2, direction: Vector2, speed: float, bullet_type: BulletBase.BulletType) -> void:
	on_create_bullet.emit(position, direction, speed, bullet_type)
	
	
func emit_on_player_died():
	on_player_died.emit()

func emit_on_create_homing_missile(pos: Vector2):
	on_create_homing_missile.emit(pos)
