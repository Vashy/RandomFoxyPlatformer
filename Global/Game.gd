extends Node

var gold = 0
var player_stats: PlayerStats = preload("res://Global/player_stats.tres")

func _ready():
	player_stats.on_player_death.connect(trigger_player_death)

func reset():
	player_stats.reset()
	gold = 0

func player_hit():
	player_stats.damage()

func trigger_player_death():
	SoundController.play(SoundController.SoundType.PlayerDeath)
	reset()
	Utils.saveGame()
	call_deferred("load_game_over_scene")

func add_gold(amount: int) -> int:
	gold += amount
	return gold

func load_game_over_scene():
	get_tree().change_scene_to_file("res://Scenes/GameOverScene.tscn")
