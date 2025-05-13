extends Node
class_name StateMachine

var _states = {}
var _current_state : BaseState

func initialize(paddle : Paddle, ball : Ball) -> void:
	_states["start"] = $StageStart.initialize(paddle, ball)
	_states["playing"] = $PlayingState.initialize(ball)
	
	_current_state = _states["start"]
	_current_state.enter()

func physics_process(delta: float) -> void:
	_current_state.physics_process(delta)

func input_process(event: InputEvent) -> void:
	_current_state.input_process(event)

func _on_state_finished(next_state: String) -> void:
	var new_state = _states[next_state]
	if new_state:
		print_debug("Switching to state: " + next_state)
		_current_state.exit()
		_current_state = new_state
		_current_state.enter()
