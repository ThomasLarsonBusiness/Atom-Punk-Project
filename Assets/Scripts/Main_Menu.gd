extends Control

# Fields
@onready var task1_difficulty_input = get_node("Difficulties/Task 1 Difficulty")
@onready var task2_difficulty_input = get_node("Difficulties/Task 2 Difficulty")
@onready var task3_difficulty_input = get_node("Difficulties/Task 3 Difficulty")
var task1_difficulty = 10
var task2_difficulty = 10
var task3_difficulty = 10
var puzzle_path = "res://Data/Puzzles/TestPuzzle2.json"
signal progress_to_game

func load_shift(path):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var parsed_data = JSON.parse_string(file.get_as_text())
		if parsed_data is Dictionary:
			fill_shift_data(parsed_data)

func fill_shift_data(data):
	var difficulties = data["Difficulties"]
	task1_difficulty = difficulties[0]
	task2_difficulty = difficulties[1]
	task3_difficulty = difficulties[2]
	puzzle_path = data["Puzzle Path"]
	progress_to_game.emit()


func _on_shift_1_button_pressed():
	load_shift("res://Data/Shifts/Shift1.json")

func _on_shift_1_button_2_pressed():
	load_shift("res://Data/Shifts/Shift2.json")

func _on_exit_button_pressed():
	get_tree().quit()


func _on_custom_shift_button_pressed():
	if task1_difficulty_input.text:
		task1_difficulty = clamp(int(task1_difficulty_input.text), 0, 20)

	if task2_difficulty_input.text:
		task2_difficulty = clamp(int(task2_difficulty_input.text), 0, 20)
	
	if task3_difficulty_input.text:
		task3_difficulty = clamp(int(task3_difficulty_input.text), 0, 20)
	
	progress_to_game.emit()
