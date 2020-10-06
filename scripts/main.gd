extends Node

const RIGHT = 1
const LEFT = -1

const FIELD_WIDTH = 10
const FIELD_HEIGHT = 18
const SPAWN_AREA_HEIGHT = 4

const SCORE_PER_PIECE = 5

var current_piece setget , get_current_piece
var next_piece setget , get_next_piece

var score setget set_score, get_score

signal next_piece

signal score_changed

func _ready():
	randomize()
	
	current_piece = resources.get_random_piece()
	next_piece = resources.get_random_piece()
	emit_signal('next_piece')
	
	score = 0

func next_piece():
	current_piece = next_piece
	next_piece = resources.get_random_piece()
	emit_signal('next_piece')

func get_current_piece():
	return current_piece

func get_next_piece():
	return next_piece

func get_score():
	return score

func set_score(value):
	score = value

func add_to_score(value):
	score += value
	emit_signal('score_changed')
