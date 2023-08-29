extends Node3D

# Game State
enum {GAMEPLAY, ENDGAME}
var game_state = GAMEPLAY

# Shift Management
@onready var game_controller = get_node("../")
@onready var task_manager = get_node("Environment")

var shift_timer : float = 0.0
var shift_length : float = 120.0
var timer_string = "Timer: %s"
var timer_ui
var task1_difficulty
var task2_difficulty
var task3_difficulty

# End Game Screen
var endgame_label
var endgame_restart_button
var endgame_quit_button


# Called when the node enters the scene tree for the first time.
func _ready():
	timer_ui = get_node("UI/Timer")
	
	endgame_label = get_node("UI/End Game Header")
	endgame_restart_button = get_node("UI/Exit Button")
	endgame_quit_button = get_node("UI/Restart Button")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_state == GAMEPLAY:
		timer_update(delta)
		if shift_timer >= shift_length:
			end_game()
			endgame_label.text = "YOU WON!"

# Utility Functions
func timer_update(delta):
	# Updates the shift timer
	shift_timer += delta
	timer_ui.text = timer_string % int(round(shift_timer))

func start_game(difficulty1, difficulty2, difficulty3):
	task_manager.setup_tasks(difficulty1, difficulty2, difficulty3)

func end_game():
	# Display End Game UI
	game_state = ENDGAME
	endgame_label.show()
	endgame_restart_button.show()
	endgame_quit_button.show()

func restart_game():
	shift_timer = 0.0
	game_state = GAMEPLAY
	endgame_label.hide()
	endgame_restart_button.hide()
	endgame_quit_button.hide()

# Signals
func _on_exit_button_pressed():
	get_tree().quit()

func _on_restart_shift_pressed():
	restart_game()
	print(game_controller.task1_difficulty)
	task_manager.restart_shift(game_controller.task1_difficulty, 
		game_controller.task2_difficulty, game_controller.task3_difficulty)
