extends Node2D

@onready var box_path = preload("res://box.tscn")
@onready var timer: Timer = $Timer
@export var directions : Array[Enums.Direction] = []

func get_save_data():
	var data = {}
	data["path"] = "res://Conveyors/generator.tscn"
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
	directions = new_directions
	$DirectionController.set_directions(directions)

func _ready():
	BuildingCoordinator.add_building(global_position, self)
	$DirectionController.set_directions(directions)
	

func _on_conveyor_detectors_inventory_found(inventory: ConveyorInventory):
	var item = $ConveyorInventory.offload_item()
	inventory.receive_item(item)
	timer.start()


func _on_timer_timeout():
	var box = box_path.instantiate()
	$ConveyorInventory.generate_item(box)
	$ConveyorDetectors.start_checking()


func _on_direction_controller_directions_changed(to_directions):
	$ConveyorDetectors.set_directions(to_directions)
