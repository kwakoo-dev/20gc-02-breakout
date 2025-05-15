extends BaseState
class_name PlayingState

var _ball : Ball

func initialize(ball : Ball) -> BaseState:
	_ball = ball
	return self
	
func enter() -> void:
	_ball.current_state = _ball.State.MOVING
