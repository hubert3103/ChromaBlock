extends CharacterBody2D

@export var push_speed = 100
@export var crate_id: String = "A"

func push(direction: Vector2):
	if direction == Vector2.ZERO:
		return
	
	velocity = direction.normalized() * push_speed
	move_and_slide()
	
func get_crate_id():
	return crate_id
