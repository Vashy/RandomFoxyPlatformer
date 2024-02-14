extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		body.heal()
		$PickUpSound.play()
		$VanishingBehavior.vanish()
