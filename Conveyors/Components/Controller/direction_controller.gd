extends Area2D
class_name DirectionController
@export var to_directions : Array[Enums.Direction] = [Enums.Direction.Left]
signal directions_changed
const DIRECTION_ORDER : Array[Enums.Direction] = [Enums.Direction.Left, Enums.Direction.Up, Enums.Direction.Right, Enums.Direction.Down]
const DIRECTION_COUNT = 4
var indexes := {Enums.Direction.Left: 0, Enums.Direction.Up: 1, Enums.Direction.Right: 2, Enums.Direction.Down: 3}

func set_directions(directions: Array[Enums.Direction]) -> void:
	to_directions = directions
	emit_signal("directions_changed", to_directions)

func get_directions() -> Array[Enums.Direction]:
	return to_directions

func rotate_right() -> void:
	rotate_belt(1)
	
func rotate_left() -> void:
	rotate_belt(-1)

func rotate_belt(offset: int) -> void:
	for idx in len(to_directions):
		var direction: int = to_directions[idx]
		var index: int = indexes[direction] + offset
		if index < 0:
			index = index % DIRECTION_COUNT + DIRECTION_COUNT
		elif index > DIRECTION_COUNT:
			index = index % DIRECTION_COUNT
		to_directions[idx] = DIRECTION_ORDER[index]
	emit_signal("directions_changed", to_directions)
