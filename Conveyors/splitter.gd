extends Node2D
var to_directions: Array[Enums.Direction] = []
var from_direction: Enums.Direction = Enums.Direction.Right
@export var directions : Array[Enums.Direction] = []
@onready var sprite = $Sprite2D

func get_save_data():
	var data = {}
	data["path"] = "res://Conveyors/splitter.tscn"
	data["directions"] = directions
	data["global_position"] = {"x": global_position.x, "y": global_position.y}
	# get the data for the conveyor inventory
	return data

func load_from_save_data(save_data):
	var gp_obj = save_data["global_position"]
	global_position = Vector2(gp_obj["x"], gp_obj["y"])
	#do something with conveyor inventory
	var new_directions: Array[Enums.Direction] = []
	for direction in save_data["directions"]:
		new_directions.append(direction as Enums.Direction)
	update_to_direction(new_directions)

func determine_from_direction():
	for direction in Enums.Direction.values():
		if not to_directions.has(direction):
			from_direction = direction

func _ready():
	BuildingCoordinator.add_building(global_position, self)
	$DirectionController.set_directions(directions)

func update_to_direction(new_directions: Array[Enums.Direction]):
	to_directions = new_directions
	determine_from_direction()
	$ConveyorDetectors.set_directions(new_directions)


func _on_conveyor_detectors_inventory_found(inventory: ConveyorInventory):
	var item = $ConveyorInventory.offload_item()
	inventory.receive_item(item)


func _on_conveyor_inventory_item_held():
	$ConveyorDetectors.start_checking()


func _on_direction_controller_directions_changed(new_directions: Array[Enums.Direction]):
	update_to_direction(new_directions)
