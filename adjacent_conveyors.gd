extends Node2D
const DIRECTION_DETECTOR = preload("res://direction_detector.tscn")
var right
var left
var down 
var up
var length = 32
signal conveyor_change
var directions := {}

func _ready():
	for direction in Enums.Direction.values():
		var detector = DIRECTION_DETECTOR.instantiate()
		detector.position = DirectionHelper.get_vector_for_direction(direction) * length
		detector.connect("conveyor_changed", emit_change)
		add_child(detector)
		directions[direction] = detector 
		

func emit_change():
	emit_signal("conveyor_change")

func get_from_direction(to_direction: Enums.Direction):
	var right_conveyor = get_direction(Enums.Direction.Right)
	var left_conveyor = get_direction(Enums.Direction.Left)
	var down_conveyor = get_direction(Enums.Direction.Down)
	var up_conveyor = get_direction(Enums.Direction.Up)
	var from_direction: Enums.Direction = Enums.Direction.Left
	match to_direction:
		Enums.Direction.Left:
			if right_conveyor != null and right_conveyor == Enums.Direction.Left:
				from_direction = Enums.Direction.Right
			elif up_conveyor != null and up_conveyor == Enums.Direction.Down:
				if down_conveyor != null and down_conveyor == Enums.Direction.Up:
					from_direction = Enums.Direction.Right
				else:
					from_direction = Enums.Direction.Up
			elif down_conveyor != null and down_conveyor == Enums.Direction.Up:
				from_direction = Enums.Direction.Down
			else:
				from_direction = Enums.Direction.Right
		Enums.Direction.Right:
			if left_conveyor != null and left_conveyor == Enums.Direction.Right:
				from_direction = Enums.Direction.Left
			elif up_conveyor != null and up_conveyor == Enums.Direction.Down:
				if down_conveyor != null and down_conveyor == Enums.Direction.Up:
					from_direction = Enums.Direction.Left
				else:
					from_direction = Enums.Direction.Up
			elif down_conveyor != null and down_conveyor == Enums.Direction.Up:
				from_direction = Enums.Direction.Down
			else:
				from_direction = Enums.Direction.Left
		Enums.Direction.Up:
			if down_conveyor != null and down_conveyor == Enums.Direction.Up:
				from_direction = Enums.Direction.Down 
			elif right_conveyor != null and right_conveyor == Enums.Direction.Left:
				if left_conveyor != null and left_conveyor == Enums.Direction.Right:
					from_direction = Enums.Direction.Down
				else:
					from_direction = Enums.Direction.Right
			elif left_conveyor != null and left_conveyor == Enums.Direction.Right:
				from_direction = Enums.Direction.Left
			else:
				from_direction = Enums.Direction.Down
		Enums.Direction.Down:
			if up_conveyor != null and up_conveyor == Enums.Direction.Down:
				from_direction = Enums.Direction.Up
			elif right_conveyor != null and right_conveyor == Enums.Direction.Left:
				if left_conveyor != null and left_conveyor == Enums.Direction.Right:
					from_direction = Enums.Direction.Up
				else:
					from_direction = Enums.Direction.Right
			elif left_conveyor != null and left_conveyor == Enums.Direction.Right:
				from_direction = Enums.Direction.Left
			else:
				from_direction = Enums.Direction.Up
	return from_direction

func get_direction(direction: Enums.Direction):
	var detector = directions[direction]
	if detector == null:
		return null
	if detector.conveyor == null:
		return null
	return detector.conveyor.get_direction()

