extends Node2D
# NOTE: Every Instance needs a meta-data field for texture and id

# Fields
var texture : Texture
var id : int
var cable_directions : Vector4
signal clicked(id : int, texture : Resource)

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = get_meta("texture")
	id = get_meta("id")
	cable_directions = get_meta("cable_directions")
	$Texture.set("texture", texture)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Temp Left Click"):
		clicked.emit(id, texture, cable_directions)
