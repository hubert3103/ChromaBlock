extends Node2D  # or StaticBody2D

@onready var door_sound = $DoorSound

@export var open_sfx: AudioStream
@export var close_sfx: AudioStream
@onready var hitbox = $CollisionShape2D
@export var door_sprite: Sprite2D  # assign your door's sprite here in the editor

func open():
	hitbox.disabled = true
	if door_sprite:
		door_sprite.visible = false  # hide the sprite so player can walk through
	
	# Play open sound
	if open_sfx:
		door_sound.stream = open_sfx
		door_sound.play()
	
	print("Door opened")

func close():
	hitbox.disabled = false
	if door_sprite:
		door_sprite.visible = true   # show the sprite again to block player
	
	# Play close sound
	if close_sfx:
		door_sound.stream = close_sfx
		door_sound.play()

	print("Door closed")
