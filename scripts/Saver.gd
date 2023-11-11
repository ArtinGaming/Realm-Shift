extends Node

static func check_file():
	var file = File.new()
	if file.file_exists("user://save_data.dat"):
		return true
	else:
		return false

static func save_data(stage, no_tutorial):
	var save_content = {
		"stage":stage,
		"no_tutorial": no_tutorial
	}
	Global.set_data(stage, no_tutorial)
	var file = File.new()
	file.open("user://save_data.dat", File.WRITE)
	file.store_line(to_json(save_content))
	file.close()
	
static func load_data():
	var file = File.new()
	if file.file_exists("user://save_data.dat"):
		file.open("user://save_data.dat", File.READ)
		var content = parse_json(file.get_line())
		for i in content.keys():
			if i == "stage":
				Global.stage = content.get(i)
			elif i == "want_tutorial":
				Global.no_tutorial = content.get(i)
		file.close()
		return content
	else:
		save_data(1, null)
