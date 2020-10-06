extends Node2D

const pos = [105, 85] # x and y

func _init():
	main.connect('next_piece', self, 'set_next_piece')

func set_next_piece():
	var old_piece = get_node('panel').get_node('piece')
	old_piece.set_name('deleted')
	old_piece.queue_free()
	
	var next_piece = main.get_next_piece()
	var next_piece_scene = load(next_piece.scene_path).instance()
	var color = next_piece.get_color()
	
	next_piece_scene.modulate = Color(color[0], color[1], color[2], 0.2)
	next_piece_scene.set_position(Vector2(pos[0], pos[1]))
	next_piece_scene.set_name('piece')
	
	var panel = get_node('panel')
	panel.add_child(next_piece_scene, true)
