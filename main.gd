extends Node2D

var save_path = "user://data.save"

func _ready():
	load_save_data()
	pass

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var save_data = $SavedNodes.get_save_data()
	file.store_string(JSON.stringify(save_data))

func load_save_data():
	if FileAccess.file_exists(save_path):
		print("loading save data")
		var file = FileAccess.open(save_path, FileAccess.READ)
		var save_data = JSON.parse_string(file.get_as_text())
		$SavedNodes.load_from_save_data(save_data)
	else:
		print("there was no save data to load")


func _on_save_pressed():
	save()

func _on_check_pressed():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var save_data = JSON.parse_string(file.get_as_text())
		print("checking save data")
		print(JSON.stringify(save_data))
	else:
		print("no save data")
