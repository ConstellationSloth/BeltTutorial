extends Node2D
var to_directions: Array[Enums.Direction] = []
var from_direction: Enums.Direction = Enums.Direction.Right
@export var directions : Array[Enums.Direction] = []
@onready var sprite = $Sprite2D

func determine_from_direction():
	for direction in Enums.Direction.values():
		if not to_directions.has(direction):
			from_direction = direction

func _ready():
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
