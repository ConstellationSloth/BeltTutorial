extends Buildable

var to_direction: Enums.Direction = Enums.Direction.Left
var from_direction: Enums.Direction = Enums.Direction.Right
var conveyor = preload("res://Conveyors/belt.tscn")

func _ready():
	var directions: Array[Enums.Direction] = [to_direction]
	$DirectionController.set_directions(directions)

func update_to_direction(to_directions: Array[Enums.Direction]):
	to_direction = to_directions[0]
	determine_from_direction()
	$ConveyorSpriteController.set_sprite_frame(to_direction, from_direction)

func rotate_clockwise():
	$DirectionController.rotate_right()

func rotate_counter():
	$DirectionController.rotate_left()

func can_place(location: Vector2):
	return !BuildingCoordinator.check_location(location)

func place(location: Vector2):
	var belt = conveyor.instantiate()
	var directions: Array[Enums.Direction] = [to_direction]
	belt.directions = directions
	belt.global_position = location
	get_tree().current_scene.add_child(belt)

func _on_from_direction_controller_direction_changed():
	determine_from_direction()
	$ConveyorSpriteController.set_sprite_frame(to_direction, from_direction)

func _on_direction_controller_directions_changed(to_directions: Array[Enums.Direction]):
	update_to_direction(to_directions)

func determine_from_direction():
	from_direction = $FromDirectionController.get_from_direction(to_direction)






