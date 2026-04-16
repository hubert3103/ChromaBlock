extends CharacterBody2D

@export var crate_id: String = "A"
@export var diagonal_angle := 26.565

@export var move_distance := 70.0
@export var move_speed := 75.0

var is_moving := false
var start_position := Vector2.ZERO
var target_position := Vector2.ZERO

@onready var push_sound = $PushSound
@onready var sprite = $Sprite2D

@export var sprite1: Texture
@export var sprite2: Texture
@export var sprite3: Texture
@export var sprite4: Texture

var vertical_state := 1
var horizontal_state := 1


func _ready():
	if sprite1:
		sprite.texture = sprite1


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
	if is_moving:
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

	# --- DETECT PUSH TYPE ---

	# Vertical push (up/down)
	if abs(direction.y) > abs(direction.x):
		vertical_state = 3 - vertical_state  # toggle 1 ↔ 2
		
		if vertical_state == 1:
			sprite.texture = sprite1
		else:
			sprite.texture = sprite2

	# Horizontal push (left/right)
	else:
		horizontal_state = 3 - horizontal_state  # toggle 1 ↔ 2
		
		if horizontal_state == 1:
			sprite.texture = sprite3
		else:
			sprite.texture = sprite4

	start_position = global_position
	target_position = start_position + dir * move_distance

	is_moving = true


func get_crate_id():
	return crate_id
