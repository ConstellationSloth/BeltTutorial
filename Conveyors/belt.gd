extends Node2D
var to_direction: Enums.Direction = Enums.Direction.Left
var from_direction: Enums.Direction = Enums.Direction.Right
@export var directions : Array[Enums.Direction] = []
@onready var from_controller : FromDirectionController = $FromDirectionController
@onready var sprite = $ConveyorSpriteController

func determine_from_direction():
	from_direction = from_controller.get_from_direction(to_direction)

func set_direction():
	sprite.set_sprite_frame(to_direction, from_direction)

func _ready():
	BuildingCoordinator.add_building(global_position, self)
	$DirectionController.set_directions(directions)

func update_to_direction(to_directions: Array[Enums.Direction]):
	to_direction = to_directions[0]
	determine_from_direction()
	set_direction()
	$ConveyorDetectors.set_directions(to_directions)


func _on_conveyor_detectors_inventory_found(inventory: ConveyorInventory):
	var item = $ConveyorInventory.offload_item()
	inventory.receive_item(item)


func _on_conveyor_inventory_item_held():
	$ConveyorDetectors.start_checking()


func _on_from_direction_controller_direction_changed():
	determine_from_direction()
	set_direction()


func _on_direction_controller_directions_changed(to_directions: Array[Enums.Direction]):
	update_to_direction(to_directions)
