extends Node2D

const COLUMNS = 10
const ROWS = 6
const BRICK_WIDTH = 64
const BRICK_HEIGHT = 32
const BRICK_OFFSET_X = 32
const BRICK_OFFSET_Y = 128

var brick_scene = preload("res://scenes/brick.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for x in range(COLUMNS):
		for y in range(ROWS):
			create_brick(x, y)
	
	pass # Replace with function body.

func create_brick(x: int, y: int) -> void:
	
	var brick = brick_scene.instantiate()
	brick.position.x = BRICK_OFFSET_X + BRICK_WIDTH * x
	brick.position.y = BRICK_OFFSET_Y + BRICK_HEIGHT * y
	
	add_child(brick)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
