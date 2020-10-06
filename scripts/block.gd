extends Node2D

func _ready():
	pass 
	
func set_color(color):
	get_node('sprite').modulate = Color(color[0], color[1], color[2], .8)
	pass
