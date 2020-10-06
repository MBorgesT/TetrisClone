extends 'res://scripts/piece.gd'

const scene_path = 'res://scenes/pieces/letter_S1.tscn'

func load_options():
	qt_positions = 2
	
	positions = []
	
	positions.append([
		[color, color, null],
		[null, color, color]
	])
	
	positions.append([
		[null, color],
		[color, color],
		[color, null]
	])
