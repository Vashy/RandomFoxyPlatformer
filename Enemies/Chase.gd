extends State
class_name EagleChaseState

@export var enemy: CharacterBody2D
@export var player_detector: PlayerDetector
@export var move_speed := 100.0

func enter():
	$"../../AnimationPlayer".play("Chase")
	$"../../Danger/AnimationPlayer".play("PopOut")

func exit():
	if $"../../Danger/AnimationPlayer".is_playing():
		$"../../Danger/AnimationPlayer".stop()
		$"../../Danger/ExclamationMark".visible = false

func physics_update(_delta: float):
	if enemy.dying:
		enemy.velocity = Vector2.ZERO
		return
	var distance = player_detector.distance_from_player()
	enemy.velocity = distance.normalized() * move_speed

	if enemy.velocity.x > 0:
		$"../../AnimatedSprite2D".flip_h = true
	elif enemy.velocity.x < 0:
		$"../../AnimatedSprite2D".flip_h = false

	if not player_detector.is_in_proximity():
		transitioned.emit(self, "Idle")
