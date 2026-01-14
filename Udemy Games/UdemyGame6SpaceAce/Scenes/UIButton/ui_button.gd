extends TextureButton

@onready var label: Label = $Label
@export var text: String = "Set Me"

func _ready() -> void:
	label.text = text
