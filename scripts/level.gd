extends Node2D

const COLUMNS = 10
const ROWS = 6
const INITIAL_BRICK_COUNT = COLUMNS * ROWS
const BRICK_WIDTH = 64
const BRICK_HEIGHT = 32
const BRICK_OFFSET_X = 32
const BRICK_OFFSET_Y = 128


enum State {
	STAGE_START,
	PLAYING
}

var current_state : State = State.STAGE_START
var brick_scene = preload("res://scenes/brick.tscn")

func _ready() -> void:
	Globals
	$StateMachine.initialize($Paddle, $Ball)
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
	add_score(100)
	var ball_speed = get_ball_speed_percent()
	print_debug("Ball speed changed! " + str(ball_speed))
	$Ball.set_speed_factor(ball_speed)
	brick.queue_free()

func get_ball_speed_percent() -> float:
	var brick_count = get_tree().get_nodes_in_group("bricks").size()
	# adding one because the bricks are counted BEFORE the brick is deleted
	# so the brick_count is off by one
	return (INITIAL_BRICK_COUNT + 1 - float(brick_count)) / INITIAL_BRICK_COUNT

func _physics_process(delta: float) -> void:
	$StateMachine.physics_process(delta)
	
func _input(event: InputEvent) -> void:
	$StateMachine.input_process(event)

func add_score(score_to_add : int) -> void:
	Globals.score += score_to_add
	update_score_gui()

func set_score(score_to_set : int) -> void:
	Globals.score = score_to_set
	update_score_gui()

func update_score_gui() -> void:
	$ScoreLabel.text = "Score: " + str(Globals.score)

func decrease_lives() -> void:
	Globals.lives -= 1
	update_lives_gui()

func update_lives_gui() -> void:
	$LivesLabel.text = "Lives: " + str(Globals.lives)

func _on_ball_death() -> void:
	decrease_lives()
	if Globals.lives <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	$StateMachine.switch_to_state("start")
	# todo: play death sound
