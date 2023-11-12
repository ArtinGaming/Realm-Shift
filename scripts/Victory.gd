extends Control

func _on_Main_Menu_pressed():
	get_tree().change_scene("res://scenes/Main Menu.tscn")

func _on_Quit_pressed():
	get_tree().quit()
