extends Area2D

@export var grid_size = 32
@export var available_color : Color = Color.GREEN
@export var taken_color : Color = Color.RED
@export var alpha = 156
const conveyor = preload("res://conveyor.tscn")
var to_direction = Enums.Direction.Right
var from_direction = Enums.Direction.Left
var areas_entered = 0
@onready var sprite = $Sprite2D
@onready var adjacent_conveyors = $AdjacentConveyors
var initial_location
var handled_tiles = []
func determine_from_direction():
	from_direction = adjacent_conveyors.get_from_direction(to_direction)

func set_direction():
	sprite.frame = Conveyor.get_sprite_frame(to_direction, from_direction)

func _ready():
	available_color.a = alpha
	taken_color.a = alpha
	modulate = available_color

func _physics_process(_delta):
	var pos = get_global_mouse_position()
	var location = Vector2(int(pos.x/grid_size), int(pos.y/grid_size))
	if initial_location == null:
		
		global_position = location * grid_size
	if (areas_entered == 0):
		modulate = available_color
	else:
		modulate = taken_color
	if Input.is_action_just_pressed("rotate"):
		match to_direction:
			Enums.Direction.Right:
				to_direction = Enums.Direction.Down
			Enums.Direction.Down:
				to_direction = Enums.Direction.Left
			Enums.Direction.Left:
				to_direction = Enums.Direction.Up
			Enums.Direction.Up:
				to_direction = Enums.Direction.Right
	if Input.is_action_just_pressed("left click"):
		initial_location = location
	if Input.is_action_pressed("left click"):
		place(location)
	if Input.is_action_just_released("left click"):
		initial_location = null
		handled_tiles = []
	determine_from_direction()
	set_direction()

func place(location: Vector2):
	match to_direction:
		Enums.Direction.Left,Enums.Direction.Right:
			if initial_location != null:
				location.y = initial_location.y
		Enums.Direction.Up,Enums.Direction.Down:
			if initial_location != null:
				location.x = initial_location.x
	# need to check the location we are at instead
	global_position = location * grid_size
	
	for tile in handled_tiles:
		if tile == global_position:
			return
	var areas = get_overlapping_areas()
	if len(areas) == 0:
		var belt = conveyor.instantiate()
		belt.to_direction = to_direction
		belt.global_position = global_position
		get_tree().current_scene.add_child(belt)
		handled_tiles.append(global_position)
	elif len(areas) == 1:
		for area in areas:
			if not area is Conveyor:
				continue
			area.update_to_direction(to_direction)
		

func _on_area_entered(_area):
	areas_entered += 1
	
	
func _on_area_exited(_area):
	areas_entered -= 1
