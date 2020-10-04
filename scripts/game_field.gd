extends Node2D

const FIELD_WIDTH = 10
const FIELD_HEIGHT = 18
const SPAWN_AREA_HEIGHT = 4

const BLOCK_SIZE = 35

var game_field
var panel
var current_piece

var pre_block = preload('res://scenes/block.tscn')
var pre_piece = preload('res://scripts/piece.gd')

func _ready():
	set_process(true)
	
	panel = get_node('panel')
	
	start_game_field()
	
	game_field[21][0] = [255, 0, 0]
	game_field[21][1] = [0, 255 ,0]
	game_field[21][2] = [0, 0, 255]
	
	set_current_piece(pre_piece.new())
	current_piece.set_coord([4,3])
	#print('hello!: ' + str(current_piece.get_coord()))
	
	build_field()

func _process(delta):
	if Input.is_action_just_pressed('rotate_left') and not Input.is_action_just_pressed('rotate_right'):
		current_piece.rotate(main.LEFT)
		build_field()
	if Input.is_action_just_pressed('rotate_right') and not Input.is_action_just_pressed('rotate_left'):
		current_piece.rotate(main.RIGHT)
		build_field()

func build_field():
	for child in panel.get_children():
		child.queue_free()
	
	for x in range(FIELD_HEIGHT):
		for y in range(FIELD_WIDTH):
			if game_field[x + SPAWN_AREA_HEIGHT][y] != null:
				var color = game_field[x + SPAWN_AREA_HEIGHT][y]
				show_block(color, x, y)
	
	var coord = current_piece.get_coord()
	var matrix = current_piece.get_matrix()
	for x in range(4):
		for y in range(4):
			if matrix[x][y] != null and coord[0] + x >= 4:
				var color = matrix[x][y]
				show_block(color, coord[0] + x - 4, coord[1] + y)

func show_block(color, x, y):
	var block = pre_block.instance()
	block.set_color(color)
	panel.add_child(block)
	block.set_position(Vector2(
		y * BLOCK_SIZE + (float(BLOCK_SIZE) / 2),
		x * BLOCK_SIZE + (float(BLOCK_SIZE) / 2)
	))

func start_game_field():
	game_field = []
	for x in range(SPAWN_AREA_HEIGHT + FIELD_HEIGHT):
		game_field.append([])
		for y in range(FIELD_WIDTH):
			game_field[x].append(null)

func check_game_over(): # check if there is any placed blocks on the spawn area
	for x in range(SPAWN_AREA_HEIGHT):
		for y in range(FIELD_WIDTH):
			if game_field[x][y] != null:
				return true
	return false

func place_blocks(coordinates, color):
	for i in range(coordinates.size()):
		var aux = coordinates[i]
		var block = pre_block.instance()
		block.set_color(color)
		game_field[aux[0]][aux[1]] = block

func clean_rows(new_rows): # check if any row that had a block placed on needs to be cleaned
	for i in range(new_rows.size()):
		var new_row = new_rows[i]
		var flag = true
		for col in range(FIELD_WIDTH):
			if game_field[new_row][col] == null:
				flag = false
				break
		
		if flag == true:
			for row in range(new_row, SPAWN_AREA_HEIGHT, -1):
				for col in range(FIELD_WIDTH):
					game_field[row][col] = game_field[row-1][col]

func set_current_piece(value):
	current_piece = value

func _on_step_timer_timeout():
	var coord = current_piece.get_coord()
	current_piece.set_coord([coord[0]+1, coord[1]])
	
	build_field()
