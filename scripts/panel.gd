extends Panel


const FIELD_WIDTH = 10
const FIELD_HEIGHT = 18
const SPAWN_AREA_HEIGHT = 4

# the first lines are for spawn point and the rest is game field
var game_field

func _ready():
	start_game_field()
	pass 

func start_game_field():
	game_field = []
	for x in range(FIELD_WIDTH):
		game_field[x] = []
		for y in range(SPAWN_AREA_HEIGHT + FIELD_HEIGHT):
			game_field[x][y] = false

func check_game_over(): # check if there is any placed blocks on the spawn area
	for x in range(SPAWN_AREA_HEIGHT):
		for y in range(FIELD_WIDTH):
			if game_field[x][y] == true:
				return true
	return false

func place_piece(coordinates):
	for i in range(4):
		var block = coordinates[i]
		game_field[block[0]][block[1]] = true

func clean_rows(new_rows): # check if any of row that had a block placed on needs to be cleaned
	for i in range(new_rows.size()):
		var new_row = new_rows[i]
		var flag = true
		for col in range(FIELD_WIDTH):
			if game_field[new_row][col] == false:
				flag = false
				break
		
		if flag == true:
			for row in range(new_row, SPAWN_AREA_HEIGHT):
				for col in range(FIELD_WIDTH):
					game_field[row][col] = game_field[row-1][col]
