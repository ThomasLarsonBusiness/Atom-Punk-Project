extends PipeBase


# Signals
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):	
	if Input.is_action_just_pressed("Temp Left Click") and enabled:
		var rot_amount = (PI / 2)
		transform.basis = transform.basis.rotated(rotation_axis, rot_amount)
		
		var cur_rot = snapped(get_rotation().y, 0.1)
		var initial_rot = snapped(initial_rotation.y, 0.1)
		
		if cur_rot == initial_rot :
			correct_rotation = true
			task_manager.task3_update(1)
		elif correct_rotation:
			task_manager.task3_update(-1)
			correct_rotation = false
