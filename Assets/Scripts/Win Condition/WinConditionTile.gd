extends Node2D

# Fields
var x_value
var y_value

enum {BLANK, HOUSE, POWER, STRAIGHT_VERT, STRAIGHT_HOR, CORNER_NE, 
	CORNER_ES, CORNER_SW, CORNER_WN}

# Methods
func _ready():
	pass

# Sets the Texture of the Sprite
func change_texture(texture : Texture2D):
	$Texture.set("texture", texture)
	pass

# Input Functionality 
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Temp Left Click"):
		print(str(x_value) + " - " + str(y_value))
