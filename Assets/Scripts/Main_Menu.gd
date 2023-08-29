extends Control

# Fields
@onready var task1_difficulty_input = get_node("Difficulties/Task 1 Difficulty")
@onready var task2_difficulty_input = get_node("Difficulties/Task 2 Difficulty")
@onready var task3_difficulty_input = get_node("Difficulties/Task 3 Difficulty")
var task1_difficulty = 10
var task2_difficulty = 10
var task3_difficulty = 10
signal progress_to_game



func _on_play_button_pressed():
	if task1_difficulty_input.text:
		task1_difficulty = clamp(int(task1_difficulty_input.text), 0, 20)

	if task2_difficulty_input.text:
		task2_difficulty = clamp(int(task2_difficulty_input.text), 0, 20)
	
	if task3_difficulty_input.text:
		task3_difficulty = clamp(int(task3_difficulty_input.text), 0, 20)
	
	progress_to_game.emit()

func _on_exit_button_pressed():
	get_tree().quit()
