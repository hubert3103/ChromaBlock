extends Control

@export var toggle_action := "reset"
@export var delay := 3.0   # seconds before reset is allowed



var can_open := false

func _ready():
	visible = false
	
	# delay before reset is allowed
	await get_tree().create_timer(delay).timeout
	can_open = true


func _input(event):
	if not can_open:
		return
		
	if event.is_action_pressed(toggle_action):
		visible = true
		$RestartButton.grab_focus()
		get_tree().paused = true


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_cancel_button_pressed():
	visible = false
	get_tree().paused = false
	
	
	
	
