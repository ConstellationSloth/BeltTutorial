extends Node2D

func get_save_data():
	var data = {}
	data["path"] = "res://Conveyors/trash.tscn"
	data["global_position"] = {"x": global_position.x, "y": global_position.y}
	return data

func load_from_save_data(save_data):
	var gp_obj = save_data["global_position"]
	global_position = Vector2(gp_obj["x"], gp_obj["y"])
func _ready():
	BuildingCoordinator.add_building(global_position,self)

func _on_conveyor_inventory_item_held():
	$ConveyorInventory.offload_item().queue_free()
