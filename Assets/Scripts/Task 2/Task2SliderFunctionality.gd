extends MeshInstance3D

# Variables
signal task_success
@onready var game_manager = get_node("../../../../../")
var clicked : bool = false
var enabled : bool = false
var in_goal : bool = false

# Covers inputs that aren't related to the area3D
func _input(event):
	if event.is_action_released("Temp Left Click"):
		clicked = false
		if in_goal and enabled:
			task_success.emit()
	
	if event is InputEventMouseMotion and clicked and game_manager.game_state == game_manager.GAMEPLAY:
		var height = ProjectSettings.get_setting("display/window/size/viewport_height")
		var ychange = -event.relative.y / (height * .23) + self.position.y
		ychange = clampf(ychange, -0.2, 0.2)
		self.position.y = ychange

# Enables the slider
func enable_slider():
	enabled = true

# Disables the slider
func disable_slider():
	enabled = false
	clicked = false

# Signal from the slider when the user triggers an input within the bounds
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("Temp Left Click") and enabled:
		clicked = true
