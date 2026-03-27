extends Area2D

@export var required_id: String = "A"

var is_active = false

func _on_body_entered(body):
	if body.has_method("get_crate_id"):
		if body.get_crate_id() == required_id:
			is_active = true
			activate()

func _on_body_exited(body):
	if body.has_method("get_crate_id"):
		if body.get_crate_id() == required_id:
			is_active = false
			deactivate()

func activate():
	print("Switch ON")

func deactivate():
	print("Switch OFF")
