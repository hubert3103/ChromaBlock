extends CharacterBody2D

@export var push_speed = 100

func push(direction: Vector2):
	velocity = direction * push_speed
	move_and_slide()
