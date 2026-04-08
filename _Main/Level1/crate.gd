extends CharacterBody2D

@export var crate_id: String = "A"
@export var diagonal_angle := 26.565

func _physics_process(delta):
	# --- FORCE DIAGONAL MOVEMENT ---
	if velocity != Vector2.ZERO:
		var dir = velocity.normalized()

		var sign_x = sign(dir.x)
		var sign_y = sign(dir.y)

		# Only allow diagonal directions
		if sign_x != 0 and sign_y != 0:
			var angle = deg_to_rad(diagonal_angle)

			dir.x = cos(angle) * sign_x
			dir.y = sin(angle) * sign_y
			dir = dir.normalized()

			velocity = dir * velocity.length()
		else:
			# If somehow straight, cancel movement
			velocity = Vector2.ZERO

	# --- FRICTION ---
	velocity = velocity.move_toward(Vector2.ZERO, 500 * delta)

	move_and_slide()

func get_crate_id():
	return crate_id
