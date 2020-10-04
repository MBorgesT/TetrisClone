extends Node

var piece_type
var color
var matrix setget , get_matrix
var top_left_coord setget set_coord, get_coord

func _init():
	randomize()
	
	color = resources.get_random_color()
	top_left_coord = [1, 3]
	set_random_piece()

func set_random_piece():
	var aux = randi() % 7
	piece_type = aux
	
	if aux == 0:
		matrix = [
			[null, null, null, null],
			[null, null, null, null],
			[color, color, color, color],
			[null, null, null, null]
		]
	elif aux == 1:
		matrix = [
			[null, null, null, null],
			[color, null, null, null],
			[color, color, color, null],
			[null, null, null, null]
		]
	elif aux == 2:
		matrix = [
			[null, null, null, null],
			[null, null, color, null],
			[color, color, color, null],
			[null, null, null, null]
		]
	elif aux == 3:
		matrix = [
			[null, null, null, null],
			[color, color, null, null],
			[null, color, color, null],
			[null, null, null, null]
		]
	elif aux == 4:
		matrix = [
			[null, null, null, null],
			[null, color, color, null],
			[color, color, null, null],
			[null, null, null, null]
		]
	elif aux == 5:
		matrix = [
			[null, null, null, null],
			[null, color, null, null],
			[color, color, color, null],
			[null, null, null, null]
		]
	elif aux == 6:
		matrix = [
			[null, null, null, null],
			[null, color, color, null],
			[null, color, color, null],
			[null, null, null, null]
		]

func set_coord(value):
	top_left_coord = value

func get_coord():
	return top_left_coord

func get_matrix():
	return matrix
	

func rotate(direction):
	var new_matrix = [
			[null, null, null, null],
			[null, null, null, null],
			[null, null, null, null],
			[null, null, null, null]
	]
	
	if direction == main.LEFT:
		for i in matrix.size():
			for j in matrix[i].size():
				new_matrix[(matrix.size()-1)-j][i] = matrix[i][j]
	elif direction == main.RIGHT:
		for i in matrix.size():
			for j in matrix[i].size():
				new_matrix[j][i] = matrix[i][j]
	
	matrix = new_matrix
