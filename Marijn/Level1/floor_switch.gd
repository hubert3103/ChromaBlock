extends Area2D

@export var required_id: String = "A"
@export var unpressed_texture: Texture
@export var pressed_texture: Texture
@export var door_node: NodePath  # assign your Door node here in the editor

var is_active = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_crate_id") and body.get_crate_id() == required_id:
		is_active = true
		activate()

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("get_crate_id") and body.get_crate_id() == required_id:
		is_active = false
		deactivate()

func activate():
	print("Switch ON")
	if $Sprite2D:
		$Sprite2D.texture = pressed_texture
	# Tell the door to open (hide sprite + disable hitbox)
	if door_node:
		var door = get_node(door_node)
		if door:
			door.call_deferred("open")  # use deferred to avoid physics flush errors

func deactivate():
	print("Switch OFF")
	if $Sprite2D:
		$Sprite2D.texture = unpressed_texture
	# Tell the door to close (show sprite + enable hitbox)
	if door_node:
		var door = get_node(door_node)
		if door:
			door.call_deferred("close")
