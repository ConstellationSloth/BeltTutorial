extends Area2D
class_name DirectionDetector
signal directions_changed
var direction_controller: DirectionController

func get_directions() -> Array[Enums.Direction]:
	if direction_controller == null:
		return []
	return direction_controller.get_directions()

func emit_directions_changed() -> void:
	emit_signal("directions_changed")

func _on_area_entered(area: Area2D) -> void:
	if area is DirectionController:
		direction_controller = area
		if not direction_controller.is_connected("directions_changed", emit_directions_changed):
			direction_controller.connect("directions_changed", emit_directions_changed)
		emit_directions_changed()

func _on_area_exited(area: Area2D) -> void:
	if area is DirectionController:
		if direction_controller == area:
			if direction_controller.is_connected("directions_changed", emit_directions_changed):
				direction_controller.disconnect("directions_changed", emit_directions_changed)
			direction_controller = null
			emit_directions_changed()


