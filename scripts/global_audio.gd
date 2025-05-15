extends Node

var brick_destroy_sounds = []

func _ready() -> void:
	brick_destroy_sounds = [
		$BrickDestroySound1,
		$BrickDestroySound2,
		$BrickDestroySound3
	]

func playBrickDestroy() -> void:
	brick_destroy_sounds.pick_random().play()

func playWallBounce() -> void:
	$WallBounce.play()
	
func playPaddleBounce() -> void:
	$PaddleBounce.play()
