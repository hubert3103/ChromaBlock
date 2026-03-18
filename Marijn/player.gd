extends CharacterBody2D

@export var speed = 100

func _physics_process(delta):
	var x = 0
	var y = 0

	# Horizontal input
	if Input.is_action_pressed("move_right"):
		x += 1
	if Input.is_action_pressed("move_left"):
		x -= 1

	# Vertical input
	if Input.is_action_pressed("move_down"):
		y += 1
	if Input.is_action_pressed("move_up"):
		y -= 1

	var input_vector = Vector2(x, y)

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
		move_and_slide()

		# --- Animation selection ---
		if x > 0 and y < 0:  # UpRight
			$AnimatedSprite2D.animation = "UpRight"
			$AnimatedSprite2D.flip_h = false
		elif x < 0 and y < 0:  # UpLeft
			$AnimatedSprite2D.animation = "UpRight"  # reuse Right sprite
			$AnimatedSprite2D.flip_h = true
		elif x > 0 and y > 0:  # DownRight
			$AnimatedSprite2D.animation = "DownRight"
			$AnimatedSprite2D.flip_h = false
		elif x < 0 and y > 0:  # DownLeft
			$AnimatedSprite2D.animation = "DownRight"  # reuse Right sprite
			$AnimatedSprite2D.flip_h = true
		elif y < 0:  # Up
			$AnimatedSprite2D.animation = "Up"
			$AnimatedSprite2D.flip_h = false
		elif y > 0:  # Down
			$AnimatedSprite2D.animation = "Down"
			$AnimatedSprite2D.flip_h = false
		elif x > 0:  # Right
			$AnimatedSprite2D.animation = "Right"
			$AnimatedSprite2D.flip_h = false
		elif x < 0:  # Left
			$AnimatedSprite2D.animation = "Right"
			$AnimatedSprite2D.flip_h = true

		$AnimatedSprite2D.play()
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()
