extends Node2D

signal switched_on
signal switched_off

@export var door: Node2D
var player_in_range = false
var is_on = false

func _ready():
	switched_on.connect(_on_switched_on)
	switched_off.connect(_on_switched_off)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		toggle()

func toggle():
	is_on = !is_on

	if is_on:
		if has_node("AnimationPlayer"):
			$AnimationPlayer.play("switch_on")
		emit_signal("switched_on")
	else:
		if has_node("AnimationPlayer"):
			$AnimationPlayer.play("switch_off")
		emit_signal("switched_off")

func _on_switched_on():
	if door and door.has_method("open"):
		door.open()

func _on_switched_off():
	if door and door.has_method("close"):
		door.close()
