extends MeshInstance3D

# Variables
var error_material = load("res://Assets/Materials/Objects/MAT_task2_goal_Red.tres")
var success_material = load("res://Assets/Materials/Objects/MAT_task2_disabled.tres")
@onready var collision_area = get_node("Goal_Area")

func enable_goal():
	self.set("surface_material_override/0", error_material)

func disable_goal():
	self.set("surface_material_override/0", success_material)

