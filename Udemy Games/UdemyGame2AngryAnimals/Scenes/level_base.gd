extends Node2D
@onready var animal_start: Marker2D = $AnimalStart
const ANIMAL = preload("uid://cg0qs4dl53cop")

func _ready() -> void:
	SignalHub.on_animal_died.connect(spawn_animal)
	spawn_animal()
	
#func _enter_tree() -> void:
	#SignalHub.on_animal_died.connect(spawn_animal) # Might bug and have to be added into a on enter tree
	
	
func spawn_animal() -> void:
	var animal: Animal = ANIMAL.instantiate()
	animal.position = animal_start.position
	add_child(animal)
	
