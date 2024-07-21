extends Area2D

signal conveyor_changed
var conveyor: 
	set(new_value):
		conveyor = new_value
		emit_signal("conveyor_changed")
	get:
		return conveyor

func direction_changed():
	emit_signal("conveyor_changed")

func _on_area_entered(area):
	if area is Transportable:
		conveyor = area
		if area is Conveyor and not conveyor.is_connected("direction_changed", direction_changed):
			conveyor.connect("direction_changed", direction_changed)

func _on_area_exited(area):
	if area is Transportable:
		if conveyor == area:
			if conveyor is Conveyor and conveyor.is_connected("direction_changed", direction_changed):
				conveyor.disconnect("direction_changed", direction_changed)
			conveyor = null
			
