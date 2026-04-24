extends Node2D

@onready var switch_sound = $SwitchSound

@export var sound_on: AudioStream
@export var sound_off: AudioStream

@export var unpressed_texture: Texture
@export var pressed_texture: Texture

@export var door_node: NodePath  

# Choose switch color in Inspector
@export_enum("Green", "Red") var switch_color = "Green"

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
	print("Switch ON:", switch_color)

	# texture
	if $Sprite2D and pressed_texture:
		$Sprite2D.texture = pressed_texture

	# sound
	if sound_on:
		switch_sound.stream = sound_on
		switch_sound.play()

	var door = get_node_or_null(door_node)
	if door == null:
		return

	# COLOR LOGIC
	match switch_color:
		"Green":
			door.call_deferred("open")
		"Red":
			door.call_deferred("close")

func deactivate():
	print("Switch OFF:", switch_color)

	# texture
	if $Sprite2D and unpressed_texture:
		$Sprite2D.texture = unpressed_texture

	# sound
	if sound_off:
		switch_sound.stream = sound_off
		switch_sound.play()

	var door = get_node_or_null(door_node)
	if door == null:
		return

	# NEW: reverse logic
	match switch_color:
		"Green":
			door.call_deferred("close")
		"Red":
			door.call_deferred("open")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		print("Player in range")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		print("Player left range")
