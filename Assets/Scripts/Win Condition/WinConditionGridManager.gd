extends Node2D

# Scenes
@onready var tile = load("res://Scenes/Objects/Win Condition/SCE_Win_Condition_Tile.tscn")

# Textures
@onready var blank_texture = load("res://Assets/Textures/Win_Condition_Blank.png")
@onready var power_texture = load("res://Assets/Textures/Win_Condition_Power.png")
@onready var house_texture = load("res://Assets/Textures/Win_Condition_House.png")

# Puzzles
var loaded_data

# Fields
@onready var game_manager = get_node("../")
@onready var ui = get_node("SCE_Win_Condition_UI")
var tiles = []
var cardinal_directions = [Vector2(-1,0), Vector2(1,0), Vector2(0,-1), Vector2(0,1)]
var grid_width
var grid_height
var power_tile : Vector2
var cables_needed : int = 0
var cables_placed : int = 0

# Called when the node enters the scene tree for the first time.
func setup_puzzle(path):
	# Gets the Data
	loaded_data = load_puzzle(path)
	create_puzzle(loaded_data)


func load_puzzle(path : String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var parsedData = JSON.parse_string(file.get_as_text())
		if  parsedData is Dictionary:
			return parsedData
	else:
		print("File Isn't Real")


func make_grid(x, y):
	var center_x = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
	var center_y = ProjectSettings.get_setting("display/window/size/viewport_height") / 2
	
	var initial_x = center_x + 50 - (x * 50)
	var initial_y = center_y + 50 - (y * 50)
	
	for i in x:
		tiles.append([])
		for j in y:
			var tile_scene = tile.instantiate()
			tile_scene.transform = transform.translated(Vector2(initial_x + 100 * i,initial_y + 100 * j))
			tile_scene.change_texture(blank_texture, 0)
			tile_scene.x_value = i
			tile_scene.y_value = j
			add_child(tile_scene)
			tiles[i].append(tile_scene)
	
	grid_width = x
	grid_height = y

func create_puzzle(data):
	# Makes the Grid
	var grid_size = data["grid_size"]
	make_grid(grid_size["x"], grid_size["y"])
	
	# Sets the Power Tile
	var power_loc = data["power_loc"]
	power_tile = Vector2(power_loc["x"], power_loc["y"])
	tiles[power_loc["x"]][power_loc["y"]].change_texture(power_texture, 0)
	tiles[power_loc["x"]][power_loc["y"]].silent_signal = true
	
	# Sets the House Tiles
	var house_locs = data["house_locs"]
	for i in house_locs.size():
		var parsed_xy = house_locs[i].split(",")
		tiles[int(parsed_xy[0])][int(parsed_xy[1])].change_texture(house_texture, 0)
		tiles[int(parsed_xy[0])][int(parsed_xy[1])].silent_signal = true
	
	# Sets the Amount of Cables Needed
	cables_needed = (house_locs.size() + 1) * 3
	print(cables_needed)

# Updates a tile's texture and data
func update_tile(x, y):
	# Determines if the Cable exists
	var cable_value = 0
	if ui.cable_directions != Vector4.ZERO:
		cable_value = 1
	
	# Checks if the cable value changes
	if cable_value != tiles[x][y].cable_value:
		cables_placed += cable_value - tiles[x][y].cable_value
	
	# Updates the Texture
	tiles[x][y].change_texture(ui.selected_texture, cable_value, 
		ui.cable_directions, deg_to_rad(ui.rotation_needed), false)
	
	# If enough cables to win, check if solved
	if cables_needed == cables_placed:
		check_solution()

# Checks to see if the puzzle is solved
func check_solution():
	# Gets the first cable surrounding the power station
	var current_tile = tiles[power_tile.x][power_tile.y]
	var direction_to_ignore : Vector2
	var success = 0
	
	# Loops through, checking through the puzzle
	for loops in cables_needed/3:
		# Checks around the house/power station for a cable
		for i in 4:
			var xdir = cardinal_directions[i].x
			var ydir = cardinal_directions[i].y
			var coords = Vector2(current_tile.x_value + xdir, current_tile.y_value + ydir)
			if coords.x < 0 || coords.x > grid_width-1 || coords.y < 0 || coords.y > grid_height-1:
				print("cope")
				continue
			
			if tiles[current_tile.x_value + xdir][current_tile.y_value + ydir].cable_value == 1:
				direction_to_ignore = Vector2(-xdir, -ydir)
				current_tile = tiles[current_tile.x_value + xdir][current_tile.y_value + ydir]
				break
		
		if current_tile == null:
			print("No Initial Tile Found")
			return
		#print("X: " + str(current_tile.x_value) + " Y: " + str(current_tile.y_value))
		
		# Follows the cable to a house, failing if more than three cables traveled
		for i in 3:
			for path in 2:
				var direction = current_tile.cable_directions[path]
				if direction != direction_to_ignore:
					var x_direction = direction.x + current_tile.x_value
					var y_direction = direction.y + current_tile.y_value
					current_tile = tiles[x_direction][y_direction]
					
					if i == 2 and current_tile.is_building:
						direction_to_ignore = Vector2.ZERO
						break
					
					if current_tile.cable_value != 1:
						print("BAD: " + str(current_tile.x_value) + str(current_tile.y_value))
						return
						
					direction_to_ignore = Vector2(-direction.x, -direction.y)
		
		# Checks if it found a house
		if current_tile.is_building == true:
			success += 1
		else:
			print("L X: " + str(current_tile.x_value) + " Y: " + str(current_tile.y_value))
			break
	
	# If success is equal to needed cables / 3, the player won
	if success == cables_needed/3:
		game_manager.end_game("You Won!")

# This will likely get changed into loading in a new puzzle but for now this works
func restart_puzzle():
	cables_placed = 0
	for i in grid_width:
		for j in grid_height:
			tiles[i][j].queue_free()
	tiles.clear()
	create_puzzle(loaded_data)
