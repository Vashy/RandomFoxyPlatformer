extends State
class_name EagleIdleState

@export var enemy: CharacterBody2D
@export var player_detector: PlayerDetector
@export var wander_speed := 50.0

enum IdleStatus { Standing, Wandering }

var move_direction: Vector2
var wander_time: float
var status := IdleStatus.Wandering

func randomize_wander():
	move_direction = Vector2(get_random_x_direction(), 0).normalized()
	wander_time = randf_range(2.1, 3.5)

func enter():
	$"../../AnimationPlayer".play("Idle")
	randomize_wander()

func update(delta: float):
	if status == IdleStatus.Wandering and wander_time > 0:
		wander_time -= delta
	elif status == IdleStatus.Wandering:
		$WaitTimer.start()
		status = IdleStatus.Standing
		enemy.velocity = Vector2.ZERO

func physics_update(_delta: float):
	if enemy and status == IdleStatus.Wandering:
		enemy.velocity = move_direction * wander_speed

	if enemy.velocity.x > 0:
		$"../../AnimatedSprite2D".flip_h = true
	elif enemy.velocity.x < 0:
		$"../../AnimatedSprite2D".flip_h = false

	if player_detector.is_in_proximity():
		transitioned.emit(self, "Chase")

func _on_wait_timer_timeout():
	status = IdleStatus.Wandering
	randomize_wander()

func get_random_x_direction() -> float:
	var x_axis_seed := randf_range(-1, 1)
	if x_axis_seed < 0:
		return -1
	return 1
