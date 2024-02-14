extends Node

const SAVE_PATH = "res://savegame.bin"
var player_stats: PlayerStats = preload("res://Global/player_stats.tres") as PlayerStats

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": player_stats.current_HP,
		"gold": Game.gold,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.gold = current_line["gold"]
				player_stats.current_HP = current_line["playerHP"]
