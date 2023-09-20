extends Node3D

# Variables
var rng = RandomNumberGenerator.new()
var pipe_array = Array()

# Called when the node enters the scene tree for the first time.
func on_start():
	# Gets all the pipes
	for i in 3:
		for n in 3:
			var path = "Pipe_" + str(i) + "_" + str(n)
			var pipe = get_node(path)
			pipe.on_start()
			pipe_array.append(pipe)

func reset():
	for i in pipe_array.size():
		pipe_array[i].fix_pipe()

func task_failure():
	# Set some to red
#	var change_array = Array()
#	while change_array.size() < num_to_fail:
#		var rand_int = rng.randi_range(0, pipe_array.size() - 1)
#		if !change_array.has(rand_int):
#			change_array.append(rand_int)
#
#	for i in change_array.size():
#		pipe_array[change_array[i]].fail_pipe()
	var success = false
	while !success:
		var rand_int = rng.randi_range(0, pipe_array.size() - 1)
		if !pipe_array[rand_int].enabled:
			pipe_array[rand_int].fail_pipe()
			success = true
