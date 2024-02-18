extends State

@export var player: Player
@export var player_stats: PlayerStats
var invincibility_frame := false

func enter():
	%AnimationPlayer.play("Hurt")
	%AnimationPlayer.play("Hurt")
	%Sounds/HitSfx.play()
	%InvincibilityTimer.start()
	hit()

func update(_delta: float):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transitioned.emit(self, "Jump")

func physics_update(_delta: float):
	player._move_based_on_direction()

func hit():
	if invincibility_frame:
		return
	player.modulate = player.HURT_COLOR_MODULATION
	_blink()
	invincibility_frame = true
	player_stats.damage()

func _blink():
	var tween = create_tween()
	for _i in range(3):
		tween.tween_property(player, "modulate:a", 0, 0.1)
		tween.tween_property(player, "modulate:a", 1, 0.1)

func _on_invincibility_timer_timeout():
	invincibility_frame = false
	player.modulate = Color.WHITE
	transitioned.emit(self, "Idle")
