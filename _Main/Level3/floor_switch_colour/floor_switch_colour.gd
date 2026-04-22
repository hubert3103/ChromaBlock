extends Area2D

@onready var switch_sound = $FloorswitchSound

@export var switch_sfx: AudioStream
@export var required_id: String = "A"

@export var unpressed_texture: Texture
@export var pressed_texture: Texture

@export var door_node: NodePath

var is_active = false


func _on_body_entered(body: Node2D) -> void:
	print("Something entered switch")

	if body.has_method("get_crate_id"):
		print("Crate ID found:", body.get_crate_id())

	if body.has_method("get_crate_id") and body.get_crate_id() == required_id:
		print("Correct crate detected")

		if body.has_method("is_red_active"):
			print("Red active check:", body.is_red_active())

		if body.has_method("is_red_active") and body.is_red_active():
			print("RED FACE MATCHED - ACTIVATING SWITCH")
			is_active = true
			activate()
		else:
			print("Wrong color on top - switch stays off")


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("get_crate_id") and body.get_crate_id() == required_id:
		is_active = false
		deactivate()


func activate():
	print("Switch ON")

	if $Sprite2D:
		$Sprite2D.texture = pressed_texture

	if switch_sfx:
		switch_sound.stream = switch_sfx
		switch_sound.play()

	if door_node:
		var door = get_node(door_node)
		if door:
			door.call_deferred("open")


func deactivate():
	print("Switch OFF")

	if $Sprite2D:
		$Sprite2D.texture = unpressed_texture

	if switch_sfx:
		switch_sound.stream = switch_sfx
		switch_sound.play()

	if door_node:
		var door = get_node(door_node)
		if door:
			door.call_deferred("close")
