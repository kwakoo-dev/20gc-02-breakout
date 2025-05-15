extends Node2D

func _ready() -> void:
	$Score.text = "Your score: " + str(Globals.score)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
