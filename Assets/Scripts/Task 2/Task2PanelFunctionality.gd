extends Node3D

# Variables
@onready var task_manager = get_node("../../")

var slider1
var slider2
var slider3

var slider1_goal
var slider2_goal
var slider3_goal

# Called when the node enters the scene tree for the first time.
func _ready():
	# Gets sliders
	slider1 = get_node("Panel_Base/Slider_1")
	slider2 = get_node("Panel_Base/Slider_2")
	slider3 = get_node("Panel_Base/Slider_3")
	
	# Get slider goals
	slider1_goal = get_node("Panel_Base/Slider_1_Goal")
	slider2_goal = get_node("Panel_Base/Slider_2_Goal")
	slider3_goal = get_node("Panel_Base/Slider_3_Goal")

# Slider 1 Collision Check
func _on_slider_1_area_area_entered(area):
	if area == slider1_goal.collision_area:
		slider1.in_goal = true

func _on_slider_1_area_area_exited(area):
	if area == slider1_goal.collision_area:
		slider1.in_goal = false

# Slider 2 Collision Check
func _on_slider_2_area_area_entered(area):
	if area == slider2_goal.collision_area:
		slider2.in_goal = true

func _on_slider_2_area_area_exited(area):
	if area == slider2_goal.collision_area:
		slider2.in_goal = false

# Slider 3 Collision Check
func _on_slider_3_area_area_entered(area):
	if area == slider3_goal.collision_area:
		slider3.in_goal = true

func _on_slider_3_area_area_exited(area):
	if area == slider3_goal.collision_area:
		slider3.in_goal = false

# Success Signal
func _on_slider_1_task_success():
	task_manager.task2_update()
	slider1.disable_slider()
	slider1_goal.disable_goal()

func _on_slider_2_task_success():
	task_manager.task2_update()
	slider2.disable_slider()
	slider2_goal.disable_goal()

func _on_slider_3_task_success():
	task_manager.task2_update()
	slider3.disable_slider()
	slider3_goal.disable_goal()
