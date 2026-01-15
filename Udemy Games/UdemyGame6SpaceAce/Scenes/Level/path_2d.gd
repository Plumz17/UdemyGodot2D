extends Path2D

func _exit_tree():
	print("PATH2D REMOVED:", self)
	print_stack()
