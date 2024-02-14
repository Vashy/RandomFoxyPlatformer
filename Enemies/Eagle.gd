extends CharacterBody2D
class_name Eagle

@export var gold_value = 5
var dying = false

func _physics_process(_delta: float):
	move_and_slide()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		body.hit()
		death()

func _on_damage_collision_body_entered(body):
	if body.name == "Player":
		body.enemy_defeated()
		death()

func death():
	velocity.x = 0
	dying = true
	var player_collision = $PlayerCollision/CollisionShape2D
	if player_collision:
		player_collision.queue_free()
	var collision_node = $CollisionShape2D
	if collision_node:
		collision_node.queue_free()
	var damage_collision = $DamageCollision/CollisionShape2D
	if damage_collision:
		damage_collision.queue_free()
	$AnimationPlayer.play("Death")
	$DeathSfx.play()
	Game.add_gold(gold_value)
	await $AnimationPlayer.animation_finished
	self.queue_free()
