extends Node3D

# Fields
var rng = RandomNumberGenerator.new()
var game_manager

# UI
var heat_timer : float = 0.0
var heat_max : float = 0.0
var heat_bar
var endgame_label

# Task 1 Variables
var task1_btn_array = Array()
var task1_timer : float = 0.0
var task1_base_cooldown : float = 25.0
var task1_base_cooldown_range : float = 15.0
var task1_cooldown : float = 30.0
var task1_cooldown_min : float = 0.0
var task1_cooldown_max : float = 0.0
var task1_buttons_to_change: int = 0
var task1_buttons_changed : int = 0
var task1_in_progress : bool = false

# Task 2 Variables
var task2_slider_array = Array()
var task2_goals_array = Array()
var task2_timer : float = 0.0
var task2_base_cooldown: float = 30.0
var task2_base_cooldown_range : float = 20.0
var task2_cooldown : float = 20.0
var task2_cooldown_min : float = 0.0
var task2_cooldown_max: float = 0.0
var task2_sliders_to_activate : int = 3
var task2_sliders_active : int = 0
var task2_slider_min_distance : float = 0.0
var task2_in_progress : bool = false

# Task 3 Variables
var task3_panel
var task3_pipes_to_fail : int
var task3_failed_pipes : int = 0
var task3_in_progress: bool = false
var task3_base_cooldown : float = 30.0
var task3_base_cooldown_range : float = 20.0
var task3_cooldown : float
var task3_cooldown_min : float
var task3_cooldown_max : float
var task3_timer : float

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node("../")
	
	heat_bar = get_node("../UI/HeatBar")
	endgame_label = get_node("../UI/End Game Header")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer_update(delta)
	update_heatbar(delta)
	
# Sets up all of the active tasks, depending on what shift and difficulty has
#    been set
func setup_tasks(difficulty1, difficulty2, difficulty3):
	task1_init(difficulty1)
	task2_init(difficulty2)
	task3_init(difficulty3)

# Task Functions
# Task 1
func task1_init(difficulty: int):
	# Gets all of the task 1 buttons
	task1_btn_array.append(get_node("Panel_Base_1/Task_1_Button_1"))
	task1_btn_array.append(get_node("Panel_Base_1/Task_1_Button_2"))
	
	if difficulty >= 6:
		task1_btn_array.append(get_node("Panel_Base_2/Task_1_Button_3"))
		task1_btn_array.append(get_node("Panel_Base_2/Task_1_Button_4"))
	
	if difficulty >= 12:
		task1_btn_array.append(get_node("Panel_Base_3/Task_1_Button_5"))
		task1_btn_array.append(get_node("Panel_Base_3/Task_1_Button_6"))
	
	# Enables all active buttons
	for n in task1_btn_array.size():
		task1_btn_array[n].enable()
	
	# Sets cooldown range
	task1_cooldown_min = int(difficulty/5) * 2 + (task1_base_cooldown - difficulty)
	task1_cooldown_max = (task1_cooldown_min + task1_base_cooldown_range
		- (int(difficulty/5) * 2))
	task1_cooldown = rng.randf_range(task1_cooldown_min, task1_cooldown_max)
	
	# Sets the number of buttons that should change
	task1_buttons_to_change = clamp(ceil(float(difficulty)/5.0), 1, 4)
	if difficulty == 20:
		task1_buttons_to_change = 5

func task1_trigger():
	# Set some to red
	var change_array = Array()
	while change_array.size() < task1_buttons_to_change:
		var rand_int = rng.randi_range(0,task1_btn_array.size() - 1)
		if !change_array.has(rand_int):
			change_array.append(rand_int)
	
	for n in change_array.size():
		task1_btn_array[change_array[n]].set_red()
	
	# Sets up Task Tracking
	task1_buttons_changed = task1_buttons_to_change
	task1_in_progress = true
	
func task1_update():
	if task1_in_progress:
		task1_buttons_changed -= 1
		if task1_buttons_changed == 0:
			task1_in_progress = false
			task1_cooldown = rng.randi_range(task1_cooldown_min, task1_cooldown_max)

# Task 2
func task2_init(difficulty: int):
	# Gets all the sliders and slider goals (Will need to be distributed like task 1)
	task2_slider_array.append(get_node("Panel_Base_2/Task_2_Panel_1/Panel_Base/Slider_1"))
	task2_slider_array.append(get_node("Panel_Base_2/Task_2_Panel_1/Panel_Base/Slider_2"))
	task2_slider_array.append(get_node("Panel_Base_2/Task_2_Panel_1/Panel_Base/Slider_3"))
	task2_goals_array.append(get_node("Panel_Base_2/Task_2_Panel_1/Panel_Base/Slider_1_Goal"))
	task2_goals_array.append(get_node("Panel_Base_2/Task_2_Panel_1/Panel_Base/Slider_2_Goal"))
	task2_goals_array.append(get_node("Panel_Base_2/Task_2_Panel_1/Panel_Base/Slider_3_Goal"))
	
	if difficulty >= 11:
		task2_slider_array.append(get_node("Panel_Base_3/Task_2_Panel_2/Panel_Base/Slider_1"))
		task2_slider_array.append(get_node("Panel_Base_3/Task_2_Panel_2/Panel_Base/Slider_2"))
		task2_slider_array.append(get_node("Panel_Base_3/Task_2_Panel_2/Panel_Base/Slider_3"))
		task2_goals_array.append(get_node("Panel_Base_3/Task_2_Panel_2/Panel_Base/Slider_1_Goal"))
		task2_goals_array.append(get_node("Panel_Base_3/Task_2_Panel_2/Panel_Base/Slider_2_Goal"))
		task2_goals_array.append(get_node("Panel_Base_3/Task_2_Panel_2/Panel_Base/Slider_3_Goal"))

	
	# Sets cooldown (Will need a max and min, plus the initial cooldown)
	task2_cooldown_min = task2_base_cooldown - (difficulty / 2)
	task2_cooldown_max = task2_cooldown_min + (task2_base_cooldown_range - difficulty / 4)
	task2_cooldown = rng.randf_range(task2_cooldown_min, task2_cooldown_max)
	
	# Sets number of sliders to activate (Will need to be updated based on difficulty)
	task2_sliders_to_activate = 2 + int((difficulty - 1) / 5)
	if difficulty == 20:
		task2_sliders_to_activate = 6
	
	# Sets the minimum distance away from the slider the goal can be, based on difficulty
	task2_slider_min_distance = 0.04 + 0.002 * difficulty

func task2_trigger():
	# Gets Which Random Sliders to Activate
	var change_array = Array()
	while change_array.size() < task2_sliders_to_activate:
		var rand_int = rng.randi_range(0, task2_slider_array.size() - 1)
		if !change_array.has(rand_int):
			change_array.append(rand_int)
	
	# Moves the goals and enables sliders
	for n in change_array.size():
		var goal = task2_goals_array[change_array[n]]
		var slider = task2_slider_array[change_array[n]]
		
		# Moves goal once valid placement is found
		var valid_placement = false
		while valid_placement == false:
			var temp_pos = rng.randf_range(-0.175, 0.175)
			var distance = temp_pos - slider.position.y
			if abs(distance) > task2_slider_min_distance:
				goal.position.y = temp_pos
				valid_placement = true
		goal.enable_goal()
		slider.enable_slider()
	
	# Sets up task tracking
	task2_sliders_active = task2_sliders_to_activate
	task2_in_progress = true

func task2_update():
	if task2_in_progress:
		task2_sliders_active -= 1
		if task2_sliders_active == 0:
			task2_in_progress = false
			task2_cooldown = rng.randf_range(task2_cooldown_min, task2_cooldown_max)

# Task 3
func task3_init(difficulty: int):
	# Gets the panel
	task3_panel = get_node("Panel_Base_1/Task_3_Panel")
	
	# Determines how many pipes to fail
	task3_pipes_to_fail = int(difficulty / 3)
	
	# Sets Cooldown range
	task3_cooldown_min = task3_base_cooldown - difficulty / 1.5
	task3_cooldown_max = task3_cooldown_min + (task3_base_cooldown_range - difficulty / 3)
	task3_cooldown = rng.randf_range(task3_cooldown_min, task3_cooldown_max)

func task3_trigger():
	task3_panel.task_failure(task3_pipes_to_fail)
	task3_failed_pipes = task3_pipes_to_fail
	task3_in_progress = true

func task3_update():
	if task3_in_progress:
		task3_failed_pipes -= 1
		if task3_failed_pipes == 0:
			task3_in_progress = false
			task3_cooldown = rng.randf_range(task3_cooldown_min, task3_cooldown_max)

# Helper Functions
func timer_update(delta):
	if game_manager.game_state == game_manager.GAMEPLAY:
		# Updates the task 1 timer
		if !task1_in_progress:
			task1_timer += delta
			if task1_timer >= task1_cooldown:
				task1_trigger()
				task1_timer = 0
		
		# Updates the task 2 timer
		if !task2_in_progress:
			task2_timer += delta
			if task2_timer >= task2_cooldown:
				task2_trigger()
				task2_timer = 0
		
		# Updates the task 3 timer
		if !task3_in_progress:
			task3_timer += delta
			if task3_timer >= task3_cooldown:
				task3_trigger()
				task3_timer = 0

# Updates the heatbar based on what tasks are active
func update_heatbar(delta):
	if game_manager.game_state == game_manager.GAMEPLAY:
		var heat_multiplier = 0
		heat_multiplier += int(task1_in_progress) * 1
		heat_multiplier += int(task2_in_progress) * 1.5
		heat_multiplier += int(task3_in_progress) * 1.25
		
		if heat_multiplier == 0:
			heat_multiplier = -0.5
		
		# Updates the Heat
		heat_bar.value += delta * heat_multiplier
		if heat_bar.max_value <= heat_bar.value:
			endgame_label.text = "YOU LOST"
			game_manager.end_game()

func restart_shift(difficulty1, difficulty2, difficulty3):
	# Task 1 Reset
	for n in task1_btn_array.size():
		task1_btn_array[n].set_green()
	task1_timer = 0
	task1_buttons_changed = 0
	task1_in_progress = false
	task1_init(difficulty1)
	
	# Task 2 Reset
	for n in task2_slider_array.size():
		task2_slider_array[n].disable_slider()
		task2_slider_array[n].position.y = 0
		task2_goals_array[n].disable_goal()
		task2_goals_array[n].position.y = 0
	task2_slider_array = Array()
	task2_goals_array = Array()
	task2_timer = 0
	task2_sliders_active = 0
	task2_in_progress = false
	task2_init(difficulty2)
	
	# Task 3 Reset
	task3_panel.reset()
	task3_timer = 0
	task3_pipes_to_fail = 0
	task3_in_progress = 0
	task3_init(difficulty3)
	
	
	# Reset Heat Bar
	heat_bar.value = 0
