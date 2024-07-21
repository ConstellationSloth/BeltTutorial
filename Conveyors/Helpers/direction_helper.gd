extends Node
class_name DirectionHelper


static func get_vector_for_direction(direction: Enums.Direction):
	match direction:
		Enums.Direction.Right:
			return Vector2.RIGHT
		Enums.Direction.Left:
			return Vector2.LEFT
		Enums.Direction.Up:
			return Vector2.UP
		Enums.Direction.Down:
			return Vector2.DOWN
