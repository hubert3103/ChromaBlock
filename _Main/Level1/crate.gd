extends CharacterBody2D

@export var crate_id: String = "A"
@export var diagonal_angle := 26.565
@export var push_strength := 375

var can_be_pushed := true

func _physics_process(delta):
	# --- FORCE DIAGONAL MOVEMENT ---
	if velocity != Vector2.ZERO:
		var dir = velocity.normalized()

		var sign_x = sign(dir.x)
		var sign_y = sign(dir.y)

		if sign_x != 0 and sign_y != 0:
			var angle = deg_to_rad(diagonal_angle)

			dir.x = cos(angle) * sign_x
			dir.y = sin(angle) * sign_y
			dir = dir.normalized()

			velocity = dir * velocity.length()
		else:
			velocity = Vector2.ZERO

	# --- FRICTION ---
	velocity = velocity.move_toward(Vector2.ZERO, 500 * delta)

	move_and_slide()

	# Reset push when fully stopped
	if velocity.length() < 5:
		can_be_pushed = true


func push(direction: Vector2):
	if not can_be_pushed:
		return

	can_be_pushed = false

	var dir = direction.normalized()

	var sign_x = sign(dir.x)
	var sign_y = sign(dir.y)

	if sign_x != 0 and sign_y != 0:
		var angle = deg_to_rad(diagonal_angle)

		dir.x = cos(angle) * sign_x
		dir.y = sin(angle) * sign_y
		dir = dir.normalized()

		velocity = dir * push_strength


func get_crate_id():
	return crate_id
