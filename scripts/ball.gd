extends CharacterBody2D

@export var ball_velocity = Vector2(150, 150)
@export var bounce_randomness = 10

const bounce_variance = deg_to_rad(15)

signal brick_destroyed(brick : Node2D)

func _physics_process(delta: float) -> void:
	var collision_detected = move_and_collide(ball_velocity * delta)
	
	if collision_detected:
		var collider = collision_detected.get_collider()
		if collider.is_in_group("bricks"):
			print_debug("collided with brick")
			brick_destroyed.emit(collider)
		
		var extra_angle = get_bounce_angle_variance()
		ball_velocity = ball_velocity.bounce(collision_detected.get_normal()).rotated(extra_angle)

func get_bounce_angle_variance() -> int:
	if randi_range(0, 100) < bounce_randomness:
		var sign = get_random_sign()
		var angle = sign * bounce_variance
		print_debug("Changed the angle by: " + str(angle))
		return angle
	else:
		return 0

func get_random_sign() -> int:
	if randi_range(0, 2) == 0:
		return -1
	else:
		return 1
