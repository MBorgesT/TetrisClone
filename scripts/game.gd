extends Node

var current_piece
var next_piece

var pre_piece = preload('res://scripts/pieces/piece.gd')

func _ready():
	randomize()
	
	set_process(true)
	
	current_piece = pre_piece.instance()
	next_piece = pre_piece.instance()

func _process(delta):
	pass

func _on_next_step_timeout():
	pass
