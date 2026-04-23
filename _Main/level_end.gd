extends CanvasLayer


func _ready() -> void:
	print("Next level UI ready")


func _on_next_level_button_pressed() -> void:
	print("BUTTON PRESSED")

	var current_scene = get_tree().current_scene
	
	if current_scene == null:
		print("ERROR: current_scene is null")
		return

	var current = current_scene.scene_file_path
	print("Current scene path:", current)

	if current == "res://_Main/Level1/level1.tscn":
		print("Going to Level2")
		get_tree().change_scene_to_file("res://hubert/level2/level2.tscn")

	elif current == "res://hubert/level2/level2.tscn":
		print("Going to Level3")
		get_tree().change_scene_to_file("res://_Main/Level3/level3.tscn")

	elif current == "res://_Main/Level3/level3.tscn":
		print("Going to Level4")
		get_tree().change_scene_to_file("res://hubert/level4/Level4.tscn")

	elif current == "res://hubert/level4/Level4.tscn":
		print("Going to Main Menu")
		get_tree().change_scene_to_file("res://MainMenu.tscn")

	else:
		print("Scene not recognized in list!")
