extends Control

@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/GridContainer
const LEVEL_BUTTON = preload("uid://gv3cwn4j3skd")
const LEVEL_NUMBER = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_grid()


func setup_grid() -> void:
	for i in range(LEVEL_NUMBER):
		var lb: LevelButton = LEVEL_BUTTON.instantiate()
		lb.setup(i + 1)
		grid_container.add_child(lb)
