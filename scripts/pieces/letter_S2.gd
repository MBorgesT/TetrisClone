extends 'res://scripts/piece.gd'

const scene_path = 'res://scenes/pieces/letter_S2.tscn'

func load_options():
	qt_positions = 2
	
	positions = []
	
	positions.append([
		[null, color, color],
		[color, color, null]
	])
	
	positions.append([
		[color, null],
		[color, color],
		[null, color]
	])
