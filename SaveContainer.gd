extends Node2D

@export var save_scene = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_from_save_data(save_data):
	var nodes = save_data["nodes"]
	
	for node in nodes:
		var loaded_scene = load(node["path"])
		var scene = loaded_scene.instantiate()
		add_child(scene)
		scene.load_from_save_data(node)
		

func get_save_data():
	var data = {}
	var nodes = []
	for child in get_children():
		nodes.append(child.get_save_data())
	data["nodes"] = nodes
	return data

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
