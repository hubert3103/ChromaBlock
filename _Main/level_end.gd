extends CanvasLayer

@export var next_scene: PackedScene

func _ready() -> void:
	print("Next level UI ready")
	
	# Ensure focus works even if paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	await get_tree().process_frame
	$NextLevelButton.grab_focus()


func _on_next_level_button_pressed() -> void:
	print("BUTTON PRESSED")

	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
	else:
		print("ERROR: next_scene not assigned!")
