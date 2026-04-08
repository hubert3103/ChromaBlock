extends CharacterBody2D

@export var speed = 100
@export var diagonal_angle := 26.565

var last_direction = "Down"
var can_move = true	

func _physics_process(delta):
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		
		$AnimatedSprite2D.animation = "Idle" + last_direction
		$AnimatedSprite2D.play()
		return

	var move_vector = Vector2.ZERO

	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed("move_down")
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")

	# --- REQUIRE 2 KEYS FOR MOVEMENT ---
	if up and right:
		move_vector = Vector2(1, -1)   # UpRight
	elif up and left:
		move_vector = Vector2(-1, -1)  # UpLeft
	elif down and right:
		move_vector = Vector2(1, 1)    # DownRight
	elif down and left:
		move_vector = Vector2(-1, 1)   # DownLeft

	if move_vector != Vector2.ZERO:
		move_vector = move_vector.normalized()

		# Apply angle tuning
		var angle = deg_to_rad(diagonal_angle)
		var sign_x = sign(move_vector.x)
		var sign_y = sign(move_vector.y)

		move_vector.x = cos(angle) * sign_x
		move_vector.y = sin(angle) * sign_y
		move_vector = move_vector.normalized()

		velocity = move_vector * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# --- NATURAL PUSHING ---
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is CharacterBody2D:
			var push_dir = -collision.get_normal()
			collider.velocity = push_dir * speed

	# --- Animation ---
	if velocity != Vector2.ZERO:
		var anim_name = ""
		var flip_h = false

		if move_vector.x > 0 and move_vector.y < 0:
			anim_name = "UpRight"
			last_direction = "UpRight"
		elif move_vector.x < 0 and move_vector.y < 0:
			anim_name = "UpRight"
			flip_h = true
			last_direction = "UpLeft"
		elif move_vector.x > 0 and move_vector.y > 0:
			anim_name = "DownRight"
			last_direction = "DownRight"
		elif move_vector.x < 0 and move_vector.y > 0:
			anim_name = "DownRight"
			flip_h = true
			last_direction = "DownLeft"

		$AnimatedSprite2D.animation = anim_name
		$AnimatedSprite2D.flip_h = flip_h
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "Idle" + last_direction
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
