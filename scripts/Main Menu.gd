extends Control

var master_sound = AudioServer.get_bus_index("Master")

func _on_Play_pressed():
	if Global.no_tutorial == true:
		Saver.load_data()
		get_tree().change_scene("res://scenes/Level 0" + str(Global.stage) +".tscn")
		
	else:
		get_tree().change_scene("res://scenes/Want Tutorial.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Mute_pressed():
	$Mute.disabled = true
	$Mute.hide()
	$Unmute.show()
	$Unmute.disabled = false
	AudioServer.set_bus_mute(master_sound, true)

func _on_Unmute_pressed():
	$Mute.disabled = false
	$Mute.show()
	$Unmute.hide()
	$Unmute.disabled = true
	AudioServer.set_bus_mute(master_sound, false)
