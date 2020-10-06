extends Node

var colors
var pieces

var pieces_scenes

const PIECES_DIR = 'res://scripts/pieces/'
const PIECES_SCENES_DIR = 'res://scenes/pieces/'

func _ready():
	load_colors()
	load_pieces()
	load_pieces_scenes()

func get_random_color():
	randomize()
	return colors[randi() % colors.size()]

func get_random_piece():
	randomize()
	return pieces[randi() % pieces.size()].new()

func load_colors():
	colors = [
		[0, 38, 66],
		[132, 0, 50],
		[229, 149, 0],
		[229, 218, 218],
		[2, 4, 15]
	]

func load_pieces():
	pieces = []
	
	var dir = Directory.new()
	dir.change_dir(PIECES_DIR)
	dir.list_dir_begin()
	
	dir.get_next() # skip the first two that are not the files I want
	dir.get_next()
	var file = dir.get_next()
	while file != '':
		var piece = load(PIECES_DIR + file)
		if piece and piece is GDScript:
			pieces.append(piece)
		file = dir.get_next()

func load_pieces_scenes():
	pieces_scenes = []
	
	var dir = Directory.new()
	dir.change_dir(PIECES_SCENES_DIR)
	dir.list_dir_begin()
	
	dir.get_next() # skip the first two that are not the files I want
	dir.get_next()
	var file = dir.get_next()
	while file != '':
		var piece = load(PIECES_SCENES_DIR + file)
		if piece and piece is Node2D:
			pieces.append(piece)
		file = dir.get_next()
