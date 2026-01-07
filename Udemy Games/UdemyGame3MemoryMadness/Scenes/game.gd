extends Control
@onready var tile_grid: GridContainer = $HBoxContainer/TileGrid
const MEMORY_TILE = preload("uid://dc53rxfbvn582")
@onready var sound: AudioStreamPlayer = $Sound
@onready var scorer: Scorer = $Scorer
@onready var move_label: Label = $HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/MoveLabel
@onready var pairs_label: Label = $HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/PairsLabel

func _enter_tree() -> void:
	SignalHub.on_level_selected.connect(on_level_selected)
	
# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	move_label.text = scorer.get_moves_made_str()
	pairs_label.text = scorer.get_pairs_made_str()

func add_memory_tile(image: Texture2D, frame: Texture2D) -> void:
	var mt: MemoryTile = MEMORY_TILE.instantiate()
	tile_grid.add_child(mt)
	mt.setup(image, frame)

func on_level_selected(level_number: int) -> void:
	var lds: LevelDataSelector = LevelDataSelector.get_level_selection(level_number)
	var fi: Texture2D = ImageManager.get_random_frame_image()
	tile_grid.columns = lds.get_num_cols()
	
	for img in lds.get_selected_images():
		add_memory_tile(img, fi)
	
	scorer.clear_new_game(lds.get_target_pairs())


func _on_exit_button_pressed() -> void:
	SoundManager.play_button_click(sound)
	for t in tile_grid.get_children():
		t.queue_free()
	SignalHub.emit_on_exit_button_pressed()
