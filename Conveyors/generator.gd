extends Node2D

@onready var box_path = preload("res://box.tscn")
@onready var timer: Timer = $Timer
@export var directions : Array[Enums.Direction] = []

func _ready():
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
