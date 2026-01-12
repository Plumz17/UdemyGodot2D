extends Node

const LEVEL_DATA_PATH: String = "res://Data/level_data.json"
var _level_data: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level_data()

func add_tiles_by_layer(layout: LevelLayout, tile_type: TileLayers.LayerType, tile_coor: Array) -> void:
	for tc in tile_coor:
		layout.add_tile_to_layer(tc["x"], tc["y"], tile_type)

func setup_level(ln: String, raw_level_data: Dictionary) -> LevelLayout:
	var layout: LevelLayout = LevelLayout.new()
	var raw_tiles: Dictionary = raw_level_data["tiles"]
	var player_start: Dictionary = raw_level_data["player_start"]
	add_tiles_by_layer(layout, TileLayers.LayerType.Floor, raw_tiles["Floor"])
	add_tiles_by_layer(layout, TileLayers.LayerType.Walls, raw_tiles["Walls"])
	add_tiles_by_layer(layout, TileLayers.LayerType.Targets, raw_tiles["Targets"])
	add_tiles_by_layer(layout, TileLayers.LayerType.Boxes, raw_tiles["Boxes"])
	add_tiles_by_layer(layout, TileLayers.LayerType.TargetBoxes, raw_tiles["TargetBoxes"])
	layout.set_player_start(player_start["x"], player_start["y"])
	return layout

	
func load_level_data() -> void:
	var file: FileAccess = FileAccess.open(LEVEL_DATA_PATH, FileAccess.READ)
	if !file:
		return
	
	var data_dict: Dictionary = JSON.parse_string(file.get_as_text())
	for level_num in data_dict.keys():
		var level_data = data_dict[level_num]
		_level_data[level_num] = setup_level(level_num, level_data)
	pass

func get_level_data(ln: String) -> LevelLayout:
	return _level_data[ln]
