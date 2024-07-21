extends Area2D
class_name ConveyorInventory
var moving_item = false
@export var speed: int = 50
signal item_held

var holder: Node2D
func _ready():
	holder = Node2D.new()
	add_child(holder)

func can_receive_item():
	return holder.get_child_count() == 0

func generate_item(item: Node2D):
	holder.add_child(item)
	moving_item = true

func receive_item(item: Node2D):
	item.reparent(holder, true)
	moving_item = true

func offload_item():
	var item = holder.get_child(0)
	return item

func hold_item():
	moving_item = false
	emit_signal("item_held")

func _physics_process(delta):
	if not moving_item or holder.get_child_count() == 0:
		return
	var item = holder.get_child(0)
	if item is Node2D:
		item.global_position = item.global_position.move_toward(global_position, speed * delta)
		if item.global_position == global_position:
			hold_item()

