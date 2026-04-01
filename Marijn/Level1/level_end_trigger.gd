extends Area2D

func _on_body_entered(body):
	print("Level complete")
	get_tree().current_scene.get_node("HUD").visible = true
	body.can_move = false
