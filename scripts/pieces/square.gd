extends 'res://scripts/piece.gd'

const scene_path = 'res://scenes/pieces/square.tscn'

func load_options():
	qt_positions = 1
	
	positions = []
	
	positions.append([
		[color, color],
		[color, color]
	])
