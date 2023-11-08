extends Control


func _on_Restart_pressed():
	get_tree().change_scene("res://scenes/Main Menu.tscn")
	Global.energy_bar_value = 100

func _on_Quit_pressed():
	get_tree().quit()
