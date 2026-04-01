extends Node2D  # or StaticBody2D

@onready var hitbox = $CollisionShape2D
@export var door_sprite: Sprite2D  # assign your door's sprite here in the editor

func open():
	hitbox.disabled = true
	if door_sprite:
		door_sprite.visible = false  # hide the sprite so player can walk through
	print("Door opened")

func close():
	hitbox.disabled = false
	if door_sprite:
		door_sprite.visible = true   # show the sprite again to block player
	print("Door closed")
