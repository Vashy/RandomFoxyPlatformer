extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.

@export var gold_value = 2
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 50
var chase = false
var is_dead = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animation = $AnimatedSprite2D

func _ready():
	animation.play("Idle")

func _physics_process(delta):
	# gravity for frog
	if not is_dead:
		velocity.y += gravity * delta
	if chase:
		if not is_dead:
			animation.play("Jump")
		var direction = (player.global_position - self.global_position).normalized()
		if direction.x > 0:
			animation.flip_h = true
		else:
			animation.flip_h = false	
		velocity.x = direction.x * SPEED
	else:
		if not is_dead:
			animation.play("Idle")
		velocity.x = 0

	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_death_body_entered(body):
	if body.name == "Player":
		body.enemy_defeated()
		death()
		Game.add_gold(gold_value)

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if not is_dead:
			body.hit()
		death()

func death():
	velocity.x = 0
	chase = false
	is_dead = true
	var collision_node = $CollisionShape2D
	if collision_node:
		collision_node.queue_free()
	var player_collision = $PlayerCollision/CollisionShape2D
	if player_collision:
		player_collision.queue_free()
	var damage_collision = $DamageCollision/CollisionShape2D
	if damage_collision:
		damage_collision.queue_free()

	animation.play("Death")
	$DeathSfx.play()

	await animation.animation_finished
	self.queue_free()
