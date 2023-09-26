extends Node2D

var rotation_needed : int = 0
@onready var selected_texture : Resource = load("res://Assets/Textures/Win_Condition_Blank.png")
var cable_directions : Vector4 = Vector4.ZERO

func _on_sce_win_condition_selector_clicked(id, texture, directions : Vector4 = Vector4.ZERO):
	rotation_needed = id
	selected_texture = texture
	cable_directions = directions
	
