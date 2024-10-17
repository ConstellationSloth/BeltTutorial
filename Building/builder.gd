extends Node2D
@export var available_color : Color = Color.GREEN
@export var taken_color : Color = Color.RED
@export var alpha = 128
@onready var building : Buildable = $BuildableConveyor
var last_location

func _ready():
	available_color.a = alpha
	taken_color.a = alpha
	modulate = available_color

func _physics_process(_delta):
	var pos = get_global_mouse_position()
	var location = Vector2(int(pos.x/Constants.grid_size), int(pos.y/Constants.grid_size)) * Constants.grid_size
	if last_location == location:
		return
	global_position = location
	if building.can_place(location):
		modulate = available_color
	else:
		modulate = taken_color
	if last_location == null:
		last_location = location
	if Input.is_action_just_pressed("rotate"):
		building.rotate_clockwise()
	if Input.is_action_pressed("left click"):
		if building.can_place(location):
			building.place(location)
