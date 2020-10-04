extends Node

var colors = []

func _ready():
	randomize()
	load_colors()

func get_random_color():
	return colors[randi() % colors.size()]

func load_colors():
	colors.append([255, 0, 0])
	colors.append([0, 255, 0])
	colors.append([0, 0, 255])

