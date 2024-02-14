extends Node

var player_stats: PlayerStats = preload("res://Global/player_stats.tres")
var game_state: GameState = preload("res://Global/GameState.tres")

func _ready():
	player_stats.on_player_death.connect(trigger_player_death)

func reset():
	player_stats.reset()
	game_state.reset()

func player_hit():
	player_stats.damage()

func trigger_player_death():
	SoundController.play(SoundController.SoundType.PlayerDeath)
	reset()
	call_deferred("load_game_over_scene")

func add_gold(amount: int) -> int:
	return game_state.add_gold(amount)

func load_game_over_scene():
	get_tree().change_scene_to_file("res://Scenes/GameOverScene.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Saving player_prefs")
		ResourceSaver.save(game_state.player_prefs)
		print("Quitting")

func quit():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
