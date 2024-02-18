extends ResourceAction
class_name HealResourceAction

@export var player_stats: PlayerStats

func execute():
	player_stats.heal()

func is_action_enabled() -> bool:
	return not player_stats.is_full_health()
