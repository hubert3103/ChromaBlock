extends CharacterBody2D

@export var push_speed = 100

func push(direction: Vector2):
	if direction == Vector2.ZERO:
		return
	
	var diag = Vector2(
		sign(direction.x),
		sign(direction.y)
	)
	
	# If purely horizontal, choose vertical based on last movement (example fallback)
	if diag.y == 0:
		diag.y = 1 if direction.y >= 0 else -1
	
	if diag.x == 0:
		diag.x = 1 if direction.x >= 0 else -1
	
	velocity = diag.normalized() * push_speed
	move_and_slide()
