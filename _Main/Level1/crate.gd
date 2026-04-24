extends CharacterBody2D

@export var crate_id: String = "A"
@export var diagonal_angle := 26.565

@export var move_distance := 70.0   # 👈 how far it moves per push
@export var move_speed := 75.0     # 👈 how fast it moves (lower = slower)

var is_moving := false
var start_position := Vector2.ZERO
var target_position := Vector2.ZERO
@onready var push_sound = $PushSound

func _physics_process(delta):
	if is_moving:
		var direction = (target_position - global_position)
		
		if direction.length() < 1:
			global_position = target_position
			is_moving = false
		else:
			var movement = direction.normalized() * move_speed * delta
			move_and_collide(movement)
		
			# --- PUSH SOUND ---
	if velocity.length() > 5:
		if not push_sound.playing:
			push_sound.play()
	else:
		if push_sound.playing:
			push_sound.stop()

func push(direction: Vector2):
	if is_moving:
		return

	var dir = direction.normalized()

	var sign_x = sign(dir.x)
	var sign_y = sign(dir.y)

	# Only allow diagonal pushes
	if sign_x == 0 or sign_y == 0:
		return

	# Apply your angle
	var angle = deg_to_rad(diagonal_angle)
	dir.x = cos(angle) * sign_x
	dir.y = sin(angle) * sign_y
	dir = dir.normalized()

	start_position = global_position
	target_position = start_position + dir * move_distance

	is_moving = true


func get_crate_id():
	return crate_id
