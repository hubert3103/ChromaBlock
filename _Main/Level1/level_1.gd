extends Node2D

@export var hud_display_time := 2.0  # seconds

func _ready():
	# Position player at start
	$Player.position = $StartPosition.position
	
	# Show the StartHUD
	$StartHUD.visible = true
	
	# Wait for display_time seconds, then hide it
	await get_tree().create_timer(hud_display_time).timeout
	$StartHUD.visible = false
