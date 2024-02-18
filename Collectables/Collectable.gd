extends Node2D
class_name Collectable

func gold_value():
	return 1

func on_body_entered(body: Node2D, collision_to_free: Node2D):
	if body is Player:
		collision_to_free.queue_free()
		Game.add_gold(gold_value())
		$PickUpSound.play()
		$VanishingBehavior.vanish()
