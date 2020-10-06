extends 'res://scripts/piece.gd'

const scene_path = 'res://scenes/pieces/letter_L2.tscn'

func load_options():
	qt_positions = 4
	
	positions = []
	
	positions.append([
		[null, null, color],
		[color, color, color]
	])
	
	positions.append([
		[color, null],
		[color, null],
		[color, color]
	])
	
	positions.append([
		[color, color, color],
		[color, null, null]
	])
	
	positions.append([
		[color, color],
		[null, color],
		[null, color]
	])
