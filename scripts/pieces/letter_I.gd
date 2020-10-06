extends 'res://scripts/piece.gd'

const scene_path = 'res://scenes/pieces/letter_I.tscn'

func load_options():
	qt_positions = 2
	
	positions = []
	
	positions.append([
		[color, color, color, color]
	])
	
	positions.append([
		[color],
		[color],
		[color],
		[color]
	])
