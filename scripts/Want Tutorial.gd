extends Control

func _ready():
	Global.no_tutorial = true
	Saver.save_data(Global.stage, Global.no_tutorial)
	
func _on_Yes_pressed():
	get_tree().change_scene("res://scenes/Tutorial.tscn")

func _on_No_pressed():
	get_tree().change_scene("res://scenes/Level 01.tscn")
