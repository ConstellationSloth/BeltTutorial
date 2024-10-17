extends Sprite2D

func set_sprite_frame(to: Enums.Direction, from: Enums.Direction):
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
