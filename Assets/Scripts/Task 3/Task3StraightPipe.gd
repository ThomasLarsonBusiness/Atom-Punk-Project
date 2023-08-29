extends PipeBase

# Function
func fail_pipe():
	enabled = true
	var rotation_amount = (PI/2)
	transform.basis = transform.basis.rotated(rotation_axis, rotation_amount)
	$PipeMesh.set("surface_material_override/0", red_material)

# Signals
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("Temp Left Click") and enabled:
		var rot_amount = (PI / 2)
		transform.basis = transform.basis.rotated(rotation_axis, rot_amount)
		task_manager.task3_update()
		enabled = false
		$PipeMesh.set("surface_material_override/0", green_material)
