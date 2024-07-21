extends Node2D


func _on_conveyor_inventory_item_held():
	$ConveyorInventory.offload_item().queue_free()
