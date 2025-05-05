extends Node2D

const COLUMNS = 10
const ROWS = 6
const BRICK_WIDTH = 64
const BRICK_HEIGHT = 32
const BRICK_OFFSET_X = 32
const BRICK_OFFSET_Y = 128

var brick_scene = preload("res://scenes/brick.tscn")

var score: int = 0

func _ready() -> void:
	for x in range(COLUMNS):
		for y in range(ROWS):
			create_brick(x, y)

func create_brick(x: int, y: int) -> void:
	
	var brick = brick_scene.instantiate()
	brick.position.x = BRICK_OFFSET_X + BRICK_WIDTH * x
	brick.position.y = BRICK_OFFSET_Y + BRICK_HEIGHT * y
	
	add_child(brick)
	pass


func _on_ball_brick_destroyed(brick: Node2D) -> void:
	score += 100
	$ScoreLabel.text = "Score: " + str(score)
	brick.queue_free()
