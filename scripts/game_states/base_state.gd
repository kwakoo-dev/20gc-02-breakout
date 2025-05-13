extends Node
class_name BaseState

signal finished(next_state: String)

func enter() -> void:
	pass

func exit() -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func input_process(_event: InputEvent) -> void:
	pass
