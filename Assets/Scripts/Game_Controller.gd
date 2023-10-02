extends Node

# Variables
@onready var loading_screen = get_node("Loading Screen")
@onready var main_menu = get_node("sce_main_menu")
@onready var reactor_scene = load("res://Scenes/Environments/sce_reactor_room.tscn")
var task1_difficulty
var task2_difficulty
var task3_difficulty
var puzzle_path

func _on_sce_main_menu_progress_to_game():
	loading_screen.show()
	
	task1_difficulty = main_menu.task1_difficulty
	task2_difficulty = main_menu.task2_difficulty
	task3_difficulty = main_menu.task3_difficulty
	puzzle_path = main_menu.puzzle_path
	
	main_menu.hide()
	
	var scene = reactor_scene.instantiate()
	add_child(scene)
	
	scene.start_game(task1_difficulty, task2_difficulty, task3_difficulty, puzzle_path)
	loading_screen.hide()
