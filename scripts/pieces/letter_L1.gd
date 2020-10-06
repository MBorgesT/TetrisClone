extends 'res://scripts/piece.gd'

const scene_path = 'res://scenes/pieces/letter_L1.tscn'

func load_options():
	qt_positions = 4
	
	positions = []
	
	positions.append([
		[color, null, null],
		[color, color, color]
	])
	
	positions.append([
		[color, color],
		[color, null],
		[color, null]
	])
	
	positions.append([
		[color, color, color],
		[null, null, color]
	])
	
	positions.append([
		[null, color],
		[null, color],
		[color, color]
	])
