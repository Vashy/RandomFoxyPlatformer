extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var player_stats: PlayerStats

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dead := false
var invincibility_frame := false
const HURT_COLOR_MODULATION = Color("#9a0025")

func _ready():
	player_stats.on_player_death.connect(die)

func _physics_process(delta):
	if dead:
		return

	if Input.is_key_pressed(KEY_R): # Debug mode
		get_tree().reload_current_scene()

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = calculate_direction_from_input()
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0 and $AnimationPlayer.current_animation != "Hurt":
			$AnimationPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 and $AnimationPlayer.current_animation != "Hurt":
			$AnimationPlayer.play("Idle")
	if velocity.y > 0 and $AnimationPlayer.current_animation != "Hurt":
		$AnimationPlayer.play("Fall")

	move_and_slide()

func hit():
	if invincibility_frame:
		return
	modulate = HURT_COLOR_MODULATION
	_blink()
	invincibility_frame = true
	Game.player_hit()
	$AnimationPlayer.play("Hurt")
	$Sounds/HitSfx.play()
	$InvincibilityTimer.start()

func enemy_defeated():
	jump()

func jump():
	velocity.y = JUMP_VELOCITY
	$Sounds/JumpSfx.play()
	if not dead:
		$AnimationPlayer.play("Jump")

func heal():
	player_stats.heal()

func die():
	if dead:
		return
	dead = true
	print("player dead!")
	$AnimationPlayer.play("Hurt")
	SoundController.play(SoundController.SoundType.PlayerDeath)
	_apply_death_effect()

func calculate_direction_from_input():
	return Input.get_axis("ui_left", "ui_right")

func _apply_death_effect():
	var position_tween = create_tween()
	var rotate_tween = create_tween()
	if Input.is_action_pressed("ui_right"):
		position_tween.tween_property(self, "global_position", global_position + Vector2(30, -30), 0.1)
		position_tween.tween_property(self, "global_position", global_position + Vector2(30, 15), 0.1)
		rotate_tween.tween_property(self, "rotation", 0.5, 0.2)
	else:
		position_tween.tween_property(self, "global_position", global_position + Vector2(-30, -30), 0.1)
		position_tween.tween_property(self, "global_position", global_position + Vector2(-30, 15), 0.1)
		rotate_tween.tween_property(self, "rotation", -0.5, 0.2)

func _on_invincibility_timer_timeout():
	invincibility_frame = false
	modulate = Color.WHITE

func _blink():
	var tween = create_tween()
	for _i in range(3):
		tween.tween_property(self, "modulate:a", 0, 0.1)
		tween.tween_property(self, "modulate:a", 1, 0.1)
