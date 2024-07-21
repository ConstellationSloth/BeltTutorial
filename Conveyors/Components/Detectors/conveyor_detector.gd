extends Area2D
class_name ConveyorDetector

var conveyor_inventory: ConveyorInventory

func has_space() -> bool:
	if conveyor_inventory == null:
		return false
	return conveyor_inventory.can_receive_item()

func get_inventory() -> ConveyorInventory:
	return conveyor_inventory

func _on_area_entered(area: Area2D) -> void:
	if area is ConveyorInventory:
		conveyor_inventory = area


func _on_area_exited(area: Area2D) -> void:
	if area is ConveyorInventory and area == conveyor_inventory:
		conveyor_inventory = null
