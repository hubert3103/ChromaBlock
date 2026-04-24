extends CharacterBody2D

@export var speed = 100
@onready var footstep_player = $FootstepPlayer

@export var footstep_1: AudioStream
@export var footstep_2: AudioStream

var step_toggle = false
var step_timer = 0.0
@export var step_interval = 0.3

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

	# ======================================================
	# KEYBOARD INPUT (STRICT: requires 2 keys for diagonal)
	# ======================================================
	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed("move_down")
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")

	var keyboard_used = up or down or left or right

	if keyboard_used:
		if up and right:
			move_vector = Vector2(1, -1)
		elif up and left:
			move_vector = Vector2(-1, -1)
		elif down and right:
			move_vector = Vector2(1, 1)
		elif down and left:
			move_vector = Vector2(-1, 1)

	# ======================================================
	# CONTROLLER INPUT (smooth analog / stick support)
	# ======================================================
	else:
		var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

		if input_dir.length() > 0.2:
			var angle = input_dir.angle()

			if angle > -PI/2 and angle < 0:
				move_vector = Vector2(1, -1)
			elif angle > -PI and angle < -PI/2:
				move_vector = Vector2(-1, -1)
			elif angle > 0 and angle < PI/2:
				move_vector = Vector2(1, 1)
			else:
				move_vector = Vector2(-1, 1)

	# ======================================================
	# APPLY MOVEMENT
	# ======================================================
	if move_vector != Vector2.ZERO:
		move_vector = move_vector.normalized()

		# Apply isometric angle tuning
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

	# ======================================================
	# PUSHING
	# ======================================================
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is CharacterBody2D:
			if collider.has_method("push"):
				collider.push(-collision.get_normal())

	# ======================================================
	# ANIMATION
	# ======================================================
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

	# ======================================================
	# FOOTSTEPS
	# ======================================================
	if velocity != Vector2.ZERO:
		step_timer -= delta
	
		if step_timer <= 0:
			step_timer = step_interval
		
			if step_toggle:
				footstep_player.stream = footstep_1
			else:
				footstep_player.stream = footstep_2
		
			footstep_player.play()
			step_toggle = !step_toggle
	else:
		step_timer = 0.0
