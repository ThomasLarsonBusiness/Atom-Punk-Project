extends Node3D

# Fields
var is_red : bool = false
@onready var task_manager = get_node("../../")
var green_material = load("res://Assets/Materials/Objects/MAT_task1_button_Green.tres")
var red_material = load("res://Assets/Materials/Objects/MAT_task1_button_Red.tres")
var disabled_material = load("res://Assets/Materials/Objects/MAT_task1_disabled.tres")

func enable():
	$ButtonMesh.set("surface_material_override/0", green_material)

func set_red():
	is_red = true
	$ButtonMesh.set("surface_material_override/0", red_material)

func set_green():
	is_red = false
	$ButtonMesh.set("surface_material_override/0", green_material)

# Works, but should still switch to two materials eventaully
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("Temp Left Click") and is_red:
		set_green()
		task_manager.task1_update()
