extends Control
@onready var health_bar: HealthBar = $ColorRect/MarginContainer/HealthBar
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var score_label: Label = $ColorRect/MarginContainer/ScoreLabel

func _enter_tree() -> void:
	SignalHub.on_player_hit.connect(on_player_hit)
	SignalHub.on_player_health_bonus.connect(on_player_health_bonus)
	SignalHub.on_score_updated.connect(on_score_updated)

func _ready() -> void:
	ScoreManager.reset_score()

func on_player_hit(v: int) -> void:
	health_bar.take_damage(v)

func on_player_health_bonus(v: int) -> void:
	health_bar.incr_value(v)
	audio_stream_player.play()

func _on_health_bar_died() -> void:
	SignalHub.emit_on_player_died()

func on_score_updated(v: int) -> void:
	score_label.text = "%06d" % v

	
