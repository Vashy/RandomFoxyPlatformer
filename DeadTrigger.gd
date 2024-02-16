extends Area2D

@export var player_stats: PlayerStats

func _on_body_entered(body):
	if body.name == "Player":
		player_stats.die_now()
