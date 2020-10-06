extends Node2D

func _ready():
	main.connect('score_changed', self, 'set_score_label')
	set_score_label()
	
func set_score_label():
	var label = get_node('panel').get_node('score')
	label.text = str(main.get_score())
