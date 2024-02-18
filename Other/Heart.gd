extends Area2D

func _on_body_entered(body):
	if body is Player:
		body.heal()
		$PickUpSound.play()
		$VanishingBehavior.vanish()
