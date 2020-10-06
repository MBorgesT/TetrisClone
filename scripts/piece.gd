extends Node

var positions
var qt_positions
var current_position
var color setget , get_color
var matrix setget , get_matrix
var coord setget set_coord, get_coord # top left pixel/coordinate

func _init():
	randomize()
	
	color = resources.get_random_color()
	
	load_options()
	matrix = positions[0]
	current_position = 0
	
	coord = [1, 3]

func load_options():
	pass

func set_coord(value):
	coord = value

func get_coord():
	return coord

func get_matrix():
	return matrix

func get_next_position(direction):
	if direction == main.LEFT:
		return positions[(current_position + 1) % qt_positions]
	elif direction == main.RIGHT:
		var next_pos = current_position - 1
		if next_pos < 0: next_pos = qt_positions - 1
		return positions[next_pos]

func move_x_axis(direction):
	if direction == main.LEFT:
		coord[1] = max(0, coord[1] - 1)
	elif direction == main.RIGHT:
		coord[1] = min(main.FIELD_WIDTH - matrix[0].size(), coord[1] + 1)

func move_down():
	coord[0] += 1

func rotate(direction):
	# rotation
	if direction == main.LEFT:
		current_position = (current_position + 1) % qt_positions
		matrix = positions[current_position]
	elif direction == main.RIGHT:
		current_position = current_position - 1
		if current_position < 0:
			current_position = qt_positions - 1
		matrix = positions[current_position]

func get_color():
	return color
