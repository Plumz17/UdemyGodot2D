extends Resource

class_name ImageFilesListResource

@export var file_name: Array[String]

func add_file(fn: String) -> void:
	if !fn.ends_with(".import"):
		file_name.append(fn)
