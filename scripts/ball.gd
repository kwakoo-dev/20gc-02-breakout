extends CharacterBody2D

@export var ball_velocity = Vector2(150, 150)

func _physics_process(delta: float) -> void:
	var collision_detected = move_and_collide(ball_velocity * delta)
	if collision_detected:
		ball_velocity = ball_velocity.bounce(collision_detected.get_normal())
