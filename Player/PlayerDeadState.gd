extends State

@export var player_stats: PlayerStats
@export var player: Player

func enter():
	%AnimationPlayer.play("Hurt")
	die()

func die():
	if player.dead:
		return
	print("player dead!")
	player.dead = true
	SoundController.play(SoundController.SoundType.PlayerDeath)
	_apply_death_effect()

func _apply_death_effect():
	var position_tween = create_tween()
	var rotate_tween = create_tween()
	if Input.is_action_pressed("go_right"):
		position_tween.tween_property(player, "global_position", player.global_position + Vector2(30, -30), 0.1)
		position_tween.tween_property(player, "global_position", player.global_position + Vector2(30, 15), 0.1)
		rotate_tween.tween_property(player, "rotation", 0.5, 0.2)
	else:
		position_tween.tween_property(player, "global_position", player.global_position + Vector2(-30, -30), 0.1)
		position_tween.tween_property(player, "global_position", player.global_position + Vector2(-30, 15), 0.1)
		rotate_tween.tween_property(player, "rotation", -0.5, 0.2)
