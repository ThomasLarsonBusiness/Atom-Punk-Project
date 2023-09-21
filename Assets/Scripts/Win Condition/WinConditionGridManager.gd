extends Node2D

# Fields
@onready var tile = load("res://Scenes/Objects/Win Condition/SCE_Win_Condition_Tile.tscn")
@onready var temp_texture = load("res://Assets/Textures/Win_Condition_Blank.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	make_grid(15, 8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func make_grid(x, y):
	for i in x:
		for j in y:
			var tile_scene = tile.instantiate()
			tile_scene.transform = transform.translated(Vector2(100 + 100 * i,150 + 100 * j))
			tile_scene.change_texture(temp_texture)
			tile_scene.x_value = i
			tile_scene.y_value = j
			add_child(tile_scene)
	
