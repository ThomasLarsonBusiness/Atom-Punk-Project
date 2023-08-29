extends Camera3D

#Fields
var game_manager
var anim_player
enum FACING {LEFT, FORWARD, RIGHT}
var current_facing : FACING = FACING.FORWARD

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node("../")
	anim_player = get_node("AnimationPlayer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Checks for player input, and animates the player to the correct facing
	if game_manager.game_state == game_manager.GAMEPLAY:
		if Input.is_action_just_pressed("Look Left"):
			if current_facing == FACING.FORWARD:
				anim_player.play("Player_Facing/Forward_To_Left")
			if current_facing == FACING.RIGHT:
				anim_player.play("Player_Facing/Right_To_Left")
			current_facing = FACING.LEFT
		if Input.is_action_just_pressed("Look Forward"):
			if current_facing == FACING.LEFT:
				anim_player.play("Player_Facing/Left_To_Center")
			if current_facing == FACING.RIGHT:
				anim_player.play("Player_Facing/Right_To_Center")
			current_facing = FACING.FORWARD
		if Input.is_action_just_pressed("Look Right"):
			if current_facing == FACING.LEFT:
				anim_player.play("Player_Facing/Left_To_Right")
			if current_facing == FACING.FORWARD:
				anim_player.play("Player_Facing/Forward_To_Right")
			current_facing = FACING.RIGHT
