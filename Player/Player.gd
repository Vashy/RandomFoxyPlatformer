extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var player_stats: PlayerStats

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation = get_node("AnimationPlayer")

func _ready():
	player_stats.on_player_death.connect(die)
	printt("player_stats.current_HP", player_stats.current_HP)

func _physics_process(delta):
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
		if velocity.y == 0:
			if animation.current_animation != "Hurt":
				animation.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			if animation.current_animation != "Hurt":
				animation.play("Idle")
	if velocity.y > 0:
		if animation.current_animation != "Hurt":
			animation.play("Fall")

	move_and_slide()

func hit():
	Game.player_hit()
	$Sounds/HitSfx.play()
	animation.play("Hurt")

func enemy_defeated():
	jump()

func jump():
	velocity.y = JUMP_VELOCITY
	$Sounds/JumpSfx.play()
	animation.play("Jump")

func heal():
	player_stats.heal()

func die():
	print("player dead!")
	queue_free()

func calculate_direction_from_input():
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_key_pressed(KEY_A):
		return -1
	if Input.is_key_pressed(KEY_D):
		return 1
	return direction
