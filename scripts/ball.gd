extends CharacterBody2D
class_name Ball

signal brick_destroyed(brick : Node2D)
signal death

const min_speed = 300
const max_speed = 1000
const bounce_variance = deg_to_rad(15)

enum State {
	STOPPED,
	MOVING
}


var _default_ball_direction = Vector2(150, -150).normalized()
var ball_direction = _default_ball_direction
var bounce_randomness = 10
var ball_speed = min_speed

var current_state = State.STOPPED

func _physics_process(delta: float) -> void:
	if current_state == State.STOPPED:
		ball_direction = _default_ball_direction
		return
	
	var collision_detected = move_and_collide(ball_direction * delta * ball_speed)
	
	if collision_detected:
		var collider = collision_detected.get_collider()
		if collider.is_in_group("bricks"):
			brick_destroyed.emit(collider)
		if collider.is_in_group("death_zone"):
			death.emit()
		
		var extra_angle = get_bounce_angle_variance()
		ball_direction = ball_direction.bounce(collision_detected.get_normal()).rotated(extra_angle)

func get_bounce_angle_variance() -> float:
	if randi_range(0, 100) < bounce_randomness:
		var angle_sign : int = get_random_sign()
		var angle : float = angle_sign * bounce_variance
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
