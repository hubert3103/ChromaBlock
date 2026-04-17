extends CharacterBody2D

@export var crate_id: String = "A"
@export var diagonal_angle := 26.565

@export var move_distance := 70.0
@export var move_speed := 75.0

var is_moving := false
var push_locked := false

var start_position := Vector2.ZERO
var target_position := Vector2.ZERO

var locked_raw_dir := Vector2.ZERO

@onready var push_sound = $PushSound
@onready var sprite = $Sprite2D

@export var sprite1: Texture
@export var sprite2: Texture
@export var sprite3: Texture
@export var sprite4: Texture
@export var sprite5: Texture
@export var sprite6: Texture 

var current_sprite := 1


func _ready():
	set_sprite(1)


func _physics_process(delta):
	if is_moving:
		var direction = (target_position - global_position)

		if direction.length() < 1:
			global_position = target_position
			is_moving = false
			push_locked = false
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
	if is_moving or push_locked:
		return

	push_locked = true

	var raw_dir = direction.normalized()
	locked_raw_dir = raw_dir

	# Only allow diagonal pushes
	if raw_dir.x == 0 or raw_dir.y == 0:
		push_locked = false
		return

	# --- MOVEMENT DIRECTION ---
	var dir = raw_dir
	var angle = deg_to_rad(diagonal_angle)
	dir.x = cos(angle) * sign(raw_dir.x)
	dir.y = sin(angle) * sign(raw_dir.y)
	dir = dir.normalized()

	# --- USE LOCKED INPUT (CRITICAL FIX) ---
	var is_vertical = abs(locked_raw_dir.y) > abs(locked_raw_dir.x)

	# --- STATE MACHINE (6 STATES) ---
	if is_vertical:
		match current_sprite:
			1: set_sprite(2)
			2: set_sprite(1)
			3: set_sprite(5)
			4: set_sprite(6)
			5: set_sprite(3)
			6: set_sprite(4)
	else:
		match current_sprite:
			1: set_sprite(4)
			2: set_sprite(3)
			3: set_sprite(2)
			4: set_sprite(1)
			5: set_sprite(6)
			6: set_sprite(5)

	start_position = global_position
	target_position = start_position + dir * move_distance

	is_moving = true


func set_sprite(index: int):
	current_sprite = index

	match index:
		1: sprite.texture = sprite1
		2: sprite.texture = sprite2
		3: sprite.texture = sprite3
		4: sprite.texture = sprite4
		5: sprite.texture = sprite5
		6: sprite.texture = sprite6


func get_crate_id():
	return crate_id
