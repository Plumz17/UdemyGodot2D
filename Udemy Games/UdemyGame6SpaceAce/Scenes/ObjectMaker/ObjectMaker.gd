extends Node2D


const ADD_OBJECT: String = "add_object"
const EXPLOSION = preload("uid://52y55kowbcxh")
const POWER_UP = preload("uid://cy1od60rxjixj")
const BULLET_BOMB = preload("uid://bm0nnuweflsla")
const BULLET_ENEMY = preload("uid://b5gd4lfl76hsm")
const BULLET_PLAYER = preload("uid://mcy2jyiy251x")

func _enter_tree() -> void:
	SignalHub.on_create_explosion.connect(on_create_explosion)
	SignalHub.on_create_powerup.connect(on_create_powerup)
	SignalHub.on_create_powerup_random.connect(on_create_powerup_random)
	SignalHub.on_create_bullet.connect(on_create_bullet)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos

func on_create_explosion(pos: Vector2, anim_name: String) -> void:
	var ex: Explosion = EXPLOSION.instantiate()
	ex.setup(anim_name)
	call_deferred(ADD_OBJECT, ex, pos)


func on_create_powerup(pos: Vector2, powerup_type: PowerUp.PowerUpType) -> void:
	var pu: PowerUp = POWER_UP.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	pu.power_up_type = powerup_type
	call_deferred(ADD_OBJECT, pu, pos)
	
func on_create_powerup_random(pos: Vector2) -> void:
	var pu: PowerUp = POWER_UP.instantiate()
	pu.power_up_type = PowerUp.PowerUpType.values().pick_random()
	call_deferred(ADD_OBJECT, pu, pos)

func on_create_bullet(pos: Vector2, direction: Vector2, speed: float, bullet_type: BulletBase.BulletType) -> void:
	var scene: PackedScene
	match bullet_type:
		BulletBase.BulletType.Player:
			scene = BULLET_PLAYER
		BulletBase.BulletType.Enemy:
			scene = BULLET_ENEMY
		BulletBase.BulletType.Bomb:
			scene = BULLET_BOMB
	if scene:
		var nb: BulletBase = scene.instantiate()
		nb.setup(direction, speed)
		call_deferred(ADD_OBJECT, nb, pos)
