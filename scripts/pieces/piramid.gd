extends 'res://scripts/piece.gd'

const scene_path = 'res://scenes/pieces/piramid.tscn'

func load_options():
	qt_positions = 4
	
	positions = []
	
	positions.append([
		[null, color, null],
		[color, color, color]
	])
	
	positions.append([
		[color, null],
		[color, color],
		[color, null]
	])
	
	positions.append([
		[color, color, color],
		[null, color, null]
	])
	
	positions.append([
		[null, color],
		[color, color],
		[null, color]
	])
