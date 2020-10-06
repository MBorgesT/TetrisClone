extends Node2D

const BLOCK_SIZE = 35

const INITIAL_CD = 0.25
const SECOND_CD = 0.1

const INITIAL_DOWN_CD = 0.2
const SECOND_DOWN_CD = 0.05

var game_field
var panel
var current_piece

var x_mov_cd
var down_mov_cd

var pre_block = preload('res://scenes/block.tscn')
var pre_piece = preload('res://scripts/piece.gd')

func _ready():
	set_process(true)
	
	panel = get_node('panel')
	
	start_game_field()
	
	current_piece = main.get_current_piece()
	
	build_field()
	
	x_mov_cd = 0
	down_mov_cd = 0

func _process(delta):
	var flag = false # signals the need to rebuild the filed
	
	# rotation
	if Input.is_action_just_pressed('rotate_left') and not Input.is_action_just_pressed('rotate_right') and can_rotate(main.LEFT):
		current_piece.rotate(main.LEFT)
		flag = true
	elif Input.is_action_just_pressed('rotate_right') and not Input.is_action_just_pressed('rotate_left') and can_rotate(main.RIGHT):
		current_piece.rotate(main.RIGHT)
		flag = true
		
	# x axis moviment
	x_mov_cd -= delta
	
	if x_mov_cd <= 0:
		if Input.is_action_pressed('left') and not Input.is_action_pressed('right') and can_move_x_axis(main.LEFT):
			current_piece.move_x_axis(main.LEFT)
			if Input.is_action_just_pressed('left'):
				x_mov_cd = INITIAL_CD
			else:
				x_mov_cd = SECOND_CD
			flag = true
		elif Input.is_action_pressed('right') and not Input.is_action_pressed('left') and can_move_x_axis(main.RIGHT):
			current_piece.move_x_axis(main.RIGHT)
			if Input.is_action_just_pressed('right'):
				x_mov_cd = INITIAL_CD
			else:
				x_mov_cd = SECOND_CD
			flag = true
	
	# down moviment
	down_mov_cd -= delta
	
	if down_mov_cd <= 0 and Input.is_action_pressed('down'):
		if can_move_down():
			current_piece.move_down()
			if Input.is_action_just_pressed('down'):
				down_mov_cd = INITIAL_DOWN_CD
			else:
				down_mov_cd = SECOND_DOWN_CD
		else:
			place_current_piece()
			down_mov_cd = INITIAL_DOWN_CD
		
		flag = true
	
	# quick placement
	if Input.is_action_just_pressed('space'):
		quick_placement()
	
	# check if the field needs to be rebuilt
	if flag == true:
		build_field()

func build_field():
	for child in panel.get_children():
		child.queue_free()
	
	for x in range(main.FIELD_HEIGHT):
		for y in range(main.FIELD_WIDTH):
			if game_field[x + main.SPAWN_AREA_HEIGHT][y] != null:
				var color = game_field[x + main.SPAWN_AREA_HEIGHT][y]
				show_block(color, x, y)
	
	var coord = current_piece.get_coord()
	var matrix = current_piece.get_matrix()
	for x in range(matrix.size()):
		for y in range(matrix[0].size()):
			if matrix[x][y] != null and coord[0] + x >= 4:
				var color = matrix[x][y]
				show_block(color, coord[0] + x - 4, coord[1] + y)

func show_block(color, x, y):
	var block = pre_block.instance()
	block.set_color(color)
	panel.add_child(block)
	block.set_position(Vector2(
		y * BLOCK_SIZE + (float(BLOCK_SIZE) / 2), # it needs to be inverted; trust me, it makes sense
		x * BLOCK_SIZE + (float(BLOCK_SIZE) / 2)
	))

func start_game_field():
	game_field = []
	for x in range(main.SPAWN_AREA_HEIGHT + main.FIELD_HEIGHT):
		game_field.append([])
		for y in range(main.FIELD_WIDTH):
			game_field[x].append(null)

func check_game_over(): # check if there is any placed blocks on the spawn area
	for x in range(main.SPAWN_AREA_HEIGHT):
		for y in range(main.FIELD_WIDTH):
			if game_field[x][y] != null:
				return true
	return false

func can_move_down():
	var coord = current_piece.get_coord()
	var matrix = current_piece.get_matrix()
	var height = matrix.size()
	
	# simulates as if the piece is moved in row down
	# if any piece block coincides with a placed block, the piece needs to be placed
	for x in range(matrix.size()):
		if coord[0] + x + 1 == main.FIELD_HEIGHT + main.SPAWN_AREA_HEIGHT:
			return false
		for y in range(matrix[0].size()):
			if matrix[x][y] != null and game_field[coord[0] + x + 1][coord[1] + y] != null:
				return false
	
	return true

func place_current_piece():
	var matrix = current_piece.get_matrix()
	var coord = current_piece.get_coord()
	
	for x in range(matrix.size()):
		for y in range(matrix[0].size()):
			if matrix[x][y] != null:
				game_field[coord[0]+x][coord[1]+y] = matrix[x][y]
	
	main.next_piece()
	current_piece = main.get_current_piece()
	
	var rows = []
	for i in range(matrix.size()):
		rows.append(coord[0] + i)
	clean_rows(rows)

func quick_placement():
	while can_move_down():
		current_piece.move_down()
	
	place_current_piece()
	build_field()

func can_move_x_axis(direction):
	var coord = current_piece.get_coord()
	var matrix = current_piece.get_matrix()
	
	if direction == main.LEFT:
		if coord[1] - 1 < 0:
			return false
			
		for x in range(matrix.size()):
			if matrix[x][0] != null and game_field[coord[0] + x][coord[1] - 1] != null:
				return false
		
		return true
	elif direction == main.RIGHT:
		if coord[1] + matrix[0].size() >= main.FIELD_WIDTH:
			return false
		
		var width = matrix[0].size()
		for x in range(matrix.size()):
			if matrix[x][width-1] != null and game_field[coord[0] + x][coord[1] + width] != null:
				return false
		
		return true

func can_rotate(direction):
	var coord = current_piece.get_coord()
	
	var new_matrix
	if direction == main.LEFT:
		new_matrix = current_piece.get_next_position(main.LEFT)
	elif direction == main.RIGHT:
		new_matrix = current_piece.get_next_position(main.RIGHT)
	
	if coord[1] < 0 or coord[1] + new_matrix[0].size() > main.FIELD_WIDTH:
		return false
	
	for x in range(new_matrix.size()):
		if coord[0] + x >= main.FIELD_HEIGHT + main.SPAWN_AREA_HEIGHT:
			return false
		for y in range(new_matrix[0].size()):
			if new_matrix[x][y] != null and game_field[coord[0] + x][coord[1] + y] != null:
				return false
	
	return true

func clean_rows(new_rows): # check if any row that had a block placed on needs to be cleaned
	var score = 0
	
	for i in range(new_rows.size()):
		var new_row = new_rows[i]
		var flag = true
		for col in range(main.FIELD_WIDTH):
			if game_field[new_row][col] == null:
				flag = false
				break
		
		if flag == true:
			score += main.SCORE_PER_PIECE
			for row in range(new_row, main.SPAWN_AREA_HEIGHT, -1):
				for col in range(main.FIELD_WIDTH):
					game_field[row][col] = game_field[row-1][col]
	
	main.add_to_score(score)

func set_current_piece(value):
	current_piece = value

func _on_step_timer_timeout():
	if can_move_down():
		current_piece.move_down()
	else:
		place_current_piece()
		
	build_field()
