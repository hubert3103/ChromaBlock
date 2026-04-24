extends Control

@export var target_scene: PackedScene


func _ready() -> void:
	# Wait a frame so focus actually sticks
	await get_tree().process_frame
	$Button.grab_focus()


func _on_button_pressed():
	if target_scene:
		get_tree().change_scene_to_packed(target_scene)
	else:
		print("ERROR: target_scene not assigned!")
