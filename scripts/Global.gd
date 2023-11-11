extends Node

onready var energy_bar_value = 100

var musicProgress = 0.0

var stage = 1

var no_tutorial = null 

var is_fullscreen = false

func set_data(st, nt):
	stage = st
	no_tutorial = nt

func _physics_process(delta):
	fullscreen()
	
func fullscreen():
	if Input.is_action_just_pressed("fullscreen") and is_fullscreen == false:
		is_fullscreen = true
		
	elif Input.is_action_just_pressed("fullscreen") and is_fullscreen == true:
		is_fullscreen = false
		
	if is_fullscreen == true:
		OS.window_fullscreen = true
		
	elif is_fullscreen == false:
		OS.window_fullscreen = false
