extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "fps: " + str(Engine.get_frames_per_second())
