extends Node

const FRAME_IMAGES: Array[Texture2D] = [
	preload("uid://bryx0mpxae2f2"),
	preload("uid://bt3fnq3hwflfe"),
	preload("uid://dh18wmit8ygie"),
	preload("uid://d01h8n2dets7q")
]

var _image_list: Array[Texture2D]

func _enter_tree() -> void:
	var ifl: ImageFilesListResource = load("res://Resources/image_files_list.tres")
	for file in ifl.file_name:
		_image_list.append(load(file))

func shuffle_image() -> void:
	_image_list.shuffle()
 
func get_image(index: int) -> Texture2D:
	return _image_list[index]

func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()
	
func get_random_item_image() -> Texture2D:
	return _image_list.pick_random()
