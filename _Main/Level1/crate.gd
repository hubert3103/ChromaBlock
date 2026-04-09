extends CharacterBody2D

@export var crate_id: String = "A"
@onready var push_sound = $PushSound

func _physics_process(delta):
	# Slowly stop movement (friction)
	velocity = velocity.move_toward(Vector2.ZERO, 500 * delta)
	move_and_slide()
	
	# --- PUSH SOUND ---
	if velocity.length() > 5:
		if not push_sound.playing:
			push_sound.play()
	else:
		if push_sound.playing:
			push_sound.stop()

func get_crate_id():
	return crate_id
