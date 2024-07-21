extends Transportable
class_name Conveyor   
@onready var item_holder = $ItemHolder
@onready var detector = $Detector
@export var to_direction: Enums.Direction = Enums.Direction.Left
@export var from_direction: Enums.Direction = Enums.Direction.Right
@onready var sprite = $Sprite2D
@onready var adjacent_conveyors = $AdjacentConveyors
signal direction_changed

func get_direction():
	return to_direction

func determine_from_direction():
	from_direction = adjacent_conveyors.get_from_direction(to_direction)

func set_direction():
	sprite.frame = Conveyor.get_sprite_frame(to_direction, from_direction)
	match to_direction:
		Enums.Direction.Left:
			detector.position = Vector2.LEFT * 32
		Enums.Direction.Right:
			detector.position = Vector2.RIGHT * 32
		Enums.Direction.Up:
			detector.position = Vector2.UP * 32
		Enums.Direction.Down:
			detector.position = Vector2.DOWN * 32
			

static func get_sprite_frame(to: Enums.Direction, from: Enums.Direction):
	var frame = 0
	match to:
		Enums.Direction.Left:
			match from:
				Enums.Direction.Right:
					frame = 1
				Enums.Direction.Up:
					frame = 9
				Enums.Direction.Down:
					frame = 2
		Enums.Direction.Right:
			match from:
				Enums.Direction.Left:
					frame = 11
				Enums.Direction.Up:
					frame = 10
				Enums.Direction.Down:
					frame = 3
		Enums.Direction.Up:
			match from:
				Enums.Direction.Left:
					frame = 12
				Enums.Direction.Down:
					frame = 7
				Enums.Direction.Right:
					frame = 8
		Enums.Direction.Down:
			match from:
				Enums.Direction.Left:
					frame = 4
				Enums.Direction.Up:
					frame = 5
				Enums.Direction.Right:
					frame = 0
	return frame

func _ready():
	determine_from_direction()
	set_direction()

func update_to_direction(to: Enums.Direction):
	to_direction = to
	determine_from_direction()
	set_direction()
	emit_signal("direction_changed")

func can_receive_item():
	return item_holder.get_child_count() == 0

func receive_item(item: Node2D):
	item_holder.receive_item(item)

func _on_detector_belt_detected(area: Area2D):
	var item = item_holder.offload_item()
	area.receive_item(item)


func _on_item_holder_item_held():
	detector.detect()



func _on_adjacent_conveyors_conveyor_change():
	determine_from_direction()
	set_direction()
