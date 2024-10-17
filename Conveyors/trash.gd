extends Node2D

func _ready():
	BuildingCoordinator.add_building(global_position,self)

func _on_conveyor_inventory_item_held():
	$ConveyorInventory.offload_item().queue_free()
