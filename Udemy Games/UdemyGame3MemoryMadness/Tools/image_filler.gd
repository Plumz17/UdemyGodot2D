@tool
extends EditorScript

const IMAGE_PATH: String = "res://Assets/glitch/"
const RES_PATH: String = "res://Resources/image_files_list.tres"
# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	var dir: DirAccess = DirAccess.open(IMAGE_PATH)
	var ifl: ImageFilesListResource = ImageFilesListResource.new()
	
	if dir:
		var files: PackedStringArray = dir.get_files()
		for file in files:
			ifl.add_file(IMAGE_PATH + file)
		ResourceSaver.save(ifl, RES_PATH)
