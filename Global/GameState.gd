extends Resource
class_name GameState

@export var player_stats: PlayerStats

signal on_gold_changed(int)

var gold := 0:
	set(value):
		if value >= 0:
			gold = value
			on_gold_changed.emit(gold)
		else:
			print("Gold can't be negative")

func add_gold(amount: int) -> int:
	gold += amount
	return gold

func spend_gold(amount: int) -> int:
	gold -= amount
	return gold

func reset():
	gold = 0
