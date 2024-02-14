extends Resource
class_name GameState

var player_prefs: PlayerPrefs = preload("res://Global/PlayerPrefs.tres")
var gold := 0

signal music_preference_changed(bool)

func add_gold(amount: int) -> int:
	gold += amount
	return gold

func reset():
	gold = 0
