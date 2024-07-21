extends Node


var buildings = {}

func check_location(location: Vector2) -> bool:
	return buildings.has(location)

func add_building(location: Vector2, building: Node2D) -> void:
	buildings[location] = building
