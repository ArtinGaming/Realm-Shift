extends Control

func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Want Tutorial.tscn")

func _on_Settings_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
