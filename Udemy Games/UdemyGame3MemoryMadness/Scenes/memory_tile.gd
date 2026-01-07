extends TextureButton
class_name MemoryTile

@onready var item_image: TextureRect = $ItemImage
@onready var frame_image: TextureRect = $FrameImage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reveal(false)

func reveal(b: bool) -> void:
	frame_image.visible = b
	item_image.visible = b

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup(image: Texture2D, frame: Texture2D) -> void:
	item_image.texture = image
	frame_image.texture = frame

func kill_on_success() -> void:
	z_index = 1
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "disabled", true, 0)
	tween.tween_property(self, "rotation_degrees", 720, 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.set_parallel(false)
	tween.tween_interval(0.3)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.2)

func matches_other_tile(other: MemoryTile) -> bool:
	return other != self and other.item_image.texture == item_image.texture

func _on_pressed() -> void:
	if Scorer.SelectionEnabled:
		SignalHub.emit_on_tile_selected(self)
		reveal(true)
