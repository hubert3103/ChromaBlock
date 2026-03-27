extends CharacterBody2D

@export var speed = 100

var last_direction = "Down"

func _physics_process(delta):
	var x = 0
	var y = 0

	# --- Input ---
	if Input.is_action_pressed("move_right"):
		x += 1
	if Input.is_action_pressed("move_left"):
		x -= 1
	if Input.is_action_pressed("move_down"):
		y += 1
	if Input.is_action_pressed("move_up"):
		y -= 1

	var input_vector = Vector2(x, y)

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
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

		if x > 0 and y < 0:
			anim_name = "UpRight"
			last_direction = "UpRight"
		elif x < 0 and y < 0:
			anim_name = "UpRight"
			flip_h = true
			last_direction = "UpLeft"
		elif x > 0 and y > 0:
			anim_name = "DownRight"
			last_direction = "DownRight"
		elif x < 0 and y > 0:
			anim_name = "DownRight"
			flip_h = true
			last_direction = "DownLeft"
		elif y < 0:
			anim_name = "Up"
			last_direction = "Up"
		elif y > 0:
			anim_name = "Down"
			last_direction = "Down"
		elif x > 0:
			anim_name = "Right"
			last_direction = "Right"
		elif x < 0:
			anim_name = "Right"
			flip_h = true
			last_direction = "Left"

		$AnimatedSprite2D.animation = anim_name
		$AnimatedSprite2D.flip_h = flip_h
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "Idle" + last_direction
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
