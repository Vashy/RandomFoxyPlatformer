extends State

@export var enemy: CharacterBody2D

func enter():
	enemy.velocity = Vector2.ZERO
	_free_collisions()
	$"../../DeathSfx".play()
	$"../../AnimationPlayer".play("Death")
	await $"../../AnimationPlayer".animation_finished
	Game.notify_enemy_defeated(enemy.difficulty)
	enemy.queue_free()

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func _free_collisions():
	var nodes_to_free: Array[Node2D] = [
		$"../../PlayerCollision/CollisionShape2D",
		$"../../CollisionShape2D",
		$"../../DamageCollision/CollisionShape2D",
	]
	for node in nodes_to_free:
		node.queue_free()
