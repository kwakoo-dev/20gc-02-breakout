extends BaseState
class_name StageStart

var _paddle : Paddle
var _ball : Ball

func initialize(paddle : Paddle, ball : Ball) -> BaseState:
	_paddle = paddle
	_ball = ball
	return self

func enter() -> void:
	_paddle.position.x = 350 # todo: move it to the actual center of the screen
	_ball.current_state = _ball.State.STOPPED

func physics_process(_delta: float) -> void:
	_ball.position = _paddle.position + Vector2(0, -32)

func input_process(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		finished.emit("playing")
