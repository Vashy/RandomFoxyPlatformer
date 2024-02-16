extends Resource
class_name PlayerStats

@export var max_HP := 3
@export var current_HP := 3

signal on_player_hit
signal on_player_healed
signal on_player_death

func damage(value: int = 1) -> int:
	if value <= current_HP:
		current_HP -= value
		on_player_hit.emit()
		if current_HP == 0:
			on_player_death.emit()

	return current_HP

func heal(value: int = 1) -> int:
	if current_HP == max_HP:
		return current_HP
	if current_HP + value < max_HP:
		current_HP += value
		on_player_healed.emit()
	else:
		current_HP = max_HP
	return current_HP

func die_now():
	if on_player_death:
		on_player_death.emit()

func reset():
	current_HP = max_HP
