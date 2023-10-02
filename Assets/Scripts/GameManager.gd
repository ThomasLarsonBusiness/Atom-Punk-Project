extends Node3D

# Game State
enum {GAMEPLAY, ENDGAME}
var game_state = GAMEPLAY

# Shift Management
@onready var game_controller = get_node("../")
@onready var task_manager = get_node("Environment")
@onready var player_controller = get_node("Camera3D")
@onready var puzzle_grid = get_node("Puzzle UI")

var task1_difficulty
var task2_difficulty
var task3_difficulty

# End Game Screen
var endgame_label
var endgame_restart_button
var endgame_quit_button


# Called when the node enters the scene tree for the first time.
func _ready():
	endgame_label = get_node("UI/End Game Header")
	endgame_restart_button = get_node("UI/To Menu Button")
	endgame_quit_button = get_node("UI/Restart Button")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_state == GAMEPLAY:
		pass

# Utility Functions

func start_game(difficulty1, difficulty2, difficulty3, path):
	task_manager.setup_tasks(difficulty1, difficulty2, difficulty3)
	puzzle_grid.setup_puzzle(path)

func end_game(label : String):
	# Display End Game UI
	game_state = ENDGAME
	endgame_label.text = label
	endgame_label.show()
	endgame_restart_button.show()
	endgame_quit_button.show()

func restart_game():
	#shift_timer = 0.0
	player_controller.puzzle_toggled = false
	player_controller.puzzle_grid.hide()
	puzzle_grid.restart_puzzle()
	game_state = GAMEPLAY
	endgame_label.hide()
	endgame_restart_button.hide()
	endgame_quit_button.hide()

# Signals
func _on_to_menu_button_pressed():
	game_controller.main_menu.show()
	self.queue_free()

func _on_restart_shift_pressed():
	restart_game()
	print(game_controller.task1_difficulty)
	task_manager.restart_shift(game_controller.task1_difficulty, 
		game_controller.task2_difficulty, game_controller.task3_difficulty)
