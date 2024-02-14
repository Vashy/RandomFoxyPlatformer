extends Node2D
class_name Collectable

func gold_value():
	return 1

func _on_body_entered(body):
	if body.name == "Player":
		Game.add_gold(gold_value())
		$PickUpSound.play()
		$VanishingBehavior.vanish()
