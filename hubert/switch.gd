extends Node2D

@export var unpressed_texture: Texture
@export var pressed_texture: Texture
@export var door_node: NodePath  

var is_active = false
var player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		toggle()


func toggle():
	is_active = !is_active
	
	if is_active:
		activate()
	else:
		deactivate()

func activate():
	print("Switch ON")
	
	if $Sprite2D:
		$Sprite2D.texture = pressed_texture
	
	if door_node:
		var door = get_node(door_node)
		if door:
			door.call_deferred("open")

func deactivate():
	print("Switch OFF")
	
	if $Sprite2D:
		$Sprite2D.texture = unpressed_texture
	
	if door_node:
		var door = get_node(door_node)
		if door:
			door.call_deferred("close")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		print("Player in range")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		print("Player left range")
