extends Node2D
class_name ConveyorDetectors
const CONVEYOR_DETECTOR = preload("res://Conveyors/Components/Detectors/conveyor_detector.tscn")
var directions : Array[Enums.Direction] = []
const DIRECTION_ORDER : Array[Enums.Direction] = [Enums.Direction.Left, Enums.Direction.Up, Enums.Direction.Right, Enums.Direction.Down]
const DIR_COUNT := 4
var check_direction := 0
var detectors : Dictionary = {}
var checking: bool = false
signal inventory_found

func _ready() -> void:
	establish_detectors()

func set_directions(new_directions: Array[Enums.Direction]) -> void:
	for child in get_children():
		child.queue_free()
	directions = new_directions
	detectors = {}
	establish_detectors()

func establish_detectors() -> void:
	for direction in directions:
		var instance: ConveyorDetector = CONVEYOR_DETECTOR.instantiate()
		detectors[direction] = instance
		instance.position = DirectionHelper.get_vector_for_direction(direction) * Constants.grid_size
		add_child(instance)

func _process(_delta) -> void:
	if not checking:
		return
	check_availability()

func start_checking() -> void:
	checking = true

func check_availability() -> void:
	for c in range(DIR_COUNT):
		var direction: Enums.Direction = DIRECTION_ORDER[check_direction]
		if DIR_COUNT > 1:
			check_direction += 1
			if check_direction >= DIR_COUNT:
				check_direction = check_direction % DIR_COUNT
		if not detectors.has(direction):
			continue
		var detector: ConveyorDetector = detectors[direction]
		if detector.has_space():
			checking = false
			var inventory : ConveyorInventory = detector.get_inventory()
			emit_signal("inventory_found", inventory)
			break
