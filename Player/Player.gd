extends CharacterBody2D
class_name Player

const SPEED = 260.0
const JUMP_VELOCITY = -400.0

@export var player_stats: PlayerStats
@export var HURT_COLOR_MODULATION := Color("#9a0025")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dead := false

func _ready():
	player_stats.on_player_death.connect(func (): %StateMachine.force_change_state("Dead"))

func _physics_process(delta):
	if dead:
		return

	if Input.is_action_just_pressed("debug_restart"): # Debug mode
		get_tree().reload_current_scene()

	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = calculate_direction_from_input()
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	_flip_sprite_to_direction(direction)

	if velocity.y > 0 and %StateMachine.current_state.name != "Fall":
		%StateMachine.force_change_state("Fall")

	move_and_slide()

func enemy_defeated():
	jump(JUMP_VELOCITY / 3 * 2)

func jump(jump_velocity: float = JUMP_VELOCITY):
	velocity.y = jump_velocity
	$Sounds/JumpSfx.play()
	if not dead:
		$AnimationPlayer.play("Jump")

func heal():
	player_stats.heal()

func hit():
	if %StateMachine.current_state.name not in ["Dead", "Hurt"]:
		%StateMachine.force_change_state("Hurt")

func calculate_direction_from_input():
	return Input.get_axis("go_left", "go_right")

func is_invincible() -> bool:
	return $StateMachine/Hurt.invincibility_frame

func _move_based_on_direction():
	var direction = calculate_direction_from_input()
	if direction:
		velocity.x = direction * SPEED

func _flip_sprite_to_direction(direction: float):
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
