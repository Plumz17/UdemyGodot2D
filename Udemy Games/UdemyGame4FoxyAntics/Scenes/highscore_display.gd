extends VBoxContainer

class_name HighScoreDisplayItem
@onready var score_label: Label = $ScoreLabel
@onready var time_label: Label = $TimeLabel

var _high_score: HighScore = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if HighScore == null:
		queue_free()
	else:
		score_label.text = "%05d" % _high_score.score
		time_label.text = _high_score.date_scored
		run_tween()

func run_tween() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color("#ffffff", 1.0), 0.8)

func setup(high_score: HighScore) -> void:
	_high_score = high_score
