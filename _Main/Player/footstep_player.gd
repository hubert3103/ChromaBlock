extends AudioStreamPlayer2D

@onready var footstep_player = $FootstepPlayer

@export var footstep_1: AudioStream
@export var footstep_2: AudioStream

var step_toggle = false
var step_timer = 0.0
@export var step_interval = 0.3
