extends Node3D
class_name PipeBase

# Variables
var rng = RandomNumberGenerator.new()
@onready var task_manager = get_node("../../../")
var green_material = load("res://Assets/Materials/Objects/MAT_task1_button_Green.tres")
var red_material = load("res://Assets/Materials/Objects/MAT_task1_button_Red.tres")

var initial_basis
var initial_rotation
var enabled = false
var correct_rotation : bool = true
var rotation_amount : float = 0.0
const rotation_axis = Vector3(0,1,0)

# Functions
func _ready():	
	initial_basis = transform.basis
	initial_rotation = get_rotation()
	$PipeMesh.set("surface_material_override/0", green_material)

func fix_pipe():
	enabled = false
	transform.basis = initial_basis
	$PipeMesh.set("surface_material_override/0", green_material)

func fail_pipe():
	correct_rotation = false
	enabled = true
	rotation_amount = rng.randi_range(1,3) * (PI/2)
	transform.basis = transform.basis.rotated(rotation_axis, rotation_amount)
	$PipeMesh.set("surface_material_override/0", red_material)
