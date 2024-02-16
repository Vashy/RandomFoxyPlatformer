extends CharacterBody2D
class_name Eagle

@export var difficulty := 5
var dying = false

func _physics_process(_delta: float):
	move_and_slide()

func _on_player_collision_body_entered(body):
	if body.name == "Player" and not body.invincibility_frame:
		body.hit()
		death()

func _on_damage_collision_body_entered(body):
	if body.name == "Player" and not body.invincibility_frame:
		body.enemy_defeated()
		death()

func death():
	velocity.x = 0
	dying = true
	var nodes_to_free: Array[Node2D] = [$PlayerCollision/CollisionShape2D, $CollisionShape2D, $DamageCollision/CollisionShape2D]
	for node in nodes_to_free:
		node.queue_free()
	$AnimationPlayer.play("Death")
	$DeathSfx.play()
	Game.notify_enemy_defeated(difficulty)
	await $AnimationPlayer.animation_finished
	self.queue_free()
