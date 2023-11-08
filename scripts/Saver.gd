extends Node

static func check_file():
	var file = File.new()
	if file.file_exists("user://save_data.dat"):
		return true
	else:
		return false

static func save_data(stage):
	var save_content = {
		"stage":stage
	}
	Global.set_data(stage)
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
		file.close()
		return content
	else:
		save_data(1)
