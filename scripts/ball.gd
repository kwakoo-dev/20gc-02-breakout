extends CharacterBody2D

const min_speed = 300
const max_speed = 1000

@export var ball_direction = Vector2(150, 150).normalized()
var ball_speed = min_speed
@export var bounce_randomness = 10

const bounce_variance = deg_to_rad(15)

signal brick_destroyed(brick : Node2D)

func _physics_process(delta: float) -> void:
	var collision_detected = move_and_collide(ball_direction * delta * ball_speed)
	
	if collision_detected:
		var collider = collision_detected.get_collider()
		if collider.is_in_group("bricks"):
			brick_destroyed.emit(collider)
		
		var extra_angle = get_bounce_angle_variance()
		ball_direction = ball_direction.bounce(collision_detected.get_normal()).rotated(extra_angle)

func get_bounce_angle_variance() -> float:
	if randi_range(0, 100) < bounce_randomness:
		var sign : int = get_random_sign()
		var angle : float = sign * bounce_variance
		print_debug("Changed the angle by: " + str(angle))
		return angle
	else:
		return 0.0

func get_random_sign() -> int:
	if randi_range(0, 2) == 0:
		return -1
	else:
		return 1

func set_speed_factor(speed_factor : float) -> void:
	ball_speed = (max_speed - min_speed) * speed_factor + min_speed
