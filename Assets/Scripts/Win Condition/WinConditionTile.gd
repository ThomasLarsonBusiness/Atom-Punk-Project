extends Node2D

# Fields
@onready var grid_manager = get_node("../")
var silent_signal : bool = false
var is_building : bool = false
var x_value
var y_value
var cable_value = 0 # Represents if there is a cable in this tile or not
var cable_directions = []

# Methods
func _ready():
	pass

# Sets the Texture of the Sprite
func change_texture(texture : Texture2D, cable_present, 
		cable_vector : Vector4 = Vector4.ZERO, rotation : float = 0, building = true):
	$Texture.set("texture", texture)
	transform = transform.rotated_local(-transform.get_rotation())
	transform = transform.rotated_local(rotation)
	cable_value = cable_present
	cable_directions = []
	cable_directions.append(Vector2(cable_vector.x, cable_vector.y))
	cable_directions.append(Vector2(cable_vector.z, cable_vector.w))
	is_building = building


# Input Functionality 
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Temp Left Click") && !silent_signal:
		grid_manager.update_tile(x_value, y_value)
