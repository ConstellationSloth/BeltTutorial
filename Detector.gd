extends Area2D
class_name Detector
signal belt_detected
var detecting = false

func detect():
	detecting = true

func _physics_process(_delta):
	if not detecting:
		return
	var areas = get_overlapping_areas()
	for area in areas:
		if not area is Transportable:
			continue
		if area.can_receive_item():
			emit_signal("belt_detected", area)
			detecting = false
			break
