extends CharacterBody2D

@export var crate_id: String = "A"

func _physics_process(delta):
	# Slowly stop movement (friction)
	velocity = velocity.move_toward(Vector2.ZERO, 500 * delta)
	move_and_slide()

func get_crate_id():
	return crate_id
