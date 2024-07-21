extends Node2D
class_name FromDirectionController
const DIRECTION_DETECTOR = preload("res://Conveyors/Components/Detectors/direction_detector.tscn")
signal direction_changed
var directions := {}

func _ready():
	for direction in Enums.Direction.values():
		var detector = DIRECTION_DETECTOR.instantiate()
		detector.position = DirectionHelper.get_vector_for_direction(direction) * Constants.grid_size
		detector.connect("directions_changed", emit_change)
		add_child(detector)
		directions[direction] = detector 
		

func emit_change():
	emit_signal("direction_changed")

func get_from_direction(to_direction: Enums.Direction):
	var right = get_directions(Enums.Direction.Right)
	var left = get_directions(Enums.Direction.Left)
	var down = get_directions(Enums.Direction.Down)
	var up = get_directions(Enums.Direction.Up)
	var from_direction: Enums.Direction = Enums.Direction.Left
	match to_direction:
		Enums.Direction.Left:
			if len(right) > 0 and right.has(Enums.Direction.Left):
				from_direction = Enums.Direction.Right
			elif len(up) > 0 and up.has(Enums.Direction.Down):
				if len(down) > 0 and down.has(Enums.Direction.Up):
					from_direction = Enums.Direction.Right
				else:
					from_direction = Enums.Direction.Up
			if len(down) > 0 and down.has(Enums.Direction.Up):
				from_direction = Enums.Direction.Down
			else:
				from_direction = Enums.Direction.Right
		Enums.Direction.Right:
			if len(left) > 0 and left.has(Enums.Direction.Right):
				from_direction = Enums.Direction.Left
			elif len(up) > 0 and up.has(Enums.Direction.Down):
				if len(down) > 0 and down.has(Enums.Direction.Up):
					from_direction = Enums.Direction.Left
				else:
					from_direction = Enums.Direction.Up
			if len(down) > 0 and down.has(Enums.Direction.Up):
				from_direction = Enums.Direction.Down
			else:
				from_direction = Enums.Direction.Left
		Enums.Direction.Up:
			if len(down) > 0 and down.has(Enums.Direction.Up):
				from_direction = Enums.Direction.Down 
			elif len(right) > 0 and right.has(Enums.Direction.Left):
				if len(left) > 0 and left.has(Enums.Direction.Right):
					from_direction = Enums.Direction.Down
				else:
					from_direction = Enums.Direction.Right
			elif len(left) > 0 and left.has(Enums.Direction.Right):
				from_direction = Enums.Direction.Left
			else:
				from_direction = Enums.Direction.Down
		Enums.Direction.Down:
			if len(up) > 0 and up.has(Enums.Direction.Down):
				from_direction = Enums.Direction.Up
			elif len(right) > 0 and right.has(Enums.Direction.Left):
				if len(left) > 0 and left.has(Enums.Direction.Right):
					from_direction = Enums.Direction.Up
				else:
					from_direction = Enums.Direction.Right
			elif len(left) > 0 and left.has(Enums.Direction.Right):
				from_direction = Enums.Direction.Left
			else:
				from_direction = Enums.Direction.Up
	return from_direction

func get_directions(direction: Enums.Direction) -> Array[Enums.Direction]:
	var detector : DirectionDetector = directions[direction]
	if detector == null:
		return []
	return detector.get_directions()
